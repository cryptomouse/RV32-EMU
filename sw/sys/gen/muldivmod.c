
#include "muldivmod.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
// 32-bit mul/div/mod: rv32i has no M extension at all.
// Signed variants work on magnitudes and fix the sign afterwards.
// x / 0 follows RISC-V div: quotient = all ones, remainder = dividend

static uint32_t mul32(uint32_t a, uint32_t b) {
	uint32_t r = 0;
	uint32_t x = a;
	uint32_t y = b;
	while (y != 0x0) {
		if ((y & 0x1) != 0x0) {
			r = r + x;
		}
		x = x << 1;
		y = y >> 1;
	}
	return r;
}

int32_t __mulsi3(int32_t a, int32_t b) {
	return (int32_t)mul32((uint32_t)a, (uint32_t)b);
}
struct div_mod32 {
	uint32_t quot;
	uint32_t rem;
};

static struct div_mod32 udivmod32(uint32_t n, uint32_t d) {
	if (d >> 31 != 0x0) {
		if (n >= d) {
			return (struct div_mod32){.quot = 1, .rem = n - d};
		}
		return (struct div_mod32){.quot = 0, .rem = n};
	}
	uint32_t q = 0;
	uint32_t r = 0;
	uint32_t i = 32;
	while (i > 0) {
		i = i - 1;
		r = ((r << 1) | ((n >> i) & 0x1));
		q = q << 1;
		if (r >= d) {
			r = r - d;
			q = q | 0x1;
		}
	}
	return (struct div_mod32){.quot = q, .rem = r};
}

static uint32_t neg32(uint32_t x) {
	return (~x) + 1;
}

static uint32_t absInt32(int32_t x) {
	const uint32_t u = (uint32_t)x;
	if (x < 0) {
		return neg32(u);
	}
	return u;
}

static int32_t toInt32(uint32_t x) {
	return (int32_t)x;
}

uint32_t __udivsi3(uint32_t divident, uint32_t divisor) {
	return udivmod32(divident, divisor).quot;
}

uint32_t __umodsi3(uint32_t divident, uint32_t divisor) {
	return udivmod32(divident, divisor).rem;
}

int32_t __divsi3(int32_t divident, int32_t divisor) {
	if (divisor == 0) {
		return -1;
	}
	const uint32_t q = udivmod32(absInt32(divident), absInt32(divisor)).quot;
	if ((divident < 0) != (divisor < 0)) {
		return toInt32(neg32(q));
	}
	return toInt32(q);
}

int32_t __modsi3(int32_t divident, int32_t divisor) {
	const uint32_t r = udivmod32(absInt32(divident), absInt32(divisor)).rem;
	if (divident < 0) {
		return toInt32(neg32(r));
	}
	return toInt32(r);
}
// 64-bit div/mod: rv32im's div/rem are 32-bit only,
// so the compiler calls these for Int64/Nat64 '/' and '%'.
// x / 0 follows RISC-V div: quotient = all ones, remainder = dividend
struct div_mod64 {
	uint64_t quot;
	uint64_t rem;
};

static struct div_mod64 udivmod64(uint64_t n, uint64_t d) {
	if (d >> 63 != 0x0) {
		if (n >= d) {
			return (struct div_mod64){.quot = 1, .rem = n - d};
		}
		return (struct div_mod64){.quot = 0, .rem = n};
	}
	uint64_t q = 0;
	uint64_t r = 0;
	uint32_t i = 64;
	while (i > 0) {
		i = i - 1;
		r = ((r << 1) | ((n >> i) & 0x1));
		q = q << 1;
		if (r >= d) {
			r = r - d;
			q = q | 0x1;
		}
	}
	return (struct div_mod64){.quot = q, .rem = r};
}

static uint64_t neg64(uint64_t x) {
	return (~x) + 1;
}

static uint64_t absInt64(int64_t x) {
	const uint64_t u = (uint64_t)x;
	if (x < 0) {
		return neg64(u);
	}
	return u;
}

static int64_t toInt64(uint64_t x) {
	return (int64_t)x;
}

uint64_t __udivdi3(uint64_t divident, uint64_t divisor) {
	return udivmod64(divident, divisor).quot;
}

uint64_t __umoddi3(uint64_t divident, uint64_t divisor) {
	return udivmod64(divident, divisor).rem;
}

int64_t __divdi3(int64_t divident, int64_t divisor) {
	if (divisor == 0) {
		return -1;
	}
	const uint64_t q = udivmod64(absInt64(divident), absInt64(divisor)).quot;
	if ((divident < 0) != (divisor < 0)) {
		return toInt64(neg64(q));
	}
	return toInt64(q);
}

int64_t __moddi3(int64_t divident, int64_t divisor) {
	const uint64_t r = udivmod64(absInt64(divident), absInt64(divisor)).rem;
	if (divident < 0) {
		return toInt64(neg64(r));
	}
	return toInt64(r);
}

int64_t __muldi3(int64_t a, int64_t b) {
	uint64_t r = 0;
	uint64_t x = (uint64_t)a;
	uint64_t y = (uint64_t)b;
	while (y != 0x0) {
		if ((y & 0x1) != 0x0) {
			r = r + x;
		}
		x = x << 1;
		y = y >> 1;
	}
	return (int64_t)r;
}

