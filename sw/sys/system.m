// system - minimal syscalls

import "console"


@alias("write")
public func write (fd: Int32, data: *[]Word8, len: Int32) -> Int32 {
	var i: Int32 = 0
	while i < len {
		console.put(Word32 data[i])
		++i
	}
	return i
}


