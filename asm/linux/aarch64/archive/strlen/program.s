.global _start

.data
	title: .asciz "BAD1DEA5"
	title_length = . - title
	
	format: .asciz "%d\n"

.text
	_start:
		stp		x29, x30, [sp, 0x10]!
		mov		x29, sp

		adrp	x0, title
		add		x0, x0, :lo12:title
		str		x0, [sp, 0x0]
		str		xzr, [sp, 0x8]

		add		x0, sp, 0x8
		mov		x2, x0
		mov		x1, 0xff
		ldr		x0, [sp, 0x0]
		bl		strlen

		ldr		x0, [sp, 0x8]
		mov		x1, x0
		adrp	x0, format
		add		x0, x0, :lo12:format
		bl		printf

		mov		w0, 0x0

		ldp		x29, x30, [sp], 0x10
		mov		x0, 0x1
		mov		w8, 0x5d
		svc		0x0

