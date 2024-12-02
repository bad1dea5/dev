.global _start

.text
    _start:
        mov     x0, 0x0
        mov     w8, 0x5d
        svc     #0
