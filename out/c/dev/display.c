
#include "display.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <SDL2/SDL.h>
#define CR_EN 0x1
#define CMD_REFRESH 0x1
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

static uint32_t read32(display_Device *dev, uint32_t adr);
static void write32(display_Device *dev, uint32_t adr, uint32_t value);

static void reset(display_Device *dev) {
	*dev = (display_Device){0};
	dev->read32 = &read32;
	dev->write32 = &write32;
}

void display_init(display_Device *dev, display_MemMap mm) {
	reset(dev);
	dev->memMap = mm;
}


bool display_isOn(display_Device *dev) {
	return (dev->sr & SR_ON) != 0x0;
}


static uint32_t read32(display_Device *dev, uint32_t adr) {
	if (adr == DISPLAY_REG_CR) {
		return dev->cr;
	} else if (adr == DISPLAY_REG_SR) {
		if (dev->er != 0x0) {
			return dev->sr | SR_ERR;
		}
		return dev->sr;
	} else if (adr == DISPLAY_REG_ER) {
		return dev->er;
	} else if (adr == DISPLAY_REG_WIDTH) {
		return dev->width;
	} else if (adr == DISPLAY_REG_HEIGHT) {
		return dev->height;
	} else if (adr == DISPLAY_REG_FB) {
		return dev->fb;
	} else if (adr == DISPLAY_REG_FRAME) {
		return dev->framecnt;
	}
	return 0x0;
}

static bool openWindow(display_Device *dev);
static void closeWindow(display_Device *dev);
static void refresh(display_Device *dev);
static void setErrorFlag(display_Device *dev, uint32_t e);

static void write32(display_Device *dev, uint32_t adr, uint32_t value) {
	if (adr == DISPLAY_REG_CR) {
		const bool enable = (value & CR_EN) != 0x0;
		const bool enabled = (dev->cr & CR_EN) != 0x0;
		dev->cr = value & CR_EN;
		if (enable && !enabled) {
			if (!openWindow(dev)) {
				dev->cr = 0x0;
			}
		} else if (!enable && enabled) {
			closeWindow(dev);
		}
	} else if (adr == DISPLAY_REG_CMD) {
		if ((value & CMD_REFRESH) != 0x0) {
			refresh(dev);
		}
	} else if (adr == DISPLAY_REG_ER) {
		dev->er = dev->er & ~value;
	} else if (adr == DISPLAY_REG_WIDTH) {
		const uint32_t w = value;
		if (w == 0 || w > MAX_WIDTH) {
			setErrorFlag(dev, ER_WIDTH);
		} else {
			dev->width = w;
		}
	} else if (adr == DISPLAY_REG_HEIGHT) {
		const uint32_t h = value;
		if (h == 0 || h > MAX_HEIGHT) {
			setErrorFlag(dev, ER_HEIGHT);
		} else {
			dev->height = h;
		}
	} else if (adr == DISPLAY_REG_FB) {
		if ((value & 0x3) != 0x0) {
			setErrorFlag(dev, ER_FB);
		} else {
			dev->fb = value;
		}
	}
}

static void destroyWindow(display_Device *dev);

static bool openWindow(display_Device *dev) {
	dev->sr = 0x0;
	if (dev->width == 0 || dev->width > MAX_WIDTH || dev->height == 0 || dev->height > MAX_HEIGHT) {
		printf("display: bad resolution %ux%u\n", dev->width, dev->height);
		setErrorFlag(dev, ER_GEOM);
		return false;
	}
	if (!dev->sdlReady) {
		SDL_SetHint("SDL_NO_SIGNAL_HANDLERS", "1");
		if (SDL_Init(SDL_INIT_VIDEO) < 0) {
			printf("display: SDL_Init failed: %s\n", SDL_GetError());
			setErrorFlag(dev, ER_LINK);
			return false;
		}
		dev->sdlReady = true;
	}
	uint32_t scale = 1;
	while (dev->width * (scale + 1) <= PREFERRED_WINDOW_WIDTH && dev->height * (scale + 1) <= PREFERRED_WINDOW_HEIGHT) {
		scale += 1;
	}
	dev->window = SDL_CreateWindow("RV32-EMU", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, (int32_t)(dev->width * scale), (int32_t)(dev->height * scale), SDL_WINDOW_SHOWN);
	if (dev->window != NULL) {
		dev->renderer = SDL_CreateRenderer(dev->window, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
	}
	if (dev->renderer != NULL) {
		dev->texture = SDL_CreateTexture(dev->renderer, SDL_PIXELFORMAT_ARGB8888, SDL_TEXTUREACCESS_STREAMING, (int32_t)dev->width, (int32_t)dev->height);
	}
	if (dev->texture == NULL) {
		printf("display: cannot create window: %s\n", SDL_GetError());
		destroyWindow(dev);
		setErrorFlag(dev, ER_LINK);
		return false;
	}
	dev->activeWidth = dev->width;
	dev->activeHeight = dev->height;
	dev->framecnt = 0;
	dev->sr = SR_ON;
	SDL_RenderClear(dev->renderer);
	SDL_RenderPresent(dev->renderer);
	return true;
}

static void closeWindow(display_Device *dev) {
	destroyWindow(dev);
	dev->sr = 0x0;
}

static void destroyWindow(display_Device *dev) {
	if (dev->texture != NULL) {
		SDL_DestroyTexture(dev->texture);
		dev->texture = NULL;
	}
	if (dev->renderer != NULL) {
		SDL_DestroyRenderer(dev->renderer);
		dev->renderer = NULL;
	}
	if (dev->window != NULL) {
		SDL_DestroyWindow(dev->window);
		dev->window = NULL;
	}
}


static void refresh(display_Device *dev) {
	if (!display_isOn(dev)) {
		setErrorFlag(dev, ER_OFF);
		return;
	}
	const uint32_t pitch = dev->activeWidth * (uint32_t)sizeof(uint32_t);
	void *const pixels = dev->memMap(dev->fb, pitch * dev->activeHeight);
	if (pixels == NULL || (dev->fb & 0x3) != 0x0) {
		printf("display: bad framebuffer address 0x%08x\n", dev->fb);
		setErrorFlag(dev, ER_FBMAP);
		return;
	}
	SDL_UpdateTexture(dev->texture, NULL, pixels, (int32_t)pitch);
	SDL_RenderClear(dev->renderer);
	SDL_RenderCopy(dev->renderer, dev->texture, NULL, NULL);
	SDL_RenderPresent(dev->renderer);
	dev->framecnt += 1;
}

static uint32_t eventType(SDL_Event *event);
static void linkLost(display_Device *dev);

void display_poll(display_Device *dev) {
	if (!display_isOn(dev)) {
		return;
	}
	SDL_Event event = {0};
	while (SDL_PollEvent(&event) != 0) {
		if (eventType(&event) == SDL_QUIT) {
			linkLost(dev);
			return;
		}
	}
}


static void linkLost(display_Device *dev) {
	printf("display: link lost\n");
	destroyWindow(dev);
	dev->cr = 0x0;
	dev->sr = 0x0;
	setErrorFlag(dev, ER_LINK);
}

void display_waitClose(display_Device *dev) {
	while (display_isOn(dev)) {
		display_poll(dev);
		SDL_Delay(16);
	}
}

void display_deinit(display_Device *dev) {
	closeWindow(dev);
	if (dev->sdlReady) {
		SDL_Quit();
		dev->sdlReady = false;
	}
}

static void setErrorFlag(display_Device *dev, uint32_t e) {
	dev->er = dev->er | e;
}

static uint32_t eventType(SDL_Event *event) {
	uint32_t *const p = (uint32_t *)event;
	return *p;
}

