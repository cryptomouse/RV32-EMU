
#if !defined(SYSTEM_H)
#define SYSTEM_H
#include "console.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
int32_t write(int32_t fd, uint8_t *data, int32_t len);
#endif

