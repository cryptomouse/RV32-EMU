
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
struct display_device;
typedef struct display_device display_Device;
typedef struct display_device display_Device;
struct display_device {
	uint32_t (*read32)(display_Device *dev, uint32_t adr);
	void (*write32)(display_Device *dev, uint32_t adr, uint32_t value);
	uint32_t cr;
	uint32_t sr;
	uint32_t er;
	uint32_t width;
	uint32_t height;
	uint32_t fb;
	uint32_t framecnt;


	display_MemMap memMap;
	uint32_t activeWidth;
	uint32_t activeHeight;

	bool sdlReady;
	SDL_Window *window;
	SDL_Renderer *renderer;
	SDL_Texture *texture;
};
void display_init(display_Device *dev, display_MemMap mm);
bool display_isOn(display_Device *dev);
void display_poll(display_Device *dev);
void display_waitClose(display_Device *dev);
void display_deinit(display_Device *dev);
#endif

