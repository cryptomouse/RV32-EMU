
#if !defined(DISPLAY_H)
#define DISPLAY_H
#include "vm_sys.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
bool display_init(void *framebuffer, uint32_t width, uint32_t height);
void display_update(void);
#endif

