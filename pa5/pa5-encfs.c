/*
  FUSE: Filesystem in Userspace
  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>

  Minor modifications and note by Andy Sayler (2012) <www.andysayler.com>

  Source: fuse-2.8.7.tar.gz examples directory
  http://sourceforge.net/projects/fuse/files/fuse-2.X/

  This program can be distributed under the terms of the GNU GPL.
  See the file COPYING.

  gcc -Wall `pkg-config fuse --cflags` fusexmp.c -o fusexmp `pkg-config fuse --libs`

  Note: This implementation is largely stateless and does not maintain
        open file handels between open and release calls (fi->fh).
        Instead, files are opened and closed as necessary inside read(), write(),
        etc calls. As such, the functions that rely on maintaining file handles are
        not implmented (fgetattr(), etc). Those seeking a more efficient and
        more complete implementation may wish to add fi->fh support to minimize
        open() and close() calls and support fh dependent functions.
 
 
 * File: pa5-encfs.c
 * Modified: Jacob Berman
 * Project: CSCI 3753 Programming Assignment 5
 * Created Date: 11/25/2016
 * Modified Date: 11/25/2016
 * Description:
 */


#define FUSE_USE_VERSION 28
#define HAVE_SETXATTR

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#ifdef linux
/* For pread()/pwrite() */
#define _XOPEN_SOURCE 500
#define ENOATTR ENODATA

#endif

#include <fuse.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <dirent.h>
#include <errno.h>
#include <sys/time.h>
#include <limits.h>
#ifdef HAVE_SETXATTR
#include <sys/xattr.h>
#include <stdlib.h>
#endif

/* For encryption and decryption */
#include "aes-crypt.h"

/* For XATTR Encrypted Flags */
#define ENCRYPT 1
#define DECRYPT 0
#define PASS_THROUGH -1

#define FLAG "user.pa5-encfs.encrypted"

#define DATA ((pathStruct *) fuse_get_context()->private_data)

//Create a struct to hold the path I want to use to the mirror point
//This will allow multiple processes using fuse, to have access to the information
//Because we store the struct in private_data
typedef struct 
{
	char* rootDir;
	char* key;
	int myTime;
}pathStruct;
/*
char* thePath(const char *get_new_path){
    int len = strlen(get_new_path) + strlen(ENCRYPTION_PARAMS->directory) + 1;
    char* new_path = malloc(sizeof(char) * len);
    strcat(new_path, get_new_path);
    return new_path;
}
*/
/*
static char * ftemp(const char *path, const char *suffix){
	char * tmp_path;
	int len = strlen(path) + strlen(suffix) + 1; 
	if( !(tmp_path = malloc(sizeof(char)* len)) ){
		fprintf(stderr, "Error allocating temproary file in %s function.\n", suffix);
		exit(EXIT_FAILURE);
	}
	tmp_path[0] = '\0';
	strcat(strcat(tmp_path,path),suffix);
	return tmp_path;
}

*/
/* Function for changing paths of all the functions to the specific mirror directory instead of root */
static void xmp_fullpath(char fpath[PATH_MAX], const char *path)
{
	//encryptionStruct *fpath = (struct encryptionStruct *) fuse_get_context()->private_data)
    strcpy(fpath, DATA->rootDir);
    strncat(fpath, path, PATH_MAX);

}
static int xmp_getattr(const char *path, struct stat *stbuf)
{
    /* change path to specific mirror directory instead of root */
    char fpath[PATH_MAX];
    xmp_fullpath(fpath, path);
    
    int res;

	res = lstat(fpath, stbuf);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_access(const char *path, int mask)
{
    char fpath[PATH_MAX];
    xmp_fullpath(fpath, path);
    
	int res;

	res = access(fpath, mask);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_readlink(const char *path, char *buf, size_t size)
{
    char fpath[PATH_MAX];
    xmp_fullpath(fpath, path);
    
	int res;

	res = readlink(fpath, buf, size - 1);
	if (res == -1)
		return -errno;

	buf[res] = '\0';
	return 0;
}


static int xmp_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
		       off_t offset, struct fuse_file_info *fi)
{
    char fpath[PATH_MAX];
    xmp_fullpath(fpath, path);
    
	DIR *dp;
	struct dirent *de;

	(void) offset;
	(void) fi;

	dp = opendir(fpath);
	if (dp == NULL)
		return -errno;

	while ((de = readdir(dp)) != NULL) {
		struct stat st;
		memset(&st, 0, sizeof(st));
		st.st_ino = de->d_ino;
		st.st_mode = de->d_type << 12;
		if (filler(buf, de->d_name, &st, 0))
			break;
	}

	closedir(dp);
	return 0;
}

static int xmp_mknod(const char *path, mode_t mode, dev_t rdev)
{
    char fpath[PATH_MAX];
    xmp_fullpath(fpath, path);
    
	int res;

	/* On Linux this could just be 'mknod(path, mode, rdev)' but this
	   is more portable */
	if (S_ISREG(mode)) {
		res = open(fpath, O_CREAT | O_EXCL | O_WRONLY, mode);
		if (res >= 0)
			res = close(res);
	} else if (S_ISFIFO(mode))
		res = mkfifo(path, mode);
	else
		res = mknod(path, mode, rdev);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_mkdir(const char *path, mode_t mode)
{
    char fpath[PATH_MAX];
    xmp_fullpath(fpath, path);
    
	int res;

	res = mkdir(fpath, mode);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_unlink(const char *path)
{
    char fpath[PATH_MAX];
    xmp_fullpath(fpath, path);
    
	int res;

	res = unlink(fpath);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_rmdir(const char *path)
{
    char fpath[PATH_MAX];
    xmp_fullpath(fpath, path);
    
	int res;

	res = rmdir(fpath);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_symlink(const char *from, const char *to)
{
	int res;
    char ffrom[PATH_MAX];
    char fto[PATH_MAX];
    
    xmp_fullpath(ffrom, from);
    xmp_fullpath(fto, to);
    
	res = symlink(ffrom, fto);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_rename(const char *from, const char *to)
{
	int res;
    char ffrom[PATH_MAX];
    char fto[PATH_MAX];
    
    xmp_fullpath(ffrom, from);
    xmp_fullpath(fto, to);

	res = rename(ffrom, fto);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_link(const char *from, const char *to)
{
	int res;
    char ffrom[PATH_MAX];
    char fto[PATH_MAX];
    
    xmp_fullpath(ffrom, from);
    xmp_fullpath(fto, to);

	res = link(ffrom, fto);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_chmod(const char *path, mode_t mode)
{
	int res;
    char fpath[PATH_MAX];
    
    xmp_fullpath(fpath, path);

	res = chmod(fpath, mode);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_chown(const char *path, uid_t uid, gid_t gid)
{
	int res;
    char fpath[PATH_MAX];
    
    xmp_fullpath(fpath, path);

	res = lchown(fpath, uid, gid);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_truncate(const char *path, off_t size)
{
	int res;
    char fpath[PATH_MAX];
    
    xmp_fullpath(fpath, path);

	res = truncate(fpath, size);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_utimens(const char *path, const struct timespec ts[2])
{
	int res;
	struct timeval tv[2];
    char fpath[PATH_MAX];
 	xmp_fullpath(fpath, path);
	tv[0].tv_sec = ts[0].tv_sec;
	tv[0].tv_usec = ts[0].tv_nsec / 1000;
	tv[1].tv_sec = ts[1].tv_sec;
	tv[1].tv_usec = ts[1].tv_nsec / 1000;

	res = utimes(fpath, tv);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_open(const char *path, struct fuse_file_info *fi)
{
	int res;
    char fpath[PATH_MAX];
    
    xmp_fullpath(fpath, path);

	res = open(path, fi->flags);
	if (res == -1)
		return -errno;

	close(res);
	return 0;
}

static int xmp_read(const char *path, char *buf, size_t size, off_t offset,
		    struct fuse_file_info *fi)
{	

	FILE *file, *tmp;
	//int fd;
	int res;
	int crypt_action = PASS_THROUGH;
	char *tmp_data = NULL;
	ssize_t tmp_size = 0;
    char extendedAttr[8];
    ssize_t extendedAttrLength;
	(void) fi;
	char fpath[PATH_MAX];
    xmp_fullpath(fpath, path);
	


	file = fopen(fpath, "r");
	tmp = open_memstream(&tmp_data, & tmp_size);

	if (file == NULL || tmp_data == NULL)
		return -errno;

	extendedAttrLength = getxattr(fpath, FLAG, extendedAttr, 8);

	if(extendedAttrLength != -1 && !memcmp(extendedAttr, FLAG, 4)){
		crypt_action = DECRYPT;

	}

	if(!do_crypt(file, tmp, crypt_action, DATA->key)){
		fprintf(stderr, "do_crypt failed\n");
	}

	fclose(file);
	fflush(tmp);
	fseek(tmp,offset, SEEK_SET);

	res = fread(buf, 1, size, tmp); //read out the file from temp file
	if (res == -1)
		res = -errno;

	fclose(tmp); //close temp file
	return res;
}

static int xmp_write(const char *path, const char *buf, size_t size,
		     off_t offset, struct fuse_file_info *fi)
{
	//int fd;
	int res;
	int crypt_action = PASS_THROUGH;

	ssize_t tmp_size = 0;
	char *tmp_data = NULL;
    char extendedAttr[8];
    ssize_t extendedAttrLength;
	(void) fi;
	char fpath[PATH_MAX];

    xmp_fullpath(fpath, path);

	FILE *file, *tmp;

	file = fopen(fpath, "r");
	tmp = open_memstream(&tmp_data,&tmp_size);

	if (file == NULL || tmp_data == NULL)
		return -errno;

	extendedAttrLength = getxattr(fpath, FLAG, extendedAttr, 8);

	if(extendedAttrLength != -1 && !memcmp(extendedAttr, FLAG, 4)){
		crypt_action = DECRYPT;

	}

	if(!do_crypt(file, tmp, crypt_action, DATA->key)){
		fprintf(stderr, "do_crypt failed\n");
	}
	
	fclose(file);
	fflush(tmp);
	fseek(tmp,offset, SEEK_SET);

	res = fwrite(buf, 1, size, tmp);
	if (res == -1)
		res = -errno;

	fflush(tmp);
	file = fopen(fpath,"w");
	fseek(tmp, 0, SEEK_SET);

	if (crypt_action == DECRYPT){
		crypt_action  == ENCRYPT;
	}
	if(!do_crypt(tmp, file, crypt_action, DATA->key)){
		fprintf(stderr, "do_crypt failed\n");
	}
	fclose(tmp);
	fclose(file);

	return res;
	
}

static int xmp_statfs(const char *path, struct statvfs *stbuf)
{
	int res;
    char fpath[PATH_MAX];
    
    xmp_fullpath(fpath, path);

	res = statvfs(path, stbuf);
	if (res == -1)
		return -errno;

	return 0;
}

static int xmp_create(const char* path, mode_t mode, struct fuse_file_info* fi) {
	int res;
	(void) mode;
    (void) fi;
    char fpath[PATH_MAX];
    xmp_fullpath(fpath, path);
    FILE *file, *tmp;
    ssize_t tmp_size;
    char* tmp_data;

    file = fopen(fpath,"wb+");

    tmp = open_memstream(&tmp_data, &tmp_size);

    if (file == NULL){
    	return -errno;
    }

    if(!do_crypt(tmp, file, ENCRYPT, DATA->key)){
    	fprintf(stderr, "Create: do_crypt failed\n");

    }

    if(setxattr(fpath, FLAG, "true", 4, 0)){
    	fprintf(stderr, "error setting xattr of file %s\n", fpath);
    	return -errno;
}
	else{
		fprintf(stderr, "Create: file xatrr correctly set %s\n", fpath);

	}
	fclose(tmp);
	fclose(file);

    return 0;
}


static int xmp_release(const char *path, struct fuse_file_info *fi)
{
	/* Just a stub.	 This method is optional and can safely be left
	   unimplemented */

	(void) path;
	(void) fi;
	return 0;
}

static int xmp_fsync(const char *path, int isdatasync,
		     struct fuse_file_info *fi)
{
	/* Just a stub.	 This method is optional and can safely be left
	   unimplemented */

	(void) path;
	(void) isdatasync;
	(void) fi;
	return 0;
}

#ifdef HAVE_SETXATTR
static int xmp_setxattr(const char *path, const char *name, const char *value,
			size_t size, int flags)
{
    int res = lsetxattr(path, name, value, size, flags);
    char fpath[PATH_MAX];
    
    xmp_fullpath(fpath, path);
    
	if (res == -1)
		return -errno;
	return 0;
}

static int xmp_getxattr(const char *path, const char *name, char *value,
			size_t size)
{
    int res = lgetxattr(path, name, value, size);
    char fpath[PATH_MAX];
    
    xmp_fullpath(fpath, path);
    
	if (res == -1)
		return -errno;
	return res;
}

static int xmp_listxattr(const char *path, char *list, size_t size)
{
    int res = llistxattr(path, list, size);
    char fpath[PATH_MAX];

    xmp_fullpath(fpath, path);
    
	if (res == -1)
		return -errno;
	return res;
}

static int xmp_removexattr(const char *path, const char *name)
{
    int res = lremovexattr(path, name);
    char fpath[PATH_MAX];

    xmp_fullpath(fpath, path);
    
    if (res == -1)
		return -errno;
	return 0;
}
#endif /* HAVE_SETXATTR */

static struct fuse_operations xmp_oper = {
	.getattr	= xmp_getattr,
	.access		= xmp_access,
	.readlink	= xmp_readlink,
	.readdir	= xmp_readdir,
	.mknod		= xmp_mknod,
	.mkdir		= xmp_mkdir,
	.symlink	= xmp_symlink,
	.unlink		= xmp_unlink,
	.rmdir		= xmp_rmdir,
	.rename		= xmp_rename,
	.link		= xmp_link,
	.chmod		= xmp_chmod,
	.chown		= xmp_chown,
	.truncate	= xmp_truncate,
	.utimens	= xmp_utimens,
	.open		= xmp_open,
	.read		= xmp_read,
	.write		= xmp_write,
	.statfs		= xmp_statfs,
	.create         = xmp_create,
	.release	= xmp_release,
	.fsync		= xmp_fsync,
#ifdef HAVE_SETXATTR
	.setxattr	= xmp_setxattr,
	.getxattr	= xmp_getxattr,
	.listxattr	= xmp_listxattr,
	.removexattr	= xmp_removexattr,
#endif
};

int main(int argc, char *argv[])
{
    umask(0);
    if(argc < 4)
    {
        printf(stderr, "Wrong input...The correct input looks like this...");
        printf(stderr, "./pa5-encfs <key phrase> <rootdir> <mountpoint>\n");
        exit(EXIT_FAILURE);
    }
    /*
    struct encryptionStruct *data;
	data = malloc(sizeof(struct encryptionStruct));
	if (data == NULL) {
		perror("ohnoD:");
		abort();
    }
*/
    pathStruct npath;  //Create a struct object
	npath.rootDir = realpath(argv[2], NULL); //Store the absolute path of the mirror point passed in.  realpath returns the absolute path if it exists, Null if it doesn't
	npath.key = argv[1]; //Store the password phrase to be used for encryption or decryption
	npath.myTime = (time(NULL)%10);
	return fuse_main(argc-2, argv+2, &xmp_oper,(void*) &npath); //reduce argc by 2, for passphrase and mirror point.  Move the array pointer to the mount point
/*
	data->directory = realpath(argv[argc-2], NULL);
	data->key = argv[argc-3];
    argv[argc-3] = argv[argc-1];
    argv[argc-2] = NULL;
    argv[argc-1] = NULL;
    argc -= 2;
	return fuse_main(argc, argv, &xmp_oper, data);

	*/
}