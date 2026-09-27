
# CSR access & system instructions for misa/main.m
# (Modest has no inline asm)

.text
.align 2


# uint32_t read_misa(void);
.global read_misa
read_misa:
	csrr a0, misa
	ret


# uint32_t read_mhartid(void);
.global read_mhartid
read_mhartid:
	csrr a0, mhartid
	ret


# uint64_t read_mcycle(void);
# re-read mcycleh until it is stable (mcycle may overflow between reads)
.global read_mcycle
read_mcycle:
	csrr a1, mcycleh
	csrr a0, mcycle
	csrr t0, mcycleh
	bne a1, t0, read_mcycle
	ret


# void ecall(void);
.global ecall
ecall:
	ecall
	ret


# void ebreak(void);
.global ebreak
ebreak:
	ebreak
	ret
