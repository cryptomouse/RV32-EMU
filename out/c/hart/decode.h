
#if !defined(DECODE_H)
#define DECODE_H
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

__attribute__((always_inline))
inline uint32_t decode_bitmask32(uint8_t len) {
	return (((uint32_t)1 << len) - 1);
}

__attribute__((always_inline))
inline uint32_t decode_extract32(uint32_t value, uint8_t pos, uint8_t len) {
	return (value >> (pos - len)) & decode_bitmask32(len);
}
uint8_t decode_extractOp(uint32_t instr);
uint8_t decode_extractFunct2(uint32_t instr);
uint8_t decode_extractFunct3(uint32_t instr);
uint8_t decode_extractFunct5(uint32_t instr);
uint8_t decode_extractRd(uint32_t instr);
uint8_t decode_extractRs1(uint32_t instr);
uint8_t decode_extractRs2(uint32_t instr);
uint8_t decode_extractFunct7(uint32_t instr);
uint32_t decode_extractImm12(uint32_t instr);
uint32_t decode_extractImm31_12(uint32_t instr);
int16_t decode_extractBImm(uint32_t instr);
uint32_t decode_extractJalImm(uint32_t instr);
int32_t decode_expand12(uint32_t val_12bit);
int32_t decode_expand20(uint32_t val_20bit);
#endif

