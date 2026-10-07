
#if !defined(DISPLAY_H)
#define DISPLAY_H
#include "vm_sys.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
typedef uint32_t display_Error;
#define DISPLAY_ERROR_NONE ((display_Error)0)
#define DISPLAY_ERROR_INVALID_WIDTH ((display_Error)1)
#define DISPLAY_ERROR_INVALID_HEIGHT ((display_Error)2)
#define DISPLAY_ERROR_INVALID_FRAMEBUFFER ((display_Error)3)
#define DISPLAY_ERROR_CANNOT_ENABLE ((display_Error)4)
#define DISPLAY_ERROR_UNKNOWN ((display_Error)0xFFFFFFFFUL)
display_Error display_init(void *framebuffer, uint32_t width, uint32_t height);
void display_update(void);
#endif

