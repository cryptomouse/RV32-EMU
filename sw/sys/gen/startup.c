
#include "startup.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
extern uint8_t _bss_start;
extern uint8_t _bss_end;
extern uint8_t _data_start;
extern uint8_t _data_end;
extern uint8_t _data_flash_start;
extern void *memset(void *mem, int32_t x, size_t len);
extern void *memcpy(void *dst, void *src, size_t len);
extern int32_t main(void);

__attribute__((section(".startup")))
void startup(void) {
	const uint32_t bssSize = (uint32_t)&_bss_end - (uint32_t)&_bss_start;
	(void)memset(&_bss_start, 0, (size_t)bssSize);
	const uint32_t dataSize = (uint32_t)&_data_end - (uint32_t)&_data_start;
	(void)memcpy(&_data_start, &_data_flash_start, (size_t)dataSize);
	(void)main();
}

