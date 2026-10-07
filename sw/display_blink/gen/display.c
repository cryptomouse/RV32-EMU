
#include "display.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "vm_sys.h"


bool display_init(void *framebuffer, uint32_t width, uint32_t height) {
	*vm_sys_reg(VM_SYS_DISPLAY_WIDTH) = width;
	*vm_sys_reg(VM_SYS_DISPLAY_HEIGHT) = height;
	*vm_sys_reg(VM_SYS_DISPLAY_FB) = (uint32_t)framebuffer;
	*vm_sys_reg(VM_SYS_DISPLAY_CR) = VM_SYS_DISPLAY_CR_EN;
	if ((*vm_sys_reg(VM_SYS_DISPLAY_SR) & VM_SYS_DISPLAY_SR_ON) == 0x0) {
		return false;
	}
	return true;
}


void display_update(void) {
	*vm_sys_reg(VM_SYS_DISPLAY_REFRESH) = 0x1;
}

