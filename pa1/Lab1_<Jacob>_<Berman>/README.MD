
          _____                    _____                    _____                    _____                            _____                    _____          
         /\    \                  /\    \                  /\    \                  /\    \                          /\    \                  /\    \         
        /::\    \                /::\    \                /::\    \                /::\    \                        /::\____\                /::\    \        
       /::::\    \              /::::\    \              /::::\    \              /::::\    \                      /::::|   |               /::::\    \       
      /::::::\    \            /::::::\    \            /::::::\    \            /::::::\    \                    /:::::|   |              /::::::\    \      
     /:::/\:::\    \          /:::/\:::\    \          /:::/\:::\    \          /:::/\:::\    \                  /::::::|   |             /:::/\:::\    \     
    /:::/__\:::\    \        /:::/__\:::\    \        /:::/__\:::\    \        /:::/  \:::\    \                /:::/|::|   |            /:::/__\:::\    \    
   /::::\   \:::\    \      /::::\   \:::\    \      /::::\   \:::\    \      /:::/    \:::\    \              /:::/ |::|   |           /::::\   \:::\    \   
  /::::::\   \:::\    \    /::::::\   \:::\    \    /::::::\   \:::\    \    /:::/    / \:::\    \            /:::/  |::|___|______    /::::::\   \:::\    \  
 /:::/\:::\   \:::\____\  /:::/\:::\   \:::\    \  /:::/\:::\   \:::\    \  /:::/    /   \:::\ ___\          /:::/   |::::::::\    \  /:::/\:::\   \:::\    \ 
/:::/  \:::\   \:::|    |/:::/__\:::\   \:::\____\/:::/  \:::\   \:::\____\/:::/____/     \:::|    |        /:::/    |:::::::::\____\/:::/__\:::\   \:::\____\
\::/   |::::\  /:::|____|\:::\   \:::\   \::/    /\::/    \:::\  /:::/    /\:::\    \     /:::|____|        \::/    / ~~~~~/:::/    /\:::\   \:::\   \::/    /
 \/____|:::::\/:::/    /  \:::\   \:::\   \/____/  \/____/ \:::\/:::/    /  \:::\    \   /:::/    /          \/____/      /:::/    /  \:::\   \:::\   \/____/ 
       |:::::::::/    /    \:::\   \:::\    \               \::::::/    /    \:::\    \ /:::/    /                       /:::/    /    \:::\   \:::\    \     
       |::|\::::/    /      \:::\   \:::\____\               \::::/    /      \:::\    /:::/    /                       /:::/    /      \:::\   \:::\____\    
       |::| \::/____/        \:::\   \::/    /               /:::/    /        \:::\  /:::/    /                       /:::/    /        \:::\   \::/    /    
       |::|  ~|               \:::\   \/____/               /:::/    /          \:::\/:::/    /                       /:::/    /          \:::\   \/____/     
       |::|   |                \:::\    \                  /:::/    /            \::::::/    /                       /:::/    /            \:::\    \         
       \::|   |                 \:::\____\                /:::/    /              \::::/    /                       /:::/    /              \:::\____\        
        \:|   |                  \::/    /                \::/    /                \::/____/                        \::/    /                \::/    /        
         \|___|                   \/____/                  \/____/                  ~~                               \/____/                  \/____/         
                                                                                                                                                              



—————————————————————————————————————————————————————————————————————————————————————————————————————————


Contact info:

Jacob Berman
jabe5238@colorado.edu

—————————————————————————————————————————————————————————————————————————————————————————————————————————

Files:

	⁃	Simple_add.c
		- system call for add
		- /home/kernel/linux-4.4.0/arch/x86/kernel/
	⁃	Makefile
	⁃	general Makefile for the linux kernel
	⁃	/home/kernel/linux-4.4.0/arch/x86/kernel/
	⁃	syscall_64.tbl
	⁃	64 bit system call numbers
	⁃	/home/kernel/linux-4.4.0/arch/x86/entry/syscalls/
	⁃	syscalls.h
	⁃	Linux syscalls interface. Links system call so other files can use it. 
	⁃	/home/kernel/linux-4.4.0/include/linux/
	⁃	syslog
	⁃	A report of all operations and actions the kernel since startup.
	⁃	/var/log/
	⁃	test_add.c
	⁃	C program to test the system calls we wrote.

Instructions for Building:

	1.	move Simple_add.c into /home/kernel/linux-4.4.0/arch/x86/kernel/
	2.	move Makefile into /home/kernel/linux-4.4.0/arch/x86/kernel/
	3.	move syscall_64.tbl into /home/kernel/linux-4.4.0/arch/x86/entry/syscalls/
	4.	move syscalls.h into /home/kernel/linux-4.4.0/include/linux/
	5.	compile the kernel using :
	⁃	sudo make -j2 CC="ccache gcc" 
	⁃	sudo make -j2 modules_install 
	⁃	sudo make -j2 install
sudo reboot 
	6.	Compile and run test_add.c using:
	⁃	gcc -o some_name test_add.c
	⁃	./some_name
	7.	Check result from syslog using:
	⁃	dmesg

