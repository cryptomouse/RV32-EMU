
#include "system.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "console.h"

int32_t write(int32_t fd, uint8_t *data, int32_t len) {
	int32_t i = 0;
	while (i < len) {
		console_put((uint32_t)data[i]);
		++i;
	}
	return i;
}

