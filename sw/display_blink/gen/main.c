
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include "vm_sys.h"
#include "display.h"
#define FRAME_WIDTH 640
#define FRAME_HEIGHT 480
static uint32_t framebuffer[FRAME_HEIGHT][FRAME_WIDTH];
static volatile uint32_t counter;
extern void irq_enable(uint32_t mieMask);
#define MIE_TIMER ((uint32_t)1 << 1)

static void init(void);
static void displaySetDot(bool state);

int main(void) {
	printf("display demo: %dx%d\n", FRAME_WIDTH, FRAME_HEIGHT);
	init();
	bool state = true;
	while (true) {
		printf("frame %d\n", *vm_sys_reg(VM_SYS_DISPLAY_FRAME));
		displaySetDot(state);
		state = !state;
		while (counter < 100000) {
		}
		counter = 0;
	}
	printf("frames shown: %d\n", *vm_sys_reg(VM_SYS_DISPLAY_FRAME));
	return 0;
}


static void init(void) {
	const display_Error error = display_init(framebuffer, FRAME_WIDTH, FRAME_HEIGHT);
	if (error != DISPLAY_ERROR_NONE) {
		printf("display demo: cannot setup display, error: 0x%08x\n", error);
	}
	irq_enable(MIE_TIMER);
}

static void displaySetDot(bool state) {
	const uint32_t x = FRAME_WIDTH / 2;
	const uint32_t y = FRAME_HEIGHT / 2;
	if (state) {
		framebuffer[y][x] = 0xFFFFFFFFUL;
	} else {
		framebuffer[y][x] = 0xFF000000UL;
	}
	display_update();
}

void __isr(void) {
	++counter;
}

