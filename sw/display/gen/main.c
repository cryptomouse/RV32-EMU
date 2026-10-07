
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include "vm_sys.h"
#define WIDTH 320
#define HEIGHT 240
#define FRAMES 256
static uint32_t fb[HEIGHT][WIDTH];

static volatile uint32_t *reg(uint32_t adr) {
	return (volatile uint32_t *)adr;
}


static void draw(uint32_t offset) {
	uint32_t y = 0;
	while (y < HEIGHT) {
		uint32_t x = 0;
		while (x < WIDTH) {
			const uint32_t r = ((x + offset) % 256);
			const uint32_t g = ((y + offset) % 256);
			const uint32_t b = 128;
			fb[y][x] = 0xFF000000UL | (r << 16) | (g << 8) | b;
			++x;
		}
		++y;
	}
}


int main(void) {
	printf("display demo: %dx%d, %d frames\n", WIDTH, HEIGHT, FRAMES);
	*reg(VM_SYS_DISPLAY_WIDTH) = WIDTH;
	*reg(VM_SYS_DISPLAY_HEIGHT) = HEIGHT;
	*reg(VM_SYS_DISPLAY_FB) = (uint32_t)fb;
	*reg(VM_SYS_DISPLAY_CR) = VM_SYS_DISPLAY_CR_EN;
	if ((*reg(VM_SYS_DISPLAY_SR) & VM_SYS_DISPLAY_SR_ON) == 0x0) {
		printf("display: cannot enable\n");
		return 1;
	}
	uint32_t offset = 0;
	while (offset < FRAMES) {
		draw(offset);
		*reg(VM_SYS_DISPLAY_REFRESH) = 0x1;
		++offset;
	}
	printf("frames shown: %d\n", *reg(VM_SYS_DISPLAY_FRAME));
	return 0;
}

