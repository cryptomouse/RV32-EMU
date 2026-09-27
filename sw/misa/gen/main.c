
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
extern uint32_t read_misa(void);
extern uint32_t read_mhartid(void);
extern uint64_t read_mcycle(void);
extern void ecall(void);
extern void ebreak(void);

static void printMisa(uint32_t misa);

int main(void) {
	printf("Hello World!\n");
	const uint32_t misa = read_misa();
	printf("misa = 0x%x\n", misa);
	printMisa(misa);
	const uint32_t mhartid = read_mhartid();
	printf("mhartid = %d\n", mhartid);
	const uint64_t mcycle = read_mcycle();
	printf("mcycle = %d\n", (uint32_t)mcycle);
	ecall();
	ebreak();
	return 0;
}

static void printMisa(uint32_t misa) {
	const uint32_t xlenBits = misa >> 30;
	char *xlenStr = "_unknown_";
	if (xlenBits == 0x1) {
		xlenStr = "32";
	} else if (xlenBits == 0x2) {
		xlenStr = "64";
	} else if (xlenBits == 0x3) {
		xlenStr = "128";
	}
	printf("rv%s", xlenStr);
	char *const exts = "abcdefghijklmnopqrstuvwxyz";
	uint32_t i = 0;
	while (i < 26) {
		if ((misa & ((uint32_t)1 << i)) != 0x0) {
			printf("%c", exts[i]);
		}
		++i;
	}
	printf("\n");
}

