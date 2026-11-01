
#if !defined(BUS_H)
#define BUS_H
#include <stdio.h>
#include <stdlib.h>
#include "mmio.h"
#include "display.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
typedef uint32_t bus_ReadInterface(uint32_t adr, uint8_t size);
typedef void bus_WriteInterface(uint32_t adr, uint32_t value, uint8_t size);
typedef void bus_IrqInterface(void);
struct bus_interface {
	bus_ReadInterface *read;
	bus_WriteInterface *write;
	bus_IrqInterface *irq;
};
typedef bool bus_Connector(struct bus_interface *interface);
void bus_init(void);
void bus_deinit(void);
void bus_poll(void);
uint32_t bus_read(uint32_t adr, uint8_t size);
void bus_write(uint32_t adr, uint32_t value, uint8_t size);
void *bus_ramPtr(uint32_t adr, uint32_t size);
void bus_memoryViolation(char rw, uint32_t adr);
uint32_t bus_load_rom(char *filename);
void bus_show_ram(void);
#endif

