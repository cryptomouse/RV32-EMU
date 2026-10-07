// RV32-EMU
// run: ./a.out sw/sha256/image.bin

include "libc/stdlib"
include "libc/stdio"

import "bus"
import "dev/display"
import "hart/hart" as rvHart
import "hart/csr" as csr


var hart: rvHart.Hart

// how often (in hart cycles) window events are handled
const displayPollPeriod = Nat32 100000


func main (argc: Int, argv: *[]*Str8) -> Int {
	printf("RISC-V VM\n")

	if argc < 2 {
		printf("usage: %s <image.bin>\n", argv[0])
		exit(1)
	}

	let imageName = argv[1]
	let nbytes = bus.load_rom(imageName)
	if nbytes <= 0 {
		exit(1)
	}

	var busctl = rvHart.BusInterface {
		read = &bus.read
		write = &bus.write
	}

	rvHart.init(&hart, 0, &busctl)
	display.init(&bus.ramPtr)

	printf(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n")

	var timer_cnt: Nat32 = 0
	var poll_cnt: Nat32 = 0

	while true {
		// Hart beat
		if not rvHart.cycle(&hart) {
			break
		}

		// Generate timer interrupt (intSysTimer)
		++timer_cnt
		if timer_cnt == 1000 {
			timer_cnt = 0
			//printf("Timer interrupt generated\n")
			rvHart.interrupt(&hart, rvHart.intSysTimer)
		}

		// Keep the display window responsive
		++poll_cnt
		if poll_cnt == displayPollPeriod {
			poll_cnt = 0
			display.poll()
		}
	}

	// The program has finished but its picture stays on the screen
	if display.isOn() {
		printf("\nclose the display window to exit\n")
		display.waitClose()
	}
	display.shutdown()

	printf("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n")
	printf("mcycle = %u\n", rvHart.getCsr(&hart, csr.mcycleRegno))

	printf("\nCore dump:\n")
	rvHart.show_regs(&hart)
	printf("\n")
	bus.show_ram()

	return 0
}



