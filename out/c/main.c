
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include "bus.h"
#include "hart.h"
#include "csr.h"
static struct hart_hart hart;
#define BUS_POLL_PERIOD 100000


int main(int argc, char **argv) {
	printf("RISC-V VM\n");
	if (argc < 2) {
		printf("usage: %s <image.bin>\n", argv[0]);
		exit(1);
	}
	char *const imageName = argv[1];
	const uint32_t nbytes = bus_load_rom(imageName);
	if (nbytes <= 0) {
		exit(1);
	}
	hart_BusInterface busctl = (hart_BusInterface){
		.read = &bus_read,
		.write = &bus_write
	};
	hart_init(&hart, 0, &busctl);
	bus_init();
	printf(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n");
	uint32_t timer_cnt = 0;
	uint32_t poll_cnt = 0;
	while (true) {
		if (!hart_cycle(&hart)) {
			break;
		}
		timer_cnt += 1;
		if (timer_cnt == 1000) {
			timer_cnt = 0;
			hart_interrupt(&hart, HART_INT_SYS_TIMER);
		}
		poll_cnt += 1;
		if (poll_cnt == BUS_POLL_PERIOD) {
			poll_cnt = 0;
			bus_poll();
		}
	}
	bus_deinit();
	printf("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
	printf("mcycle = %u\n", hart_getCsr(&hart, CSR_MCYCLE_REGNO));
	printf("\nCore dump:\n");
	hart_show_regs(&hart);
	printf("\n");
	bus_show_ram();
	return 0;
}

