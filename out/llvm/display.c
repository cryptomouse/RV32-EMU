
#include "display.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <SDL2/SDL.h>
#define CR_EN 0x1
#define CR_REFRESH 0x2
#define SR_ON 0x1
#define SR_ERR 0x2
#define ER_WIDTH 0x1
#define ER_HEIGHT 0x2
#define ER_FB 0x4
#define ER_LINK 0x8
#define ER_GEOM 0x10
#define ER_OFF 0x20
#define ER_FBMAP 0x40
#define MAX_WIDTH 4096
#define MAX_HEIGHT 4096
#define PREFERRED_WINDOW_WIDTH 640
#define PREFERRED_WINDOW_HEIGHT 480
static display_MemMap memMap;
static uint32_t cr;
static uint32_t sr;
static uint32_t er;
static uint32_t width;
static uint32_t height;
static uint32_t fb;
static uint32_t frame;
static uint32_t activeWidth;
static uint32_t activeHeight;
static bool sdlReady = false;
static SDL_Window *window;
static SDL_Renderer *renderer;
static SDL_Texture *texture;

void display_init(display_MemMap mm) {
	memMap = mm;
}


bool display_isOn(void) {
	return (sr & SR_ON) != 0x0;
}


uint32_t display_read32(uint32_t adr) {
	if (adr == DISPLAY_REG_CR) {
		return cr;
	} else if (adr == DISPLAY_REG_SR) {
		if (er != 0x0) {
			return sr | SR_ERR;
		}
		return sr;
	} else if (adr == DISPLAY_REG_ER) {
		return er;
	} else if (adr == DISPLAY_REG_WIDTH) {
		return width;
	} else if (adr == DISPLAY_REG_HEIGHT) {
		return height;
	} else if (adr == DISPLAY_REG_FB) {
		return fb;
	} else if (adr == DISPLAY_REG_FRAME) {
		return frame;
	}
	return 0x0;
}

static bool openWindow(void);
static void closeWindow(void);
static void refresh(void);

void display_write32(uint32_t adr, uint32_t value) {
	if (adr == DISPLAY_REG_CR) {
		const bool enable = (value & CR_EN) != 0x0;
		const bool enabled = (cr & CR_EN) != 0x0;
		cr = value & CR_EN;
		if (enable && !enabled) {
			if (!openWindow()) {
				cr = 0x0;
			}
		} else if (!enable && enabled) {
			closeWindow();
		}
		if ((value & CR_REFRESH) != 0x0) {
			refresh();
		}
	} else if (adr == DISPLAY_REG_ER) {
		er = er & ~value;
	} else if (adr == DISPLAY_REG_WIDTH) {
		const uint32_t w = value;
		if (w == 0 || w > MAX_WIDTH) {
			er = er | ER_WIDTH;
		} else {
			width = w;
		}
	} else if (adr == DISPLAY_REG_HEIGHT) {
		const uint32_t h = value;
		if (h == 0 || h > MAX_HEIGHT) {
			er = er | ER_HEIGHT;
		} else {
			height = h;
		}
	} else if (adr == DISPLAY_REG_FB) {
		if ((value & 0x3) != 0x0) {
			er = er | ER_FB;
		} else {
			fb = value;
		}
	}
}

static void destroyWindow(void);

static bool openWindow(void) {
	sr = 0x0;
	if (width == 0 || width > MAX_WIDTH || height == 0 || height > MAX_HEIGHT) {
		printf("display: bad resolution %ux%u\n", width, height);
		er = er | ER_GEOM;
		return false;
	}
	if (!sdlReady) {
		SDL_SetHint("SDL_NO_SIGNAL_HANDLERS", "1");
		if (SDL_Init(SDL_INIT_VIDEO) < 0) {
			printf("display: SDL_Init failed: %s\n", SDL_GetError());
			er = er | ER_LINK;
			return false;
		}
		sdlReady = true;
	}
	uint32_t scale = 1;
	while (width * (scale + 1) <= PREFERRED_WINDOW_WIDTH && height * (scale + 1) <= PREFERRED_WINDOW_HEIGHT) {
		++scale;
	}
	window = SDL_CreateWindow("RV32-EMU", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, (int32_t)(width * scale), (int32_t)(height * scale), SDL_WINDOW_SHOWN);
	if (window != NULL) {
		renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
	}
	if (renderer != NULL) {
		texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, (int32_t)width, (int32_t)height);
	}
	if (texture == NULL) {
		printf("display: cannot create window: %s\n", SDL_GetError());
		destroyWindow();
		er = er | ER_LINK;
		return false;
	}
	activeWidth = width;
	activeHeight = height;
	frame = 0;
	sr = SR_ON;
	SDL_RenderClear(renderer);
	SDL_RenderPresent(renderer);
	return true;
}

static void closeWindow(void) {
	destroyWindow();
	sr = 0x0;
}

static void destroyWindow(void) {
	if (texture != NULL) {
		SDL_DestroyTexture(texture);
		texture = NULL;
	}
	if (renderer != NULL) {
		SDL_DestroyRenderer(renderer);
		renderer = NULL;
	}
	if (window != NULL) {
		SDL_DestroyWindow(window);
		window = NULL;
	}
}


static void refresh(void) {
	if (!display_isOn()) {
		er = er | ER_OFF;
		return;
	}
	const uint32_t pitch = activeWidth * (uint32_t)sizeof(uint32_t);
	void *const pixels = memMap(fb, pitch * activeHeight);
	if (pixels == NULL || (fb & 0x3) != 0x0) {
		printf("display: bad framebuffer address 0x%08x\n", fb);
		er = er | ER_FBMAP;
		return;
	}
	SDL_UpdateTexture(texture, NULL, pixels, (int32_t)pitch);
	SDL_RenderClear(renderer);
	SDL_RenderCopy(renderer, texture, NULL, NULL);
	SDL_RenderPresent(renderer);
	++frame;
}

static uint32_t eventType(SDL_Event *event);
static void linkLost(void);

void display_poll(void) {
	if (!display_isOn()) {
		return;
	}
	SDL_Event event = {0};
	while (SDL_PollEvent(&event) != 0) {
		if (eventType(&event) == SDL_QUIT) {
			linkLost();
			return;
		}
	}
}


static void linkLost(void) {
	printf("display: link lost\n");
	destroyWindow();
	cr = 0x0;
	sr = 0x0;
	er = er | ER_LINK;
}

void display_waitClose(void) {
	while (display_isOn()) {
		display_poll();
		SDL_Delay(16);
	}
}

void display_shutdown(void) {
	closeWindow();
	if (sdlReady) {
		SDL_Quit();
		sdlReady = false;
	}
}

static uint32_t eventType(SDL_Event *event) {
	uint32_t *const p = (uint32_t *)event;
	return *p;
}

