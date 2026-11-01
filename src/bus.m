//
//

pragma unsafe


include "libc/stdio"
include "libc/stdlib"

import "mmio"
import "dev/display"


const showText = false


public type ReadInterface = (adr: Nat32, size: Nat8) -> Word32
public type WriteInterface = (adr: Nat32, value: Word32, size: Nat8) -> Unit
public type IrqInterface = () -> Unit

public type Interface = {
	read: *ReadInterface
	write: *WriteInterface
	irq: *IrqInterface
}

public type Connector = (interface: *Interface) -> Bool


// see mem.ld
const ramSize = Nat32 8 * 1024 * 1024
const ramStart = Nat32 0x10000000
const ramEnd = ramStart + ramSize

const romSize = Nat32 0x100000
const romStart = Nat32 0x00000000
const romEnd = romStart + romSize

const mmioSize = Nat32 0x01000000
const mmioStart = Nat32 0xF0000000
const mmioEnd = mmioStart + mmioSize


// display registers (offset in the MMIO region)
const displayMMIOAdr = Nat32 0x1000
const displayMMIOSize = Nat32 0x1000


const ramRegion  = {begin=ramStart, end=ramEnd}
const romRegion  = {begin=romStart, end=romEnd}
const mmioRegion = {begin=mmioStart, end=mmioEnd}
const displayRegion = {begin=mmioStart + displayMMIOAdr, end=mmioStart + displayMMIOAdr + displayMMIOSize}


var ram: [ramSize]Word8
var rom: [romSize]Word8

var displays: [1]display.Device


public func init () -> Unit {
	display.init(&displays[0], &ramPtr)
}


public func deinit () -> Unit {
	display.deinit(&displays[0])
}


// Service the devices (called periodically by the main loop)
public func poll () -> Unit {
	display.poll(&displays[0])
}


public func read (adr: Nat32, size: Nat8) -> Word32 {
	if isAdressInRegion(adr, ramRegion) {
		let offset = adr - ramRegion.begin
		let ptr: Ptr = &ram[offset]
		return readFrom(ptr, adr, size)

	} else if isAdressInRegion(adr, romRegion) {
		let offset = adr - romRegion.begin
		let ptr: Ptr = &rom[offset]
		return readFrom(ptr, adr, size)

	} else if isAdressInRegion(adr, displayRegion) {
		// 32-bit access only
		if size == 4 {
			return displays[0].read32(&displays[0], adr - displayRegion.begin)
		}

	} else if isAdressInRegion(adr, mmioRegion) {
		let offset = adr - mmioRegion.begin
		if size == 1 {
			return Word32 mmio.read8(offset)
		} else if size == 2 {
			return Word32 mmio.read16(offset)
		} else if size == 4 {
			return mmio.read32(offset)
		}

	} else {
		memoryViolation("r", adr)
	}

	return 0
}


public func write (adr: Nat32, value: Word32, size: Nat8) -> Unit {
	if isAdressInRegion(adr, ramRegion) {
		let offset = adr - ramRegion.begin
		let ptr: Ptr = &ram[offset]
		writeTo(ptr, adr, value, size)

	} else if isAdressInRegion(adr, displayRegion) {
		// 32-bit access only
		if size == 4 {
			displays[0].write32(&displays[0], adr - displayRegion.begin, value)
		}

	} else if isAdressInRegion(adr, mmioRegion) {
		let offset = adr - mmioRegion.begin
		if size == 1 {
			mmio.write8(offset, Word8 value)
		} else if size == 2 {
			mmio.write16(offset, Word16 value)
		} else if size == 4 {
			mmio.write32(offset, value)
		}

	} else if isAdressInRegion(adr, romRegion) {
		memoryViolation("w", adr)
	} else {
		memoryViolation("w", adr)
	}
}


func readFrom (ptr: Ptr, adr: Nat32, size: Nat8) -> Word32 {
	if size == 1 {
		return Word32 *(*Word8 ptr)
	} else if size == 2 {
		return Word32 *(*Word16 ptr)
	} else if size == 4 {
		return *(*Word32 ptr)
	}

	return 0
}


func writeTo (ptr: Ptr, adr: Nat32, value: Word32, size: Nat8) -> Unit {
	if size == 1 {
		*(*Word8 ptr) = Word8 value
	} else if size == 2 {
		*(*Word16 ptr) = Word16 value
	} else if size == 4 {
		*(*Word32 ptr) = value
	}
}


// Host pointer to guest RAM [adr, adr + size) or nil if it is not entirely in RAM
public func ramPtr (adr: Nat32, size: Nat32) -> Ptr {
	if adr < ramStart or adr >= ramEnd or size > ramEnd - adr {
		return nil
	}
	return &ram[adr - ramStart]
}


@inline
func isAdressInRegion (x: Nat32, region: {begin: Nat32, end: Nat32}) -> Bool {
	return x >= region.begin and x < region.end
}


private var memviolationCnt: Nat32 = 0
public func memoryViolation (rw: Char8, adr: Nat32) -> Unit {
	printf("*** MEMORY VIOLATION '%c' 0x%08x ***\n", rw, adr)
	if memviolationCnt > 10 {
		exit(1)
	}
	memviolationCnt += 1
//	memoryViolation_event(0x55) // !
}


public func load_rom (filename: *Str8) -> Nat32 {
	return load(filename, &rom, romSize)
}


func load (filename: *Str8, bufptr: *[]Word8, buf_size: Nat32) -> Nat32 {
	printf("LOAD: %s\n", filename)

	let fp = fopen(filename, "rb")

	if fp == nil {
		printf("error: cannot open file '%s'", filename)
		return 0
	}

	let n = fread(bufptr, 1, SizeT buf_size, fp)

	printf("LOADED: %zu bytes\n", n)

	if showText {
		var i = SizeT 0
		while i < (n / 4) {
			printf("%08zx: 0x%08x\n", i, (unsafe(*[]Nat32 bufptr))[i])
			i = i + 4
		}

		printf("-----------\n")
	}

	fclose(fp)

	return unsafe(Nat32 n)
}


public func show_ram () -> Unit {
	var i = Nat32 0
	let ramptr = &ram
	while i < 256 {
		printf("%08X", i * 16)

		var j = Nat32 0
		while j < 16 {
			printf(" %02X", ramptr[i + j]);
			j = j + 1
		}

		printf("\n")

		i = i + 16
	}
}

