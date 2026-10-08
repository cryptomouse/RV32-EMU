
#if !defined(DISPLAY_H)
#define DISPLAY_H
#include <stdio.h>
#include <SDL2/SDL.h>
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#define DISPLAY_REG_CR 0x00
#define DISPLAY_REG_SR 0x04
#define DISPLAY_REG_ER 0x08
#define DISPLAY_REG_WIDTH 0x0C
#define DISPLAY_REG_HEIGHT 0x10
#define DISPLAY_REG_FB 0x14
#define DISPLAY_REG_FRAME 0x18
#define DISPLAY_REG_CMD 0x1C
typedef void *(*display_MemMap)(uint32_t adr, uint32_t size);
void display_init(display_MemMap mm);
bool display_isOn(void);
uint32_t display_read32(uint32_t adr);
void display_write32(uint32_t adr, uint32_t value);
void display_poll(void);
void display_waitClose(void);
void display_shutdown(void);
#endif

