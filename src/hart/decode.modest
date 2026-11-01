// hart/decode.modest
//

import "lightfood/bits32"


public func extractOp (instr: Word32) -> Word8 {
	return Word8 bits32.extract(value=instr, pos=0, len=7)
}


public func extractFunct2 (instr: Word32) -> Word8 {
	return Word8 bits32.extract(value=instr, pos=25, len=2)
}


public func extractFunct3 (instr: Word32) -> Word8 {
	return Word8 bits32.extract(value=instr, pos=12, len=3)
}


public func extractFunct5 (instr: Word32) -> Word8 {
	return Word8 bits32.extract(value=instr, pos=27, len=5)
}


public func extractRd (instr: Word32) -> Nat8 {
	return Nat8 Word8 bits32.extract(value=instr, pos=7, len=5)
}


public func extractRs1 (instr: Word32) -> Nat8 {
	return Nat8 Word8 bits32.extract(value=instr, pos=15, len=5)
}


public func extractRs2 (instr: Word32) -> Nat8 {
	return Nat8 Word8 bits32.extract(value=instr, pos=20, len=5)
}


public func extractFunct7 (instr: Word32) -> Word8 {
	return Word8 bits32.extract(value=instr, pos=25, len=7)
}


public func extractImm12 (instr: Word32) -> Word32 {
	return bits32.extract(value=instr, pos=20, len=12)
}


public func extractImm31_12 (instr: Word32) -> Word32 {
	return bits32.extract(value=instr, pos=12, len=20)
}


public func extractBImm (instr: Word32) -> Int16 {
	let imm4to1_11 = Word16 extractRd(instr)
	let imm12_10to5 = extractFunct7(instr)
	let bit4to1 = imm4to1_11 & 0x1E
	let bit10to5 = Word16 (imm12_10to5 & 0x3F) << 5
	let bit11 = (imm4to1_11 & 0x1) << 11
	let bit12 = Word16 (imm12_10to5 & 0x40) << 6

	var imm_bits = bit12 | bit11 | bit10to5 | bit4to1

	// распространяем знак (если он есть)
	if imm_bits & (Word16 1 << 12) != 0 {
		imm_bits = 0xF000 | imm_bits
	}

	return Int16 imm_bits
}


public func extractJalImm (instr: Word32) -> Word32 {
	let imm = extractImm31_12(instr)
	let bit19to12_msk = ((imm >> 0) & 0xFF) << 12
	let bit11_msk = ((imm >> 8) & 0x1) << 11
	let bit10to1 = ((imm >> 9) & 0x3FF) << 1
	let bit20_msk = ((imm >> 19) & 0x1) << 20
	return bit20_msk | bit19to12_msk | bit11_msk | bit10to1
}


// sign expand (12bit -> 32bit)
public func expand12 (val_12bit: Word32) -> Int32 {
	if val_12bit & 0x800 != 0 {
		return Int32 (val_12bit | 0xFFFFF000)
	}
	return Int32 val_12bit
}


// sign expand (20bit -> 32bit)
public func expand20 (val_20bit: Word32) -> Int32 {
	if val_20bit & 0x80000 != 0 {
		return Int32 (val_20bit | 0xFFF00000)
	}
	return Int32 val_20bit
}

