
#include "muldivmod.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

int32_t __mulsi3(int32_t a, int32_t b) {
	int32_t n = 0;
	int32_t i = b;
	while (i != 0) {
		n = n + a;
		i = i - 1;
	}
	return n;
}

int32_t __modsi3(int32_t divident, int32_t divisor) {
	if (divisor == 0) {
		return -1;
	}
	int32_t x = divident;
	while (x >= divisor) {
		x = x - divisor;
	}
	return x;
}

int32_t __divsi3(int32_t divident, int32_t divisor) {
	if (divisor == 0) {
		return -1;
	}
	int32_t x = divident;
	int32_t r = 0;
	while (true) {
		x = x - divisor;
		if (x < 0) {
			break;
		}
		r = r + 1;
		if (x == 0) {
			break;
		}
	}
	return r;
}

