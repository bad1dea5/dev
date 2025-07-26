#

.global crc64_generate
.global crc64_initialize

.bss
    .lcomm crc64_lookup_table, 256 * 8

.text
    #
    #   rdi     source      char*
    #   rsi     length      uint64
    #
    crc64_generate:
        sub     $0x20, %sp

        movq    %rdi, 0x0(%rsp)
        movq    %rsi, 0x8(%rsp)
        movq    $0, 0x10(%rsp)
        movq    $0, 0x18(%rsp)

        jmp     .compare_string_length

    .increment_byte:
        movq    0x10(%rsp), %rax
        shr     $56, %rax
        movq    %rax, %rcx

        movq    0x0(%rsp), %rax
        movzb   (%rax), %eax
        addq    $1, 0x0(%rsp)

        xorq    %rcx, %rax
        andl    $255, %eax

        movq    crc64_lookup_table(,%rax,8), %rax
        movq    0x10(%rsp), %rdx
        salq    $8, %rdx
        xorq    %rdx, %rax
        movq    %rax, 0x10(%rsp)

        addq    $1, 0x18(%rsp)

    .compare_string_length:
        movq    0x18(%rsp), %rax
        cmpq    0x8(%rsp), %rax
        jb      .increment_byte

        movq    0x10(%rsp), %rax

        add     $0x20, %sp
        ret
    
    #
    #
    #
    crc64_initialize:
        sub     $0x20, %sp

        movl    $0, 0x0(%rsp)
        jmp     .compare_table_index

    .loop_table_index:
        movq    $0, 0x8(%rsp)
        
        movl    0x0(%rsp), %eax
        cltq
        salq    $56, %rax
        movq    %rax, 0x10(%rsp)

        movl    $0, 0x4(%rsp)

        jmp     .compare_inner_loop

    .crc_calculation:
        movq    0x8(%rsp), %rax
        xorq    0x10(%rsp), %rax
        test    %rax, %rax
        jns     .shift_crc

        movq    0x8(%rsp), %rax
        leaq    (%rax,%rax), %rdx
        movabs  $0x42f0e1eba9ea3693, %rax
        xorq    %rdx, %rax
        movq    %rax, 0x8(%rsp)

        jmp     .shift_mask

    .shift_crc:
        salq    0x8(%rsp)

    .shift_mask:
        salq    0x10(%rsp)
        addl    $1, 0x4(%rsp)

    .compare_inner_loop:
        cmpl    $7, 0x4(%rsp)
        jle     .crc_calculation

        movl    0x0(%rsp), %eax
        cltq
        movq    0x8(%rsp), %rdx
        movq    %rdx, crc64_lookup_table(,%rax,8)

        addl    $1, 0x0(%rsp)

    .compare_table_index:
        cmpl    $255, 0x0(%rsp)
        jle     .loop_table_index

        add     $0x20, %sp
        ret
