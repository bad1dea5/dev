#

.global _start

.data
    message: .asciz "%#zx\t%#zx → %s\n"

.text
    _start:
        sub     $0x20, %sp

        call    crc64_initialize

        leaq    _DYNAMIC, %rax
        movq    %rax, 0x0(%rsp)

        jmp     .is_dynamic_section_valid

    .is_debug_section:
        movq    0x0(%rsp), %rax
        movq    (%rax), %rax
        cmpq    $21, %rax
        jne     .increment_dynamic_section

        movq    0x0(%rsp), %rax
        movq    0x8(%rax), %rax
        movq    %rax, 0x8(%rsp)                 # r_debug

        movq    0x8(%rsp), %rax
        movq    0x8(%rax), %rax
        movq    %rax, 0x10(%rsp)                # link_map

        jmp     .is_linkmap_valid

    .next_linkmap:
        leaq    0x18(%rsp), %rdx
        movq    $255, %rsi
        movq    0x10(%rsp), %rax
        movq    0x8(%rax), %rdi
        call    strlen_s

        cmpq    $0, 0x18(%rsp)
        jz      .increment_linkmap

        movq    0x18(%rsp), %rsi
        movq    0x10(%rsp), %rax
        movq    0x8(%rax), %rdi
        call    crc64_generate
        
        movq    %rax, %rsi

        movq    0x10(%rsp), %rax
        movq    0x8(%rax), %rcx
        movq    (%rax), %rdx

        movq    $message, %rdi
        call    printf

    .increment_linkmap:
        movq    0x10(%rsp), %rax
        movq    0x18(%rax), %rax
        movq    %rax, 0x10(%rsp)

    .is_linkmap_valid:
        cmpq    $0, 0x10(%rsp)
        jne     .next_linkmap

    .increment_dynamic_section:
        addq    $0x10, 0x0(%rsp)

    .is_dynamic_section_valid:
        movq    0x0(%rsp), %rax
        movq    (%rax), %rax
        test    %rax, %rax
        jne     .is_debug_section

        jmp     .exit_success

    .exit_failure:
        movb    $-1, %dil
        jmp     .exit

    .exit_success:
        movb    $0, %dil

    .exit:
        add     $0x20, %sp
        movl    $231, %eax
        syscall
        hlt
