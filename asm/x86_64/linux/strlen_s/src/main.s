#

.global _start

.data
    bad1dea5: .asciz "BAD1DEA5"
    message: .asciz "%s length is %i\n"

.text
    _start:
        sub     $0x20, %sp

        movq    $bad1dea5, %rdi
        movq    $255, %rsi
        leaq    0x0(%rsp), %rdx
        call    strlen_s

        movq    $message, %rdi
        movq    $bad1dea5, %rsi
        movq    0x0(%rsp), %rdx
        call    printf

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
