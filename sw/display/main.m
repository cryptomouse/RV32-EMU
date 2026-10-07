// display - display controller demo: animated gradient

include "libc/stdio"
include "../sys/vm_sys"

import "../sys/display"


const frameWidth = Nat32 640
const frameHeight = Nat32 480
const frames = Nat32 1024

var frameBuffer: [frameHeight][frameWidth]display.Pixel


func main () -> Int {
	printf("display demo: %dx%d, %d frames\n", frameWidth, frameHeight, frames)

	let error = display.init(&frameBuffer, frameWidth, frameHeight)
	if error != display.errorNone {
		printf("display demo: cannot setup display, error: %d, ER: 0x%08x\n", Nat32 error, Nat32 display.getError())
		return 1
	}

	var offset: Nat32 = 0
	while offset < frames {
		draw(offset)
		display.update()

		// errors are sticky, e.g. ER.LINK when the window has been closed
		let e = display.getError()
		if e != 0 {
			printf("display demo: error, ER: 0x%08x\n", Nat32 e)
			if (e & displayErLINK) != 0 {
				printf("display demo: link to the display lost\n")
			}
			break
		}

		++offset
	}

	printf("frames shown: %d\n", display.getFrameCounter())

	return 0
}


func draw (offset: Nat32) -> Unit {
	var y: Nat32 = 0
	while y < frameHeight {
		var x: Nat32 = 0
		while x < frameWidth {
			let r = Word32 ((x + offset) % 256)
			let g = Word32 ((y + offset) % 256)
			let b = Word32 128
			frameBuffer[y][x] = display.Pixel (0xFF000000 | (r << 16) | (g << 8) | b)
			++x
		}
		++y
	}
}

