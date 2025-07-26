#

.global _start

.data
    bad1dea5: .asciz "BAD1DEA5"
    message: .asciz "%#zx\t%s\n"

.text
    _start:
        sub     $0x20, %sp

        call    crc64_initialize

        movq    $bad1dea5, %rdi
        movq    $8, %rsi
        call    crc64_generate

        movq    $message, %rdi
        movq    %rax, %rsi
        movq    $bad1dea5, %rdx
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
