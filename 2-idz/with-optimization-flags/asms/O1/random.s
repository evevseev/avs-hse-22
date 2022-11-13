	.file	"random.c"
	.intel_syntax noprefix
	.text
	.globl	generate_random_string
	.type	generate_random_string, @function
generate_random_string:
	endbr64
	push	r15
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	sub	rsp, 8
	mov	r13, rdi
	mov	r15, rsi
	mov	ebp, edx
	mov	edi, ecx
	call	srand@PLT
	mov	rcx, -1
	mov	eax, 0
	mov	rdi, r13
	repnz scasb
	lea	r14d, -1[rbp]
	test	r14d, r14d
	jle	.L7
	not	rcx
	lea	r12d, -1[rcx]
	mov	ebx, 0
	jmp	.L6
.L11:
	test	r12d, r12d
	jle	.L4
	cmp	ebp, ebx
	jle	.L4
	mov	edx, ebx
	mov	eax, 1
	movsx	rbx, ebx
	add	rbx, r15
.L5:
	movzx	ecx, BYTE PTR -1[r13+rax]
	mov	BYTE PTR -1[rbx+rax], cl
	add	edx, 1
	cmp	r12d, eax
	setg	sil
	cmp	ebp, edx
	setg	cl
	add	rax, 1
	test	sil, cl
	jne	.L5
	mov	ebx, edx
.L4:
	cmp	ebx, r14d
	jge	.L2
.L6:
	call	rand@PLT
	test	al, 1
	je	.L11
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 715827883
	sar	rdx, 36
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	lea	edx, [rdx+rdx*2]
	sal	edx, 5
	sub	eax, edx
	add	al, 32
	je	.L4
	movsx	rdx, ebx
	mov	BYTE PTR [r15+rdx], al
	add	ebx, 1
	jmp	.L4
.L7:
	mov	ebx, 0
.L2:
	movsx	rbx, ebx
	mov	BYTE PTR [r15+rbx], 0
	add	rsp, 8
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
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
