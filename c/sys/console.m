// console - VM console MMIO

pragma unsafe

include "vm_sys"


public func put (x: Word32) -> Unit {
	let p = unsafe(*@volatile Word8 consolePrintChar8Adr)
	*p = Word8 x
}


public func get () -> Word32 {
	return 0
}


@alias("console_print_int")
public func printInt (x: Int32) -> Unit {
	let p = unsafe(*@volatile Int32 consolePrintInt32Adr)
	*p = x
}


@alias("console_print_uint")
public func printUInt (x: Nat32) -> Unit {
	let p = unsafe(*@volatile Nat32 consolePrintUInt32Adr)
	*p = x
}


@alias("console_print_uint_hex")
public func printUIntHex (x: Nat32) -> Unit {
	let p = unsafe(*@volatile Nat32 consolePrintUInt32HexAdr)
	*p = x
}


