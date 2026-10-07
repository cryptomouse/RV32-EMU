
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include "vm_sys.h"
#include "display.h"
#define WIDTH 640
#define HEIGHT 480
#define FRAMES 1024
static uint32_t framebuffer[HEIGHT][WIDTH];
static volatile uint32_t counter;
extern void irq_enable(uint32_t mieMask);
#define MIE_TIMER ((uint32_t)1 << 1)

static void init(void);
static void displaySetDot(bool state);

int main(void) {
	printf("display demo: %dx%d, %d frames\n", WIDTH, HEIGHT, FRAMES);
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
	if (!display_init(framebuffer, WIDTH, HEIGHT)) {
		printf("display demo: cannot setup display\n");
	}
	irq_enable(MIE_TIMER);
}

static void displaySetDot(bool state) {
	const uint32_t x = WIDTH / 2;
	const uint32_t y = HEIGHT / 2;
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

