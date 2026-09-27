// muldivmod - soft mul/div/mod for rv32i (libgcc ABI)
// NOTE: must not use '*', '/' and '%' itself

@alias("__mulsi3")
public func mulsi3 (a: Int32, b: Int32) -> Int32 {
	var n: Int32 = 0
	var i = b
	while i != 0 {
		n = n + a
		i = i - 1
	}
	return n
}


@alias("__modsi3")
public func modsi3 (divident: Int32, divisor: Int32) -> Int32 {
	if divisor == 0 {
		// x / 0 (!)
		return -1
	}

	var x = divident
	while x >= divisor {
		x = x - divisor
	}

	return x
}


@alias("__divsi3")
public func divsi3 (divident: Int32, divisor: Int32) -> Int32 {
	if divisor == 0 {
		// x / 0 (!)
		return -1
	}

	var x = divident
	var r: Int32 = 0
	while true {
		x = x - divisor

		if x < 0 {
			break
		}

		r = r + 1

		if x == 0 {
			break
		}
	}

	return r
}


