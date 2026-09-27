
#if !defined(STARTUP_H)
#define STARTUP_H
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
__attribute__((section(".startup")))
void startup(void);
#endif

