// startup - C runtime init (called from _start, see vect.S)

pragma unsafe


// see mem.ld
@extern("C", "_bss_start") var bssStart: Word8
@extern("C", "_bss_end") var bssEnd: Word8
@extern("C", "_data_start") var dataStart: Word8
@extern("C", "_data_end") var dataEnd: Word8
@extern("C", "_data_flash_start") var dataFlashStart: Word8

// see base.S
@extern("C", "memset") func memset (mem: Ptr, x: Int32, len: Size) -> Ptr
@extern("C", "memcpy") func memcpy (dst: Ptr, src: Ptr, len: Size) -> Ptr

@extern("C", "main") func main () -> Int32


@alias("startup")
@section(".startup")
public func startup () -> Unit {
	// zero .bss
	let bssSize = unsafe(Nat32 &bssEnd) - unsafe(Nat32 &bssStart)
	Unit memset(&bssStart, 0, Size bssSize)

	// copy .data from FLASH to RAM
	let dataSize = unsafe(Nat32 &dataEnd) - unsafe(Nat32 &dataStart)
	Unit memcpy(&dataStart, &dataFlashStart, Size dataSize)

	Unit main()
}


