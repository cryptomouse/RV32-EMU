
#if !defined(BITS32_H)
#define BITS32_H
#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

__attribute__((always_inline))
inline uint32_t bits32_bitmask(uint8_t len) {
	return (((uint32_t)1 << len) - 1);
}

__attribute__((always_inline))
inline uint32_t bits32_extract(uint32_t value, uint8_t pos, uint8_t len) {
	return (value >> pos) & bits32_bitmask(len);
}

__attribute__((always_inline))
inline uint32_t bits32_insert(uint32_t value, uint32_t bitfield, uint8_t pos, uint8_t len) {
	return (value & ~(bits32_bitmask(len) << pos)) | ((bitfield & bits32_bitmask(len)) << pos);
}

__attribute__((always_inline))
inline uint32_t bits32_set(uint32_t x, uint8_t no) {
	const uint32_t mask = (uint32_t)1 << no;
	return x | mask;
}

__attribute__((always_inline))
inline uint32_t bits32_reset(uint32_t x, uint8_t no) {
	const uint32_t mask = (uint32_t)1 << no;
	return x & ~mask;
}

__attribute__((always_inline))
inline uint32_t bits32_switch(uint32_t x, uint8_t no, bool val) {
	if (val) {
		return bits32_set(x, no);
	} else {
		return bits32_reset(x, no);
	}
	return 0x0;
}

__attribute__((always_inline))
inline bool bits32_check(uint32_t x, uint8_t no) {
	const uint32_t mask = (uint32_t)1 << no;
	return (x & mask) != 0x0;
}
#endif

