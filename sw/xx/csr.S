# CSR access for display_blink/main.m
# (Modest has no inline asm)

.text
.align 2


# void irq_enable(uint32_t mie_mask);
# mie |= mie_mask; mstatus.MIE = 1
.global irq_enable
irq_enable:
	csrs mie, a0
	csrsi mstatus, 0x8
	ret
