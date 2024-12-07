.global _start

.data
	s1: .asciz "BAD1DEA5"
	s2: .asciz "BAD1DEA6"

.text
	_start:
		stp		x29, x30, [sp, 0x20]!
		mov		x29, sp

		adrp	x0, s1
		add		x0, x0, :lo12:s1
		str		x0, [sp, 0x10]

		adrp	x0, s2
		add		x0, x0, :lo12:s2
		str		x0, [sp, 0x18]

		ldr		x1, [sp, 0x18]
		ldr		x0, [sp, 0x10]
		bl		strcmp

		ldp		x29, x30, [sp], 0x20
//		mov		x0, 0x1
		mov		w8, 0x5d
		svc		0x0

