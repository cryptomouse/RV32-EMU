
#include "bits32.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

uint32_t bits32_switch(uint32_t x, uint8_t no, bool val) {
	if (val) {
		return bits32_set(x, no);
	} else {
		return bits32_reset(x, no);
	}
	return 0x0;
}

