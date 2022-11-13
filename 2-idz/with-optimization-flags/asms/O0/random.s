	.file	"random.c"
	.intel_syntax noprefix
	.text
	.globl	generate_random_string
	.type	generate_random_string, @function
generate_random_string:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	QWORD PTR -24[rbp], rdi
	mov	QWORD PTR -32[rbp], rsi
	mov	DWORD PTR -36[rbp], edx
	mov	DWORD PTR -40[rbp], ecx
	mov	eax, DWORD PTR -40[rbp]
	mov	edi, eax
	call	srand@PLT
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	strlen@PLT
	mov	DWORD PTR -12[rbp], eax
	mov	DWORD PTR -8[rbp], 0
	jmp	.L2
.L6:
	call	rand@PLT
	and	eax, 1
	test	eax, eax
	jne	.L3
	mov	DWORD PTR -4[rbp], 0
	jmp	.L4
.L5:
	mov	eax, DWORD PTR -4[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rdx
	mov	edx, DWORD PTR -8[rbp]
	movsx	rcx, edx
	mov	rdx, QWORD PTR -32[rbp]
	add	rdx, rcx
	movzx	eax, BYTE PTR [rax]
	mov	BYTE PTR [rdx], al
	add	DWORD PTR -8[rbp], 1
	add	DWORD PTR -4[rbp], 1
.L4:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -12[rbp]
	jge	.L2
	mov	eax, DWORD PTR -8[rbp]
	cmp	eax, DWORD PTR -36[rbp]
	jl	.L5
	jmp	.L2
.L3:
	call	rand@PLT
	mov	edx, eax
	movsx	rax, edx
	imul	rax, rax, 715827883
	shr	rax, 32
	mov	ecx, eax
	sar	ecx, 4
	mov	eax, edx
	sar	eax, 31
	sub	ecx, eax
	mov	eax, ecx
	add	eax, eax
	add	eax, ecx
	sal	eax, 5
	mov	ecx, edx
	sub	ecx, eax
	mov	eax, ecx
	add	eax, 32
	mov	BYTE PTR -13[rbp], al
	cmp	BYTE PTR -13[rbp], 0
	je	.L2
	mov	eax, DWORD PTR -8[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -32[rbp]
	add	rdx, rax
	movzx	eax, BYTE PTR -13[rbp]
	mov	BYTE PTR [rdx], al
	add	DWORD PTR -8[rbp], 1
.L2:
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, 1
	cmp	DWORD PTR -8[rbp], eax
	jl	.L6
	mov	eax, DWORD PTR -8[rbp]
	movsx	rdx, eax
	mov	rax, QWORD PTR -32[rbp]
	add	rax, rdx
	mov	BYTE PTR [rax], 0
	nop
	leave
	ret
	.size	generate_random_string, .-generate_random_string
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
