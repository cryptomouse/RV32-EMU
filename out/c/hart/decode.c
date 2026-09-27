
#include "decode.h"
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include "bits32.h"

uint8_t decode_extractOp(uint32_t instr) {
	return (uint8_t)bits32_extract(instr, 0, 7);
}

uint8_t decode_extractFunct2(uint32_t instr) {
	return (uint8_t)bits32_extract(instr, 25, 2);
}

uint8_t decode_extractFunct3(uint32_t instr) {
	return (uint8_t)bits32_extract(instr, 12, 3);
}

uint8_t decode_extractFunct5(uint32_t instr) {
	return (uint8_t)bits32_extract(instr, 27, 5);
}

uint8_t decode_extractRd(uint32_t instr) {
	return (uint8_t)bits32_extract(instr, 7, 5);
}

uint8_t decode_extractRs1(uint32_t instr) {
	return (uint8_t)bits32_extract(instr, 15, 5);
}

uint8_t decode_extractRs2(uint32_t instr) {
	return (uint8_t)bits32_extract(instr, 20, 5);
}

uint8_t decode_extractFunct7(uint32_t instr) {
	return (uint8_t)bits32_extract(instr, 25, 7);
}

uint32_t decode_extractImm12(uint32_t instr) {
	return bits32_extract(instr, 20, 12);
}

uint32_t decode_extractImm31_12(uint32_t instr) {
	return bits32_extract(instr, 12, 20);
}

int16_t decode_extractBImm(uint32_t instr) {
	const uint16_t imm4to1_11 = (uint16_t)decode_extractRd(instr);
	const uint8_t imm12_10to5 = decode_extractFunct7(instr);
	const uint16_t bit4to1 = imm4to1_11 & 0x1E;
	const uint16_t bit10to5 = (uint16_t)(imm12_10to5 & 0x3F) << 5;
	const uint16_t bit11 = (imm4to1_11 & 0x1) << 11;
	const uint16_t bit12 = (uint16_t)(imm12_10to5 & 0x40) << 6;
	uint16_t imm_bits = bit12 | bit11 | bit10to5 | bit4to1;
	if ((imm_bits & ((uint16_t)1 << 12)) != 0x0) {
		imm_bits = 0xF000 | imm_bits;
	}
	return (int16_t)imm_bits;
}

uint32_t decode_extractJalImm(uint32_t instr) {
	const uint32_t imm = decode_extractImm31_12(instr);
	const uint32_t bit19to12_msk = ((imm >> 0) & 0xFF) << 12;
	const uint32_t bit11_msk = ((imm >> 8) & 0x1) << 11;
	const uint32_t bit10to1 = ((imm >> 9) & 0x3FF) << 1;
	const uint32_t bit20_msk = ((imm >> 19) & 0x1) << 20;
	return bit20_msk | bit19to12_msk | bit11_msk | bit10to1;
}

int32_t decode_expand12(uint32_t val_12bit) {
	if ((val_12bit & 0x800) != 0x0) {
		return (int32_t)(val_12bit | 0xFFFFF000UL);
	}
	return (int32_t)val_12bit;
}

int32_t decode_expand20(uint32_t val_20bit) {
	if ((val_20bit & 0x80000) != 0x0) {
		return (int32_t)(val_20bit | 0xFFF00000UL);
	}
	return (int32_t)val_20bit;
}

