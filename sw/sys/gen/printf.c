
#include "printf.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "system.h"
#include <stdarg.h>

void putchar(char c) {
	char x = c;
	(void)write(0, (uint8_t *)&x, 1);
}

void put_str8(char *s) {
	uint32_t i = 0;
	while (s[i] != (char)0) {
		putchar(s[i]);
		++i;
	}
}

static void vprint(char *form, va_list va);

int32_t print(char *form, ...) {
	va_list va;
	va_start(va, form);
	vprint(form, va);
	va_end(va);
	return 0;
}

int32_t printf(char *form, ...) {
	va_list va;
	va_start(va, form);
	vprint(form, va);
	va_end(va);
	return 0;
}

__attribute__((always_inline))
static inline bool isDigit(char c);
__attribute__((always_inline))
static inline int32_t digitValue(char c);
static void sprintfDec32(char *buf, int32_t d);
static void sprintfHex32(char *buf, uint32_t d, char alpha);

static void vprint(char *form, va_list va) {
	uint32_t i = 0;
	while (form[i] != (char)0) {
		char c = form[i];
		if (c != '%') {
			putchar(c);
			++i;
			continue;
		}
		++i;
		c = form[i];
		char pad = ' ';
		if (c == '0') {
			pad = c;
			++i;
			c = form[i];
		}
		int32_t width = 0;
		while (isDigit(c)) {
			width = width * 10 + digitValue(c);
			++i;
			c = form[i];
		}
		char buf[11 + 1] = {0};
		char *sptr = (char *)buf;
		if (c == 'd' || c == 'i') {
			sprintfDec32(buf, va_arg(va, int32_t));
		} else if (c == 'x') {
			sprintfHex32(buf, va_arg(va, uint32_t), 'a');
		} else if (c == 'X') {
			sprintfHex32(buf, va_arg(va, uint32_t), 'A');
		} else if (c == 's') {
			sptr = va_arg(va, char *);
		} else if (c == 'c') {
			buf[0] = (char)(uint8_t)(uint32_t)va_arg(va, int32_t);
		} else if (c == '%') {
			sptr = "%";
		}
		int32_t len = 0;
		while (sptr[len] != (char)0) {
			++len;
		}
		while (len < width) {
			putchar(pad);
			++len;
		}
		put_str8(sptr);
		++i;
	}
}

__attribute__((always_inline))
static inline bool isDigit(char c) {
	const uint8_t x = (uint8_t)c;
	return x >= (uint8_t)'0' && x <= (uint8_t)'9';
}

__attribute__((always_inline))
static inline int32_t digitValue(char c) {
	return (int32_t)((uint8_t)c - (uint8_t)'0');
}

static void sprintfHex32(char *buf, uint32_t d, char alpha) {
	char cc[8] = {0};
	uint32_t x = d;
	uint32_t i = 0;
	while (true) {
		const uint8_t n = (uint8_t)(x & 0xF);
		x = x >> 4;
		if (n <= 9) {
			cc[i] = (char)((uint8_t)'0' + n);
		} else {
			cc[i] = (char)((uint8_t)alpha + (n - 10));
		}
		++i;
		if (x == 0x0) {
			break;
		}
	}
	uint32_t j = 0;
	while (i != 0) {
		--i;
		buf[j] = cc[i];
		++j;
	}
	buf[j] = (char)0;
}

static void sprintfDec32(char *buf, int32_t d) {
	char cc[11] = {0};
	const bool neg = d < 0;
	int32_t x = d;
	if (neg) {
		x = -d;
	}
	uint32_t i = 0;
	while (true) {
		const int32_t n = x % 10;
		x = x / 10;
		cc[i] = (char)((uint8_t)'0' + (uint8_t)(uint32_t)n);
		++i;
		if (x == 0) {
			break;
		}
	}
	uint32_t j = 0;
	if (neg) {
		buf[0] = '-';
		++j;
	}
	while (i != 0) {
		--i;
		buf[j] = cc[i];
		++j;
	}
	buf[j] = (char)0;
}

