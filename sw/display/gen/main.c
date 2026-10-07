
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include "vm_sys.h"
#include "display.h"
#define FRAME_WIDTH 640
#define FRAME_HEIGHT 480
#define FRAMES 1024
static display_Pixel frameBuffer[FRAME_HEIGHT][FRAME_WIDTH];

static void draw(uint32_t offset);

int main(void) {
	printf("display demo: %dx%d, %d frames\n", FRAME_WIDTH, FRAME_HEIGHT, FRAMES);
	const display_Error error = display_init(frameBuffer, FRAME_WIDTH, FRAME_HEIGHT);
	if (error != DISPLAY_ERROR_NONE) {
		printf("display demo: cannot setup display, error: %d, ER: 0x%08x\n", error, display_getError());
		return 1;
	}
	uint32_t offset = 0;
	while (offset < FRAMES) {
		draw(offset);
		display_update();
		const uint32_t e = display_getError();
		if (e != 0x0) {
			printf("display demo: error, ER: 0x%08x\n", e);
			if ((e & VM_SYS_DISPLAY_ER_LINK) != 0x0) {
				printf("display demo: link to the display lost\n");
			}
			break;
		}
		++offset;
	}
	printf("frames shown: %d\n", display_getFrameCounter());
	return 0;
}


static void draw(uint32_t offset) {
	uint32_t y = 0;
	while (y < FRAME_HEIGHT) {
		uint32_t x = 0;
		while (x < FRAME_WIDTH) {
			const uint32_t r = ((x + offset) % 256);
			const uint32_t g = ((y + offset) % 256);
			const uint32_t b = 128;
			frameBuffer[y][x] = (0xFF000000UL | (r << 16) | (g << 8) | b);
			++x;
		}
		++y;
	}
}

