// printf - minimal printf for the VM console
// supports: %d %i %x %X %s %c %%, flag '0' and field width (%02X, %8d)

pragma unsafe

import "system"


@alias("putchar")
public func putchar (c: Char8) -> Unit {
	var x = c
	Unit system.write(0, unsafe(*[]Word8 &x), 1)
}


@alias("put_str8")
public func putStr8 (s: *Str8) -> Unit {
	var i: Nat32 = 0
	while s[i] != Char8 0 {
		putchar(s[i])
		i += 1
	}
}


// print is used by m2 code, printf by C code
@alias("print")
public func print (form: *Str8, ...) -> Int32 {
	var va: __VA_List
	__va_start(va, form)
	vprint(form, va)
	__va_end(va)
	return 0
}


@alias("printf")
public func printf (form: *Str8, ...) -> Int32 {
	var va: __VA_List
	__va_start(va, form)
	vprint(form, va)
	__va_end(va)
	return 0
}


func vprint (form: *Str8, va: __VA_List) -> Unit {
	var i: Nat32 = 0
	while form[i] != Char8 0 {
		var c = form[i]

		if c != Char8 "%" {
			putchar(c)
			i += 1
			again
		}

		i += 1
		c = form[i]

		// flag '0' and field width: %02X, %8d
		var pad = Char8 " "
		if c == Char8 "0" {
			pad = c
			i += 1
			c = form[i]
		}

		var width: Int32 = 0
		while isDigit(c) {
			width = width * 10 + digitValue(c)
			i += 1
			c = form[i]
		}

		// buffer for everything except strings
		var buf: [11 + 1]Char8
		var sptr = *Str8 &buf

		if c == Char8 "d" or c == Char8 "i" {
			sprintfDec32(&buf, __va_arg(va, Int32))
		} else if c == Char8 "x" {
			sprintfHex32(&buf, __va_arg(va, Word32), alpha=Char8 "a")
		} else if c == Char8 "X" {
			sprintfHex32(&buf, __va_arg(va, Word32), alpha=Char8 "A")
		} else if c == Char8 "s" {
			sptr = __va_arg(va, *Str8)
		} else if c == Char8 "c" {
			// char is promoted to int
			buf[0] = Char8 Word8 Word32 __va_arg(va, Int32)
		} else if c == Char8 "%" {
			sptr = "%"
		}

		var len: Int32 = 0
		while sptr[len] != Char8 0 {
			len += 1
		}
		while len < width {
			putchar(pad)
			len += 1
		}

		putStr8(sptr)

		i += 1
	}
}


@inline
func isDigit (c: Char8) -> Bool {
	let x = Nat8 Word8 c
	return x >= Nat8 Word8 Char8 "0" and x <= Nat8 Word8 Char8 "9"
}


@inline
func digitValue (c: Char8) -> Int32 {
	return Int32 (Nat8 Word8 c - Nat8 Word8 Char8 "0")
}


// alpha - "a" or "A" (lower/upper case digits)
func sprintfHex32 (buf: *[12]Char8, d: Word32, alpha: Char8) -> Unit {
	var cc: [8]Char8

	var x = d
	var i: Nat32 = 0
	while true {
		let n = Nat8 Word8 (x & 0xF)
		x = x >> 4

		if n <= 9 {
			cc[i] = Char8 Word8 (Nat8 Word8 Char8 "0" + n)
		} else {
			cc[i] = Char8 Word8 (Nat8 Word8 alpha + (n - 10))
		}
		i += 1

		if x == 0 {
			break
		}
	}

	// mirroring into buffer
	var j: Nat32 = 0
	while i != 0 {
		i -= 1
		buf[j] = cc[i]
		j += 1
	}

	buf[j] = Char8 0
}


func sprintfDec32 (buf: *[12]Char8, d: Int32) -> Unit {
	var cc: [11]Char8

	let neg = d < 0

	var x = d
	if neg {
		x = -d
	}

	var i: Nat32 = 0
	while true {
		let n = x % 10
		x = x / 10
		cc[i] = Char8 Word8 (Nat8 Word8 Char8 "0" + Nat8 Word8 Word32 n)
		i += 1

		if x == 0 {
			break
		}
	}

	var j: Nat32 = 0
	if neg {
		buf[0] = Char8 "-"
		j += 1
	}

	while i != 0 {
		i -= 1
		buf[j] = cc[i]
		j += 1
	}

	buf[j] = Char8 0
}


