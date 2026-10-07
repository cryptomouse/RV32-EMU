
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include "vm_sys.h"
#include "display.h"
static volatile uint32_t tickCounter;
#define FRAME_WIDTH 640
#define FRAME_HEIGHT 480
static display_Pixel frameBuffer[FRAME_HEIGHT][FRAME_WIDTH];
extern void irq_enable(uint32_t mieMask);
#define MIE_TIMER ((uint32_t)1 << 1)

static void init(void);
static void displaySetDot(bool state);

int main(void) {
	printf("display demo: %dx%d\n", FRAME_WIDTH, FRAME_HEIGHT);
	init();
	bool state = true;
	while (true) {
		const uint32_t e = display_getError();
		if (e != 0x0) {
			printf("display demo: error: 0x%08x\n", e);
			break;
		}
		printf("frame %d\n", display_getFrameCounter());
		displaySetDot(state);
		state = !state;
		while (tickCounter < 100000) {
		}
		tickCounter = 0;
	}
	printf("frames shown: %d\n", display_getFrameCounter());
	return 0;
}


static void init(void) {
	const display_Error error = display_init(frameBuffer, FRAME_WIDTH, FRAME_HEIGHT);
	if (error != DISPLAY_ERROR_NONE) {
		printf("display demo: cannot setup display, error: 0x%08x\n", error);
	}
	irq_enable(MIE_TIMER);
}

static void displaySetDot(bool state) {
	const uint32_t x = FRAME_WIDTH / 2;
	const uint32_t y = FRAME_HEIGHT / 2;
	if (state) {
		frameBuffer[y][x] = (display_Pixel)0xFFFFFFFFUL;
	} else {
		frameBuffer[y][x] = (display_Pixel)0xFF000000UL;
	}
	display_update();
}

void __isr(void) {
	++tickCounter;
}

