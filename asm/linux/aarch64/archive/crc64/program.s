.global _start

.data
    title: .ascii "BAD1DEA5"                //  0x6F9E4FBB3ECFDD20
    title_length = . - title

.text
    _start:
        stp     x29, x30, [sp, -0x20]!
        mov     x29, sp

        bl      crc64_init

        adrp    x0, title
        add     x0, x0, :lo12:title

        mov     x1, title_length
        bl      crc64

        ldp     x29, x30, [sp, 0x20]

        mov     x0, 0x0
        mov     w8, 0x5d
        svc     #0
