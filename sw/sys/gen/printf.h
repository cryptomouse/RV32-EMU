
#if !defined(PRINTF_H)
#define PRINTF_H
#include "system.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdarg.h>
void putchar(char c);
void put_str8(char *s);
int32_t print(char *form, ...);
int32_t printf(char *form, ...);
#endif

