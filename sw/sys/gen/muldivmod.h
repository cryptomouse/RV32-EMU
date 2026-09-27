
#if !defined(MULDIVMOD_H)
#define MULDIVMOD_H
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
int32_t __mulsi3(int32_t a, int32_t b);
int32_t __modsi3(int32_t divident, int32_t divisor);
int32_t __divsi3(int32_t divident, int32_t divisor);
#endif

