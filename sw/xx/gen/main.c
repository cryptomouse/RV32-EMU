
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
#define SCREEN_WIDTH 64
#define SCREEN_HEIGHT 24
#define SYMBOL_HEIGHT (FRAME_HEIGHT / SCREEN_HEIGHT)
#define SYMBOL_WIDTH (FRAME_WIDTH / SCREEN_WIDTH)
typedef display_Pixel Symbol[SYMBOL_HEIGHT][SYMBOL_WIDTH];
typedef Symbol Screen[SCREEN_HEIGHT][SCREEN_WIDTH];
typedef display_Pixel Color;
#define COLOR_BLACK ((Color)0xFF000000UL)
#define COLOR_WHITE ((Color)0xFFFFFFFFUL)
#define COLOR_RED ((Color)0xFFFF0000UL)
#define COLOR_GREEN ((Color)0xFF00FF00UL)
#define COLOR_BLUE ((Color)0xFF0000FFUL)
#define COLOR_YELLOW ((Color)0xFFFFFF00UL)
#define COLOR_CYAN ((Color)0xFF00FFFFUL)
#define COLOR_MAGENTA ((Color)0xFFFF00FFUL)
static Color colors[8] = {
	COLOR_BLACK,
	COLOR_WHITE,
	COLOR_RED,
	COLOR_GREEN,
	COLOR_BLUE,
	COLOR_YELLOW,
	COLOR_CYAN,
	COLOR_MAGENTA
};

static void fillTheSymbol(uint32_t i, uint32_t j);

static void initScreen(void) {
	uint32_t i = 0;
	while (i < SCREEN_HEIGHT) {
		uint32_t j = 0;
		while (j < SCREEN_WIDTH) {
			fillTheSymbol(i, j);
			j += 1;
		}
		i += 1;
	}
}


static void fillTheSymbol(uint32_t i, uint32_t j) {
	uint32_t k = 0;
	while (k < SYMBOL_HEIGHT) {
		uint32_t l = 0;
		while (l < SYMBOL_WIDTH) {
			frameBuffer[i * SYMBOL_HEIGHT + k][j * SYMBOL_WIDTH + l] = colors[(i + j) % 8];
			l += 1;
		}
		k += 1;
	}
}

static void init(void);

int main(void) {
	printf("1display demo: %dx%d\n", FRAME_WIDTH, FRAME_HEIGHT);
	init();
	initScreen();
	display_update();
	while (true) {
		const uint32_t e = display_getError();
		if (e != 0x0) {
			printf("2display demo: error: 0x%08x\n", e);
			break;
		}
		printf("3frame %d\n", display_getFrameCounter());
		while (tickCounter < 100000) {
		}
		tickCounter = 0;
	}
	printf("4frames shown: %d\n", display_getFrameCounter());
	return 0;
}


static void init(void) {
	const display_Error error = display_init(frameBuffer, FRAME_WIDTH, FRAME_HEIGHT);
	if (error != DISPLAY_ERROR_NONE) {
		printf("5display demo: cannot setup display, error: 0x%08x\n", error);
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
// func drawLine (a: Point2D, b: Point2D) -> Unit {
// 	let xlen = absfx32(a.x - b.x)
// 	let ylen = absfx32(a.y - b.y)
// 	printf("xlen = %d, ylen = %d\n", Int32 xlen, Int32 ylen)
// 	var i = 0
// 	while i < xlen {
// 		var j = 0
// 		while j < ylen {
// 			frameBuffer[y][x] = display.Pixel 0xFFFFFFFF
// 			j += 1
// 		}
// 		i += 1
// 	}
// }

void __isr(void) {
	tickCounter += 1;
}

