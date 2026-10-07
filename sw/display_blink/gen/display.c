
#include "display.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "vm_sys.h"


display_Error display_init(void *framebuffer, uint32_t width, uint32_t height) {
	*vm_sys_reg(VM_SYS_DISPLAY_WIDTH) = width;
	if (*vm_sys_reg(VM_SYS_DISPLAY_WIDTH) != width) {
		return DISPLAY_ERROR_INVALID_WIDTH;
	}
	*vm_sys_reg(VM_SYS_DISPLAY_HEIGHT) = height;
	if (*vm_sys_reg(VM_SYS_DISPLAY_HEIGHT) != height) {
		return DISPLAY_ERROR_INVALID_HEIGHT;
	}
	*vm_sys_reg(VM_SYS_DISPLAY_FB) = (uint32_t)framebuffer;
	if (*vm_sys_reg(VM_SYS_DISPLAY_FB) != (uint32_t)framebuffer) {
		return DISPLAY_ERROR_INVALID_FRAMEBUFFER;
	}
	*vm_sys_reg(VM_SYS_DISPLAY_CR) = VM_SYS_DISPLAY_CR_EN;
	if ((*vm_sys_reg(VM_SYS_DISPLAY_SR) & VM_SYS_DISPLAY_SR_ON) == 0x0) {
		return DISPLAY_ERROR_CANNOT_ENABLE;
	}
	return DISPLAY_ERROR_NONE;
}


void display_update(void) {
	*vm_sys_reg(VM_SYS_DISPLAY_REFRESH) = 0x1;
}

