// display.m - display controller (MMIO device backed by SDL2)
//
// The framebuffer lives in guest RAM: the guest sets WIDTH, HEIGHT and FB,
// sets CR.EN (only then the SDL window is created) and writes CMD.REFRESH
// to show the buffer. Pixel format is ARGB8888 (one Word32 per pixel, 0xAARRGGBB)
//
// Register roles: CR holds the configuration, commands are written only
// to CMD, status is read only from SR (writes to it are ignored), errors
// are cleared only through ER
//
// Registers (32-bit access only, offsets from the device base):
//   0x00 CR       RW  bit 0 EN: 0->1 opens the window, 1->0 closes it
//   0x04 SR       RO  bit 0 ON: window is open, bit 1 ERR: ER != 0
//   0x08 ER       RW1C error flags (sticky, write 1 to clear a bit):
//                     bit 0 WIDTH, bit 1 HEIGHT, bit 2 FB: invalid register write
//                     bit 3 LINK: link to the display lost (hardware fault)
//                     bit 4 GEOM: EN set while WIDTH/HEIGHT are not configured
//                     bit 5 OFF: command written to CMD while the display is off
//                     bit 6 FBMAP: framebuffer is outside guest RAM
//   0x0C WIDTH    RW  framebuffer width in pixels, 1..4096 (latched when EN is set)
//   0x10 HEIGHT   RW  framebuffer height in pixels, 1..4096 (latched when EN is set)
//   0x14 FB       RW  framebuffer address in guest RAM (4-byte aligned)
//   0x18 FRAME    RO  number of frames shown since EN was set
//   0x1C CMD      WO  commands, write 1 to a bit to run it, always reads as 0:
//                     bit 0 REFRESH: copy the framebuffer to the screen
//
// Error reporting: every error first sets its flag in ER; SR.ERR is not
// stored, it reads as 1 whenever ER != 0. Errors are sticky: nothing clears
// them on success, the guest acknowledges them by writing 1s to ER
//
// An invalid value written to WIDTH, HEIGHT or FB is ignored (the register
// keeps its previous value) and the corresponding bit in ER is set
//
// Closing the window plays the role of a physical link failure: the device
// drops CR.EN and SR.ON and sets ER.LINK. The guest keeps running and
// may set CR.EN again to reconnect

pragma unsafe

include "libc/ctypes64"
include "libc/stdio"

import "../sdl2" as sdl


public const regCR = Nat32 0x00
public const regSR = Nat32 0x04
public const regER = Nat32 0x08
public const regWidth = Nat32 0x0C
public const regHeight = Nat32 0x10
public const regFB = Nat32 0x14
public const regFrame = Nat32 0x18
public const regCMD = Nat32 0x1C

const crEN = Word32 0x1

const cmdREFRESH = Word32 0x1

const srON = Word32 0x1
const srERR = Word32 0x2

const erWidth = Word32 0x1
const erHeight = Word32 0x2
const erFB = Word32 0x4
const erLINK = Word32 0x8
const erGEOM = Word32 0x10
const erOFF = Word32 0x20
const erFBMAP = Word32 0x40

const maxWidth = Nat32 4096
const maxHeight = Nat32 4096

// window scale factor: each framebuffer pixel is shown as a
// windowScale x windowScale square; 0 = pick automatically to fit
// preferredWindowWidth x preferredWindowHeight
const windowScale = Nat32 2

// the window is scaled up (by an integer factor) to fit this size
const preferredWindowWidth = Nat32 640
const preferredWindowHeight = Nat32 480


// Returns host pointer to guest memory [adr, adr + size) or nil
public type MemMap = *(adr: Nat32, size: Nat32) -> Ptr


public type Device = {
	public read32: *(dev: *Device, adr: Nat32) -> Word32
	public write32: *(dev: *Device, adr: Nat32, value: Word32) -> Unit

	// device registers
	cr: Word32
	sr: Word32  // only ON is kept here, ERR is derived from ER
	er: Word32
	width: Nat32
	height: Nat32
	fb: Nat32
	framecnt: Nat32


	memMap: MemMap

	// geometry the window was created with
	activeWidth: Nat32
	activeHeight: Nat32

	sdlReady: Bool
	window: *sdl.Window
	renderer: *sdl.Renderer
	texture: *sdl.Texture
}


func reset (dev: *Device) -> Unit {
	*dev = {}
	dev.read32 = &read32
	dev.write32 = &write32
}

public func init (dev: *Device, mm: MemMap) -> Unit {
	reset(dev)
	dev.memMap = mm
}


public func isOn (dev: *Device) -> Bool {
	return (dev.sr & srON) != 0
}


func read32 (dev: *Device, adr: Nat32) -> Word32 {
	if adr == regCR {
		return dev.cr
	} else if adr == regSR {
		if dev.er != 0 {
			return dev.sr | srERR
		}
		return dev.sr
	} else if adr == regER {
		return dev.er
	} else if adr == regWidth {
		return Word32 dev.width
	} else if adr == regHeight {
		return Word32 dev.height
	} else if adr == regFB {
		return Word32 dev.fb
	} else if adr == regFrame {
		return Word32 dev.framecnt
	}
	return 0
}


func write32 (dev: *Device, adr: Nat32, value: Word32) -> Unit {
	if adr == regCR {
		let enable = (value & crEN) != 0
		let enabled = (dev.cr & crEN) != 0
		dev.cr = value & crEN
		if enable and not enabled {
			if not openWindow(dev) {
				dev.cr = 0
			}
		} else if not enable and enabled {
			closeWindow(dev)
		}
	} else if adr == regCMD {
		if (value & cmdREFRESH) != 0 {
			refresh(dev)
		}
	} else if adr == regER {
		dev.er = dev.er & ~value
	} else if adr == regWidth {
		let w = unsafe(Nat32 value)
		if w == 0 or w > maxWidth {
			setErrorFlag(dev, erWidth)
		} else {
			dev.width = w
		}
	} else if adr == regHeight {
		let h = unsafe(Nat32 value)
		if h == 0 or h > maxHeight {
			setErrorFlag(dev, erHeight)
		} else {
			dev.height = h
		}
	} else if adr == regFB {
		if (value & 3) != 0 {
			setErrorFlag(dev, erFB)
		} else {
			dev.fb = unsafe(Nat32 value)
		}
	}
}


func openWindow (dev: *Device) -> Bool {
	dev.sr = 0

	if dev.width == 0 or dev.width > maxWidth or dev.height == 0 or dev.height > maxHeight {
		printf("display: bad resolution %ux%u\n", dev.width, dev.height)
		setErrorFlag(dev, erGEOM)
		return false
	}

	if not dev.sdlReady {
		// keep Ctrl+C killing the emulator: otherwise SDL turns it into SDL_QUIT,
		// which we treat as a closed window
		sdl.setHint("SDL_NO_SIGNAL_HANDLERS", "1")
		if sdl.init(sdl.initVideo) < 0 {
			printf("display: SDL_Init failed: %s\n", sdl.getError())
			setErrorFlag(dev, erLINK)
			return false
		}
		dev.sdlReady = true
	}

	var scale = windowScale
	if scale == 0 {
		scale = autoScale(dev.width, dev.height)
	}

	dev.window = sdl.createWindow(
		"RV32-EMU",
		sdl.windowposCentered,
		sdl.windowposCentered,
		Int32 (dev.width * scale), Int32 (dev.height * scale),
		sdl.windowShown
	)

	if dev.window != nil {
		dev.renderer = sdl.createRenderer(
			dev.window, -1,
			sdl.rendererAccelerated | sdl.rendererPresentvsync
		)
	}

	if dev.renderer != nil {
		dev.texture = sdl.createTexture(
			dev.renderer,
			sdl.pixelformatArgb8888,
			sdl.textureaccessStreaming,
			Int32 dev.width, Int32 dev.height
		)
	}

	if dev.texture == nil {
		printf("display: cannot create window: %s\n", sdl.getError())
		destroyWindow(dev)
		setErrorFlag(dev, erLINK)
		return false
	}

	dev.activeWidth = dev.width
	dev.activeHeight = dev.height
	dev.framecnt = 0
	dev.sr = srON

	// show black screen until the first refresh
	sdl.renderClear(dev.renderer)
	sdl.renderPresent(dev.renderer)

	return true
}


// largest integer scale that fits preferredWindowWidth x preferredWindowHeight
func autoScale (width: Nat32, height: Nat32) -> Nat32 {
	var scale = Nat32 1
	while width * (scale + 1) <= preferredWindowWidth and height * (scale + 1) <= preferredWindowHeight {
		scale += 1
	}
	return scale
}


func closeWindow (dev: *Device) -> Unit {
	destroyWindow(dev)
	dev.sr = 0
}


func destroyWindow (dev: *Device) -> Unit {
	if dev.texture != nil {
		sdl.destroyTexture(dev.texture)
		dev.texture = nil
	}
	if dev.renderer != nil {
		sdl.destroyRenderer(dev.renderer)
		dev.renderer = nil
	}
	if dev.window != nil {
		sdl.destroyWindow(dev.window)
		dev.window = nil
	}
}


func refresh (dev: *Device) -> Unit {
	if not isOn(dev) {
		setErrorFlag(dev, erOFF)
		return
	}

	let pitch = dev.activeWidth * Nat32 sizeof(Word32)
	let pixels = dev.memMap(dev.fb, pitch * dev.activeHeight)
	if pixels == nil or (Word32 dev.fb & 3) != 0 {
		printf("display: bad framebuffer address 0x%08x\n", dev.fb)
		setErrorFlag(dev, erFBMAP)
		return
	}

	sdl.updateTexture(dev.texture, nil, pixels, Int32 pitch)
	sdl.renderClear(dev.renderer)
	sdl.renderCopy(dev.renderer, dev.texture, nil, nil)
	sdl.renderPresent(dev.renderer)

	dev.framecnt += 1
}


// Handle window events; closing the window is a link failure
public func poll (dev: *Device) -> Unit {
	if not isOn(dev) {
		return
	}

	var event: sdl.Event
	while sdl.pollEvent(&event) != 0 {
		if eventType(&event) == sdl.quit {
			linkLost(dev)
			return
		}
	}
}


func linkLost (dev: *Device) -> Unit {
	printf("display: link lost\n")
	destroyWindow(dev)
	dev.cr = 0
	dev.sr = 0
	setErrorFlag(dev, erLINK)
}


// Block until the user closes the window
public func waitClose (dev: *Device) -> Unit {
	while isOn(dev) {
		poll(dev)
		sdl.delay(16)
	}
}


public func deinit (dev: *Device) -> Unit {
	closeWindow(dev)
	if dev.sdlReady {
		sdl.shutdown()
		dev.sdlReady = false
	}
}


func setErrorFlag (dev: *Device, e: Word32) -> Unit {
	dev.er = dev.er | e
}


// event type is the first 4 bytes of SDL_Event
func eventType (event: *sdl.Event) -> Nat32 {
	let p = unsafe(*Nat32 event)
	return *p
}

