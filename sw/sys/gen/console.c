
#include "console.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "vm_sys.h"

void console_put(uint32_t x) {
	volatile uint8_t *const p = (volatile uint8_t *)VM_SYS_CONSOLE_PRINT_CHAR8_ADR;
	*p = x;
}

uint32_t console_get(void) {
	return 0x0;
}

void console_print_int(int32_t x) {
	volatile int32_t *const p = (volatile int32_t *)VM_SYS_CONSOLE_PRINT_INT32_ADR;
	*p = x;
}

void console_print_uint(uint32_t x) {
	volatile uint32_t *const p = (volatile uint32_t *)VM_SYS_CONSOLE_PRINT_UINT32_ADR;
	*p = x;
}

void console_print_uint_hex(uint32_t x) {
	volatile uint32_t *const p = (volatile uint32_t *)VM_SYS_CONSOLE_PRINT_UINT32_HEX_ADR;
	*p = x;
}

