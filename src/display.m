// display.m - display controller (MMIO device backed by SDL2)
//
// The framebuffer lives in guest RAM: the guest sets WIDTH, HEIGHT and FB,
// sets CR.EN (only then the SDL window is created) and writes REFRESH
// to show the buffer. Pixel format is ARGB8888 (one Word32 per pixel, 0xAARRGGBB)
//
// Registers (32-bit access only, offsets from the device base):
//   0x00 CR       RW  bit 0 EN: 0->1 opens the window, 1->0 closes it
//   0x04 SR       RO  bit 0 ON: window is open, bit 1 ERR: last command failed
//   0x08 WIDTH    RW  framebuffer width in pixels (latched when EN is set)
//   0x0C HEIGHT   RW  framebuffer height in pixels (latched when EN is set)
//   0x10 FB       RW  framebuffer address in guest RAM (4-byte aligned)
//   0x14 REFRESH  WO  any write copies the framebuffer to the screen
//   0x18 FRAME    RO  number of frames shown since EN was set

pragma unsafe

include "libc/ctypes64"
include "libc/stdio"

import "sdl2" as sdl


public const regCR = Nat32 0x00
public const regSR = Nat32 0x04
public const regWidth = Nat32 0x08
public const regHeight = Nat32 0x0C
public const regFB = Nat32 0x10
public const regRefresh = Nat32 0x14
public const regFrame = Nat32 0x18

const crEN = Word32 0x1

const srON = Word32 0x1
const srERR = Word32 0x2

const maxWidth = Nat32 4096
const maxHeight = Nat32 4096

// the window is scaled up (by an integer factor) to fit this size
const preferredWindowWidth = Nat32 640
const preferredWindowHeight = Nat32 480


// Returns host pointer to guest memory [adr, adr + size) or nil
public type MemMap = *(adr: Nat32, size: Nat32) -> Ptr


var memMap: MemMap

var cr: Word32
var sr: Word32
var width: Nat32
var height: Nat32
var fb: Nat32
var frame: Nat32

// geometry the window was created with
var activeWidth: Nat32
var activeHeight: Nat32

var sdlReady = false
var window: *sdl.Window
var renderer: *sdl.Renderer
var texture: *sdl.Texture


public func init (mm: MemMap) -> Unit {
	memMap = mm
}


public func isOn () -> Bool {
	return (sr & srON) != 0
}


public func read32 (adr: Nat32) -> Word32 {
	if adr == regCR {
		return cr
	} else if adr == regSR {
		return sr
	} else if adr == regWidth {
		return Word32 width
	} else if adr == regHeight {
		return Word32 height
	} else if adr == regFB {
		return Word32 fb
	} else if adr == regFrame {
		return Word32 frame
	}
	return 0
}


public func write32 (adr: Nat32, value: Word32) -> Unit {
	if adr == regCR {
		let enable = (value & crEN) != 0
		let enabled = (cr & crEN) != 0
		cr = value & crEN
		if enable and not enabled {
			if not openWindow() {
				cr = 0
			}
		} else if not enable and enabled {
			closeWindow()
		}
	} else if adr == regWidth {
		width = unsafe(Nat32 value)
	} else if adr == regHeight {
		height = unsafe(Nat32 value)
	} else if adr == regFB {
		fb = unsafe(Nat32 value)
	} else if adr == regRefresh {
		refresh()
	}
}


func openWindow () -> Bool {
	sr = 0

	if width == 0 or width > maxWidth or height == 0 or height > maxHeight {
		printf("display: bad resolution %ux%u\n", width, height)
		sr = srERR
		return false
	}

	if not sdlReady {
		if sdl.init(sdl.initVideo) < 0 {
			printf("display: SDL_Init failed: %s\n", sdl.getError())
			sr = srERR
			return false
		}
		sdlReady = true
	}

	var scale = Nat32 1
	while width * (scale + 1) <= preferredWindowWidth and height * (scale + 1) <= preferredWindowHeight {
		++scale
	}

	window = sdl.createWindow(
		"RV32-EMU",
		sdl.windowposCentered,
		sdl.windowposCentered,
		Int32 (width * scale), Int32 (height * scale),
		sdl.windowShown
	)

	if window != nil {
		renderer = sdl.createRenderer(
			window, -1,
			sdl.rendererAccelerated | sdl.rendererPresentvsync
		)
	}

	if renderer != nil {
		texture = sdl.createTexture(
			renderer,
			sdl.pixelformatArgb8888,
			sdl.textureaccessStreaming,
			Int32 width, Int32 height
		)
	}

	if texture == nil {
		printf("display: cannot create window: %s\n", sdl.getError())
		destroyWindow()
		sr = srERR
		return false
	}

	activeWidth = width
	activeHeight = height
	frame = 0
	sr = srON

	// show black screen until the first refresh
	sdl.renderClear(renderer)
	sdl.renderPresent(renderer)

	return true
}


func closeWindow () -> Unit {
	destroyWindow()
	sr = 0
}


func destroyWindow () -> Unit {
	if texture != nil {
		sdl.destroyTexture(texture)
		texture = nil
	}
	if renderer != nil {
		sdl.destroyRenderer(renderer)
		renderer = nil
	}
	if window != nil {
		sdl.destroyWindow(window)
		window = nil
	}
}


func refresh () -> Unit {
	if not isOn() {
		sr = sr | srERR
		return
	}

	let pitch = activeWidth * Nat32 sizeof(Word32)
	let pixels = memMap(fb, pitch * activeHeight)
	if pixels == nil or (Word32 fb & 3) != 0 {
		printf("display: bad framebuffer address 0x%08x\n", fb)
		sr = sr | srERR
		return
	}

	sr = sr & ~srERR

	sdl.updateTexture(texture, nil, pixels, Int32 pitch)
	sdl.renderClear(renderer)
	sdl.renderCopy(renderer, texture, nil, nil)
	sdl.renderPresent(renderer)

	++frame
}


// Handle window events; returns false if the user closed the window
public func poll () -> Bool {
	if not isOn() {
		return true
	}

	var event: sdl.Event
	while sdl.pollEvent(&event) != 0 {
		if eventType(&event) == sdl.quit {
			return false
		}
	}

	return true
}


// Block until the user closes the window
public func waitClose () -> Unit {
	while poll() {
		sdl.delay(16)
	}
}


public func shutdown () -> Unit {
	closeWindow()
	if sdlReady {
		sdl.shutdown()
		sdlReady = false
	}
}


// event type is the first 4 bytes of SDL_Event
func eventType (event: *sdl.Event) -> Nat32 {
	let p = unsafe(*Nat32 event)
	return *p
}

