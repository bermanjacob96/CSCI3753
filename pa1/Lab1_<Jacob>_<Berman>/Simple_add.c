#include <linux/kernel.h>
#include <linux/linkage.h>
 asmlinkage long sys_add(int num1, int num2, int* result)
{
	*result = (num1+num2);
	printk(KERN_ALERT "Number one:  %d \n", num1);
	printk(KERN_ALERT "Number two: %d \n",num2);
	printk(KERN_ALERT "Sum: %d \n", *result);
	return 0;
}