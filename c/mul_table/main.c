#include <stdint.h>
#include <stdarg.h>

#include "../sys/printf.h"
#include "../sys/console.h"
#include "../sys/system.h"
#include "../sys/base.h"
#include "../sys/vm_sys.h"


#define N  9


// printf из sys не поддерживает ширину поля, поэтому выравниваем вручную
static void print_num(int n, int width) {
	int digits = 1;
	int x = n;
	while (x >= 10) {
		x = x / 10;
		digits = digits + 1;
	}

	int i = digits;
	while (i < width) {
		printf(" ");
		i = i + 1;
	}

	printf("%d", n);
}


int main() {
	printf("Multiplication table %dx%d\n\n", N, N);

	// header
	printf("   |");
	for (int j = 1; j <= N; j++) {
		print_num(j, 4);
	}
	printf("\n");

	printf("---+");
	for (int j = 1; j <= N; j++) {
		printf("----");
	}
	printf("\n");

	// rows
	for (int i = 1; i <= N; i++) {
		print_num(i, 2);
		printf(" |");
		for (int j = 1; j <= N; j++) {
			print_num(i * j, 4);
		}
		printf("\n");
	}

	return 0;
}
