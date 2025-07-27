.global strlen_s

.text
    strlen_s:
        sub     $0x20, %rsp

        movq    %rdi, 0x0(%rsp)
        movq    %rsi, 0x8(%rsp)
        movq    %rdx, 0x10(%rsp)

        movq    %rsi, 0x18(%rsp)

        cmpq    $0, 0x0(%rsp)
        je      .exit_failure

        cmpq    $0, 0x8(%rsp)
        je      .exit_failure

    .compare_byte:
        cmpq    $0, 0x8(%rsp)
        je      .null_or_max_reached

        movq    0x0(%rsp), %rax
        movzbl  (%rax), %eax
        testb   %al, %al
        je      .null_or_max_reached

        addq    $1, 0x0(%rsp)
        subq    $1, 0x8(%rsp)

        jmp     .compare_byte

    .null_or_max_reached:
        cmpq    $0, 0x10(%rsp)
        je      .exit_success

        movq    0x18(%rsp), %rax
        subq    0x8(%rsp), %rax

        movq    0x10(%rsp), %rdx
        movq    %rax, (%rdx)

    .exit_success:
        movl    $0, %eax
        addq    $0x20, %rsp
        ret

    .exit_failure:
        movl    $-1, %eax
        addq    $0x20, %rsp
        ret
