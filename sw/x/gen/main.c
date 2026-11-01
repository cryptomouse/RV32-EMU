
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include "vm_sys.h"
#include "display.h"
#include "fixed.h"
struct point2_d {__fixed32 x; __fixed32 y;};
static volatile uint32_t tickCounter;
#define FRAME_WIDTH 640
#define FRAME_HEIGHT 480
static display_Pixel frameBuffer[FRAME_HEIGHT][FRAME_WIDTH];
extern void irq_enable(uint32_t mieMask);
#define MIE_TIMER ((uint32_t)1 << 1)

static void init(void);
static void drawLine(struct point2_d a, struct point2_d b);
static void displaySetDot(bool state);

int main(void) {
	printf("display demo: %dx%d\n", FRAME_WIDTH, FRAME_HEIGHT);
	init();
	drawLine((struct point2_d){.x = /*1.0e+01*/655360, .y = /*2.0e+01*/1310720}, (struct point2_d){.x = /*4.0e+01*/2621440, .y = /*55.0*/3604480});
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

static __fixed32 absfx32(__fixed32 x) {
	if (x < /*0*/0) {
		return -x;
	}
	return x;
}

static void drawLine(struct point2_d a, struct point2_d b) {
	const __fixed32 xlen = absfx32(a.x - b.x);
	const __fixed32 ylen = absfx32(a.y - b.y);
	printf("xlen = %d, ylen = %d\n", __fixed32_to_int32(xlen, 16), __fixed32_to_int32(ylen, 16));
}

void __isr(void) {
	++tickCounter;
}

