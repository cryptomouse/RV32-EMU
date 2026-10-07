
#include "bus.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include "mmio.h"
struct __anonymous_struct_6 {uint32_t begin; uint32_t end;};
#define SHOW_TEXT false
#define RAM_SIZE ((uint32_t)8 * 1024 * 1024)
#define RAM_START 0x10000000
#define RAM_END (RAM_START + RAM_SIZE)
#define ROM_SIZE 0x100000
#define ROM_START 0x00000000
#define ROM_END (ROM_START + ROM_SIZE)
#define MMIO_SIZE 0x01000000
#define MMIO_START 0xF0000000UL
#define MMIO_END (MMIO_START + MMIO_SIZE)
#define RAM_REGION {.begin = RAM_START, .end = RAM_END}
#define ROM_REGION {.begin = ROM_START, .end = ROM_END}
#define MMIO_REGION {.begin = MMIO_START, .end = MMIO_END}
static uint8_t ram[RAM_SIZE];
static uint8_t rom[ROM_SIZE];

__attribute__((always_inline))
static inline bool isAdressInRegion(uint32_t x, struct __anonymous_struct_6 region);
static uint32_t readFrom(void *ptr, uint32_t adr, uint8_t size);

uint32_t bus_read(uint32_t adr, uint8_t size) {
	if (isAdressInRegion(adr, (struct __anonymous_struct_6){.begin = RAM_START, .end = RAM_END})) {
		const uint32_t offset = adr - ((struct {const uint32_t begin; const uint32_t end;})RAM_REGION).begin;
		void *const ptr = &ram[offset];
		return readFrom(ptr, adr, size);
	} else if (isAdressInRegion(adr, (struct __anonymous_struct_6){.begin = ROM_START, .end = ROM_END})) {
		const uint32_t offset = adr - ((struct {const uint32_t begin; const uint32_t end;})ROM_REGION).begin;
		void *const ptr = &rom[offset];
		return readFrom(ptr, adr, size);
	} else if (isAdressInRegion(adr, (struct __anonymous_struct_6){.begin = MMIO_START, .end = MMIO_END})) {
		const uint32_t offset = adr - ((struct {const uint32_t begin; const uint32_t end;})MMIO_REGION).begin;
		if (size == 1) {
			return (uint32_t)mmio_read8(offset);
		} else if (size == 2) {
			return (uint32_t)mmio_read16(offset);
		} else if (size == 4) {
			return mmio_read32(offset);
		}
	} else {
		bus_memoryViolation('r', adr);
	}
	return 0x0;
}

static void writeTo(void *ptr, uint32_t adr, uint32_t value, uint8_t size);

void bus_write(uint32_t adr, uint32_t value, uint8_t size) {
	if (isAdressInRegion(adr, (struct __anonymous_struct_6){.begin = RAM_START, .end = RAM_END})) {
		const uint32_t offset = adr - ((struct {const uint32_t begin; const uint32_t end;})RAM_REGION).begin;
		void *const ptr = &ram[offset];
		writeTo(ptr, adr, value, size);
	} else if (isAdressInRegion(adr, (struct __anonymous_struct_6){.begin = MMIO_START, .end = MMIO_END})) {
		const uint32_t offset = adr - ((struct {const uint32_t begin; const uint32_t end;})MMIO_REGION).begin;
		if (size == 1) {
			mmio_write8(offset, (uint8_t)value);
		} else if (size == 2) {
			mmio_write16(offset, (uint16_t)value);
		} else if (size == 4) {
			mmio_write32(offset, value);
		}
	} else if (isAdressInRegion(adr, (struct __anonymous_struct_6){.begin = ROM_START, .end = ROM_END})) {
		bus_memoryViolation('w', adr);
	} else {
		bus_memoryViolation('w', adr);
	}
}

static uint32_t readFrom(void *ptr, uint32_t adr, uint8_t size) {
	if (size == 1) {
		return (uint32_t)*((uint8_t *)ptr);
	} else if (size == 2) {
		return (uint32_t)*((uint16_t *)ptr);
	} else if (size == 4) {
		return *((uint32_t *)ptr);
	}
	return 0x0;
}

static void writeTo(void *ptr, uint32_t adr, uint32_t value, uint8_t size) {
	if (size == 1) {
		*((uint8_t *)ptr) = value;
	} else if (size == 2) {
		*((uint16_t *)ptr) = value;
	} else if (size == 4) {
		*((uint32_t *)ptr) = value;
	}
}


void *bus_ramPtr(uint32_t adr, uint32_t size) {
	if (adr < RAM_START || adr >= RAM_END || size > RAM_END - adr) {
		return NULL;
	}
	return &ram[adr - RAM_START];
}

__attribute__((always_inline))
static inline bool isAdressInRegion(uint32_t x, struct __anonymous_struct_6 region) {
	return x >= region.begin && x < region.end;
}
static uint32_t memviolationCnt = 0;

void bus_memoryViolation(char rw, uint32_t adr) {
	printf("*** MEMORY VIOLATION '%c' 0x%08x ***\n", rw, adr);
	if (memviolationCnt > 10) {
		exit(1);
	}
	++memviolationCnt;
}

static uint32_t load(char *filename, uint8_t *bufptr, uint32_t buf_size);

uint32_t bus_load_rom(char *filename) {
	return load(filename, rom, ROM_SIZE);
}


static uint32_t load(char *filename, uint8_t *bufptr, uint32_t buf_size) {
	printf("LOAD: %s\n", filename);
	FILE *const fp = fopen(filename, "rb");
	if (fp == NULL) {
		printf("error: cannot open file '%s'", filename);
		return 0;
	}
	const size_t n = fread(bufptr, 1, (size_t)buf_size, fp);
	printf("LOADED: %zu bytes\n", n);
	if (SHOW_TEXT) {
		size_t i = 0;
		while (i < (n / 4)) {
			printf("%08zx: 0x%08x\n", i, ((uint32_t *)bufptr)[i]);
			i = i + 4;
		}
		printf("-----------\n");
	}
	fclose(fp);
	return (uint32_t)n;
}

void bus_show_ram(void) {
	uint32_t i = 0;
	uint8_t *const ramptr = ram;
	while (i < 256) {
		printf("%08X", i * 16);
		uint32_t j = 0;
		while (j < 16) {
			printf(" %02X", ramptr[i + j]);
			j = j + 1;
		}
		printf("\n");
		i = i + 16;
	}
}

