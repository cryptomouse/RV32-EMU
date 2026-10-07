
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
typedef uint32_t display_Pixel;
display_Error display_init(void *framebuffer, uint32_t width, uint32_t height);

__attribute__((always_inline))
inline void display_update(void) {
	*vm_sys_reg(VM_SYS_DISPLAY_CR) = VM_SYS_DISPLAY_CR_EN | VM_SYS_DISPLAY_CR_REFRESH;
}
//
// Getters and setters for the display controller registers
//
bool display_setWidth(uint32_t width);
bool display_setHeight(uint32_t height);
bool display_setFramebuffer(void *framebuffer);
uint32_t display_getWidth(void);
uint32_t display_getHeight(void);
void *display_getFramebuffer(void);
uint32_t display_getFrameCounter(void);
uint32_t display_getStatus(void);
uint32_t display_getError(void);
#endif

