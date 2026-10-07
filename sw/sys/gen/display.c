
#include "display.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "vm_sys.h"


display_Error display_init(void *framebuffer, uint32_t width, uint32_t height) {
	if (!display_setWidth(width)) {
		return DISPLAY_ERROR_INVALID_WIDTH;
	}
	if (!display_setHeight(height)) {
		return DISPLAY_ERROR_INVALID_HEIGHT;
	}
	if (!display_setFramebuffer(framebuffer)) {
		return DISPLAY_ERROR_INVALID_FRAMEBUFFER;
	}
	*vm_sys_reg(VM_SYS_DISPLAY_CR) = VM_SYS_DISPLAY_CR_EN;
	if ((*vm_sys_reg(VM_SYS_DISPLAY_SR) & VM_SYS_DISPLAY_SR_ON) == 0x0) {
		return DISPLAY_ERROR_CANNOT_ENABLE;
	}
	return DISPLAY_ERROR_NONE;
}
//
// Getters and setters for the display controller registers
//


bool display_setWidth(uint32_t width) {
	*vm_sys_reg(VM_SYS_DISPLAY_WIDTH) = width;
	return display_getWidth() == width;
}


bool display_setHeight(uint32_t height) {
	*vm_sys_reg(VM_SYS_DISPLAY_HEIGHT) = height;
	return display_getHeight() == height;
}


bool display_setFramebuffer(void *framebuffer) {
	*vm_sys_reg(VM_SYS_DISPLAY_FB) = (uint32_t)framebuffer;
	return display_getFramebuffer() == framebuffer;
}


uint32_t display_getWidth(void) {
	return *vm_sys_reg(VM_SYS_DISPLAY_WIDTH);
}


uint32_t display_getHeight(void) {
	return *vm_sys_reg(VM_SYS_DISPLAY_HEIGHT);
}


void *display_getFramebuffer(void) {
	return (void *)*vm_sys_reg(VM_SYS_DISPLAY_FB);
}


uint32_t display_getFrameCounter(void) {
	return *vm_sys_reg(VM_SYS_DISPLAY_FRAME_COUNTER);
}


uint32_t display_getStatus(void) {
	return *vm_sys_reg(VM_SYS_DISPLAY_SR);
}


uint32_t display_getError(void) {
	return *vm_sys_reg(VM_SYS_DISPLAY_ER);
}

