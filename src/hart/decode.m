//
//

pragma public_module


@inline
func bitmask32 (len: Nat8) -> Word32 {
	return Word32 (Nat32 (Word32 1 << len) - 1)
}


@inline
func extract32 (value: Word32, pos: Nat8, len: Nat8) -> Word32 {
	return (value >> (pos - len)) & bitmask32(len)
}


func extractOp (instr: Word32) -> Word8 {
	return Word8 extract32(value=instr, pos=7, len=7)
}


func extractFunct2 (instr: Word32) -> Word8 {
	return Word8 extract32(value=instr, pos=25+2, len=2)
}


func extractFunct3 (instr: Word32) -> Word8 {
	return Word8 extract32(value=instr, pos=12+3, len=3)
}


func extractFunct5 (instr: Word32) -> Word8 {
	return Word8 extract32(value=instr, pos=27+6, len=6)
}


func extractRd (instr: Word32) -> Nat8 {
	return Nat8 Word8 extract32(value=instr, pos=7+5, len=5)
}


func extractRs1 (instr: Word32) -> Nat8 {
	return Nat8 Word8 extract32(value=instr, pos=15+5, len=5)
}


func extractRs2 (instr: Word32) -> Nat8 {
	return Nat8 Word8 extract32(value=instr, pos=20+5, len=5)
}


func extractFunct7 (instr: Word32) -> Word8 {
	return Word8 extract32(value=instr, pos=25+7, len=7)
}


func extractImm12 (instr: Word32) -> Word32 {
	return extract32(value=instr, pos=20+12, len=12)
}


func extractImm31_12 (instr: Word32) -> Word32 {
	return extract32(value=instr, pos=12+20, len=20)
}


func extractBImm (instr: Word32) -> Int16 {
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


func extractJalImm (instr: Word32) -> Word32 {
	let imm = extractImm31_12(instr)
	let bit19to12_msk = ((imm >> 0) & 0xFF) << 12
	let bit11_msk = ((imm >> 8) & 0x1) << 11
	let bit10to1 = ((imm >> 9) & 0x3FF) << 1
	let bit20_msk = ((imm >> 20) & 0x1) << 20
	return bit20_msk | bit19to12_msk | bit11_msk | bit10to1
}


// sign expand (12bit -> 32bit)
func expand12 (val_12bit: Word32) -> Int32 {
	if val_12bit & 0x800 != 0 {
		return Int32 (val_12bit | 0xFFFFF000)
	}
	return Int32 val_12bit
}


// sign expand (20bit -> 32bit)
func expand20 (val_20bit: Word32) -> Int32 {
	if val_20bit & 0x80000 != 0 {
		return Int32 (val_20bit | 0xFFF00000)
	}
	return Int32 val_20bit
}

