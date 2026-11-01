
#if !defined(MULDIVMOD_H)
#define MULDIVMOD_H
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
// 32-bit mul/div/mod: rv32i has no M extension at all.
// Signed variants work on magnitudes and fix the sign afterwards.
// x / 0 follows RISC-V div: quotient = all ones, remainder = dividend
int32_t __mulsi3(int32_t a, int32_t b);
uint32_t __udivsi3(uint32_t divident, uint32_t divisor);
uint32_t __umodsi3(uint32_t divident, uint32_t divisor);
int32_t __divsi3(int32_t divident, int32_t divisor);
int32_t __modsi3(int32_t divident, int32_t divisor);
// 64-bit div/mod: rv32im's div/rem are 32-bit only,
// so the compiler calls these for Int64/Nat64 '/' and '%'.
// x / 0 follows RISC-V div: quotient = all ones, remainder = dividend
uint64_t __udivdi3(uint64_t divident, uint64_t divisor);
uint64_t __umoddi3(uint64_t divident, uint64_t divisor);
int64_t __divdi3(int64_t divident, int64_t divisor);
int64_t __moddi3(int64_t divident, int64_t divisor);
int64_t __muldi3(int64_t a, int64_t b);
#endif

