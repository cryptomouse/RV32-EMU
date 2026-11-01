// muldivmod - soft mul/div/mod for rv32i (libgcc ABI)
// NOTE: must not use '*', '/' and '%' itself

// 32-bit mul/div/mod: rv32i has no M extension at all.
// Signed variants work on magnitudes and fix the sign afterwards.
// x / 0 follows RISC-V div: quotient = all ones, remainder = dividend

// shift-add; the low 32 bits of a product don't depend on signedness
func mul32 (a: Word32, b: Word32) -> Word32 {
	var r: Nat32 = 0
	var x = a
	var y = b
	while y != 0 {
		if y & 1 != 0 {
			r = r + Nat32 x
		}
		x = x << 1
		y = y >> 1
	}
	return Word32 r
}

@alias("__mulsi3")
public func mulsi3 (a: Int32, b: Int32) -> Int32 {
	return Int32 mul32(Word32 a, Word32 b)
}


type DivMod32 = {
	quot: Nat32
	rem: Nat32
}


// restoring shift-subtract division, one quotient bit per step
func udivmod32 (n: Nat32, d: Nat32) -> DivMod32 {
	if Word32 d >> 31 != 0 {
		// d >= 2^31: quotient is 0 or 1 (and r << 1 below would overflow)
		if n >= d {
			return {quot = 1, rem = n - d}
		}
		return {quot = 0, rem = n}
	}

	var q: Word32 = 0
	var r: Nat32 = 0
	var i: Nat32 = 32
	while i > 0 {
		i = i - 1
		r = Nat32 ((Word32 r << 1) | ((Word32 n >> i) & 1))
		q = q << 1
		if r >= d {
			r = r - d
			q = q | 1
		}
	}

	return {quot = Nat32 q, rem = r}
}


// two's complement negation (Int32 -> Nat32 construction is abs() from
// libc, which we don't have; and -INT32_MIN would overflow)
func neg32 (x: Nat32) -> Nat32 {
	return Nat32 (~(Word32 x)) + 1
}

func absInt32 (x: Int32) -> Nat32 {
	let u = Nat32 Word32 x
	if x < 0 {
		return neg32(u)
	}
	return u
}

// Nat32 -> Int32 keeping the bits (2^31 -> INT32_MIN)
func toInt32 (x: Nat32) -> Int32 {
	return Int32 Word32 x
}


@alias("__udivsi3")
public func udivsi3 (divident: Nat32, divisor: Nat32) -> Nat32 {
	return udivmod32(divident, divisor).quot
}


@alias("__umodsi3")
public func umodsi3 (divident: Nat32, divisor: Nat32) -> Nat32 {
	return udivmod32(divident, divisor).rem
}


// quotient truncates toward zero: negative when signs differ
@alias("__divsi3")
public func divsi3 (divident: Int32, divisor: Int32) -> Int32 {
	if divisor == 0 {
		// x / 0 (!)
		return -1
	}
	let q = udivmod32(absInt32(divident), absInt32(divisor)).quot
	if (divident < 0) != (divisor < 0) {
		return toInt32(neg32(q))
	}
	return toInt32(q)
}


// remainder takes the sign of the divident (as in C)
@alias("__modsi3")
public func modsi3 (divident: Int32, divisor: Int32) -> Int32 {
	let r = udivmod32(absInt32(divident), absInt32(divisor)).rem
	if divident < 0 {
		return toInt32(neg32(r))
	}
	return toInt32(r)
}



// 64-bit div/mod: rv32im's div/rem are 32-bit only,
// so the compiler calls these for Int64/Nat64 '/' and '%'.
// x / 0 follows RISC-V div: quotient = all ones, remainder = dividend

type DivMod64 = {
	quot: Nat64
	rem: Nat64
}


// restoring shift-subtract division, one quotient bit per step
func udivmod64 (n: Nat64, d: Nat64) -> DivMod64 {
	if Word64 d >> 63 != 0 {
		// d >= 2^63: quotient is 0 or 1 (and r << 1 below would overflow)
		if n >= d {
			return {quot = 1, rem = n - d}
		}
		return {quot = 0, rem = n}
	}

	var q: Word64 = 0
	var r: Nat64 = 0
	var i: Nat32 = 64
	while i > 0 {
		i = i - 1
		r = Nat64 ((Word64 r << 1) | ((Word64 n >> i) & 1))
		q = q << 1
		if r >= d {
			r = r - d
			q = q | 1
		}
	}

	return {quot = Nat64 q, rem = r}
}


// two's complement negation (Int64 -> Nat64 construction is abs() via
// llabs(), which we don't have; and -INT64_MIN would overflow)
func neg64 (x: Nat64) -> Nat64 {
	return Nat64 (~(Word64 x)) + 1
}

func absInt64 (x: Int64) -> Nat64 {
	let u = Nat64 Word64 x
	if x < 0 {
		return neg64(u)
	}
	return u
}

// Nat64 -> Int64 keeping the bits (2^63 -> INT64_MIN)
func toInt64 (x: Nat64) -> Int64 {
	return Int64 Word64 x
}


@alias("__udivdi3")
public func udivdi3 (divident: Nat64, divisor: Nat64) -> Nat64 {
	return udivmod64(divident, divisor).quot
}


@alias("__umoddi3")
public func umoddi3 (divident: Nat64, divisor: Nat64) -> Nat64 {
	return udivmod64(divident, divisor).rem
}


// quotient truncates toward zero: negative when signs differ
@alias("__divdi3")
public func divdi3 (divident: Int64, divisor: Int64) -> Int64 {
	if divisor == 0 {
		// x / 0 (!)
		return -1
	}
	let q = udivmod64(absInt64(divident), absInt64(divisor)).quot
	if (divident < 0) != (divisor < 0) {
		return toInt64(neg64(q))
	}
	return toInt64(q)
}


// remainder takes the sign of the divident (as in C)
@alias("__moddi3")
public func moddi3 (divident: Int64, divisor: Int64) -> Int64 {
	let r = udivmod64(absInt64(divident), absInt64(divisor)).rem
	if divident < 0 {
		return toInt64(neg64(r))
	}
	return toInt64(r)
}



// shift-add, as mul32
@alias("__muldi3")
public func muldi3 (a: Int64, b: Int64) -> Int64 {
	var r: Nat64 = 0
	var x = Word64 a
	var y = Word64 b
	while y != 0 {
		if y & 1 != 0 {
			r = r + Nat64 x
		}
		x = x << 1
		y = y >> 1
	}
	return Int64 Word64 r
}

