
.global vectors
.global _stack_start
.global _stack_end
.global _trap
.global __mem_violation
.global trap_empty
.global system
.global _start


.section .isr_vector, "ax"
.align 8

vectors:
	jr zero, %lo(_start)
	jr zero, %lo(trap_empty)
	jr zero, %lo(trap_empty)
	jr zero, %lo(trap_empty)
	jr zero, %lo(trap_empty)
	jr zero, %lo(trap_empty)
	jr zero, %lo(trap_empty)
	jr zero, %lo(trap_empty)
	jr zero, %lo(trap_empty)
	jr zero, %lo(system)
	jr zero, %lo(trap_empty)
	jr zero, %lo(trap_empty)
	jr zero, %lo(__mem_violation)
	jr zero, %lo(trap_empty)
	jr zero, %lo(trap_empty)


.section .text
.align 2

# trap handler (mtvec): сохраняем caller-saved регистры,
# т.к. __isr - обычная C-функция и может их испортить
_trap:
	addi sp, sp, -64
	sw ra, 0(sp)
	sw t0, 4(sp)
	sw t1, 8(sp)
	sw t2, 12(sp)
	sw a0, 16(sp)
	sw a1, 20(sp)
	sw a2, 24(sp)
	sw a3, 28(sp)
	sw a4, 32(sp)
	sw a5, 36(sp)
	sw a6, 40(sp)
	sw a7, 44(sp)
	sw t3, 48(sp)
	sw t4, 52(sp)
	sw t5, 56(sp)
	sw t6, 60(sp)

	jal ra, __isr

	lw ra, 0(sp)
	lw t0, 4(sp)
	lw t1, 8(sp)
	lw t2, 12(sp)
	lw a0, 16(sp)
	lw a1, 20(sp)
	lw a2, 24(sp)
	lw a3, 28(sp)
	lw a4, 32(sp)
	lw a5, 36(sp)
	lw a6, 40(sp)
	lw a7, 44(sp)
	lw t3, 48(sp)
	lw t4, 52(sp)
	lw t5, 56(sp)
	lw t6, 60(sp)
	addi sp, sp, 64
	mret


_start:
	# setup stack pointer
	lui sp, %hi(_stack_start)
	addi sp, sp, %lo(_stack_start)

	# setup mtvec
	lui a0, %hi(_trap)
	addi a0, a0, %lo(_trap)
	csrrw zero, mtvec, a0

	jal ra, startup

	ebreak

	j trap_empty



__mem_violation:
	#j __mem_violation
	ebreak


system:
	ebreak
	mret
	#j system


trap_empty:
	j trap_empty


.weak __isr
__isr:
	ret

