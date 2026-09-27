
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
volatile int32_t __mtrap_flag = 0;

int main(void) {
	printf("Hello World!\n");
	if (__mtrap_flag != 0) {
		printf("Machine trap occurred!\n");
	} else {
		printf("No machine trap occurred.\n");
	}
	return 0;
}

void __isr(void) {
	__mtrap_flag = 1;
}

