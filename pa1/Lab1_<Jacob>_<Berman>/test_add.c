
#include <unistd.h>
#include <sys/syscall.h>
#include <stdio.h>

int main()
{
int a ,b;

int answer;
int x =syscall(327,2,3,&answer);
printf("%d\n", x);


}
