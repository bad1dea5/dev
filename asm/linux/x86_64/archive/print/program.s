.global _start

.data
    title: .ascii "BAD1DEA5\n"
    title_length = . - title

.text
    _start:
        movl    $0x1, %edi
        mov     $title, %rsi
        mov     $title_length, %rdx
        movl    $0x1, %eax
        syscall

        movl    $0x0, %edi
        movl    $0xe7, %eax
        syscall
        hlt
