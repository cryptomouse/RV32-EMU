// display - display controller demo: animated gradient

pragma unsafe

include "libc/stdio"
include "../sys/vm_sys"


const width = Nat32 640
const height = Nat32 480
const frames = Nat32 1024

// framebuffer in RAM, ARGB8888: [row][column]
var framebuffer: [height][width]Word32


@inline
func reg (adr: Word32) -> *@volatile Word32 {
	return unsafe(*@volatile Word32 adr)
}


func draw (offset: Nat32) -> Unit {
	var y: Nat32 = 0
	while y < height {
		var x: Nat32 = 0
		while x < width {
			let r = Word32 ((x + offset) % 256)
			let g = Word32 ((y + offset) % 256)
			let b = Word32 128
			framebuffer[y][x] = 0xFF000000 | (r << 16) | (g << 8) | b
			++x
		}
		++y
	}
}


func main () -> Int {
	printf("display demo: %dx%d, %d frames\n", width, height, frames)

	*reg(displayWidth) = Word32 width
	*reg(displayHeight) = Word32 height
	*reg(displayFB) = Word32 unsafe(Nat32 &framebuffer)
	*reg(displayCR) = displayCrEN

	if (*reg(displaySR) & displaySrON) == 0 {
		printf("display: cannot enable\n")
		return 1
	}

	var offset: Nat32 = 0
	while offset < frames {
		draw(offset)
		*reg(displayRefresh) = 1
		++offset
	}

	printf("frames shown: %d\n", *reg(displayFrame))

	return 0
}

