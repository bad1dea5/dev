#

.global _start

.text
    _start:
        sub     $0x20, %sp

        jmp     exit_success

    exit_failure:
        movb    $-1, %dil
        jmp     exit

    exit_success:
        movb    $0, %dil

    exit:
        add     $0x20, %sp
        movl    $231, %eax
        syscall
        hlt
