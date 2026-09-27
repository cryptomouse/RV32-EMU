
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#define N ((int32_t)9)

static void printNum(int32_t x, int32_t width) {
	int32_t digits = 1;
	int32_t y = x;
	while (y >= 10) {
		y = y / 10;
		digits = digits + 1;
	}
	int32_t i = digits;
	while (i < width) {
		printf(" ");
		i = i + 1;
	}
	printf("%d", x);
}


int main(void) {
	printf("Multiplication table %dx%d\n\n", N, N);
	printf("   |");
	int32_t j = 1;
	while (j <= N) {
		printNum(j, 4);
		++j;
	}
	printf("\n");
	printf("---+");
	j = 1;
	while (j <= N) {
		printf("----");
		++j;
	}
	printf("\n");
	int32_t i = 1;
	while (i <= N) {
		printNum(i, 2);
		printf(" |");
		j = 1;
		while (j <= N) {
			printNum(i * j, 4);
			++j;
		}
		printf("\n");
		++i;
	}
	return 0;
}

