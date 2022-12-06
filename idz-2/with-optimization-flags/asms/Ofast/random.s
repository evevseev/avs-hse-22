	.file	"random.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	generate_random_string
	.type	generate_random_string, @function
generate_random_string:
	endbr64
	push	r15
	push	r14
	push	r13
	mov	r13, rdi
	mov	edi, ecx
	push	r12
	push	rbp
	mov	ebp, edx
	push	rbx
	sub	rsp, 24
	mov	QWORD PTR [rsp], rsi
	call	srand@PLT
	mov	rdi, r13
	call	strlen@PLT
	mov	r12d, eax
	lea	eax, -1[rbp]
	mov	DWORD PTR 12[rsp], eax
	test	eax, eax
	jle	.L7
	xor	ebx, ebx
	xor	r14d, r14d
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L3:
	call	rand@PLT
	movsx	rcx, eax
	mov	esi, eax
	imul	rcx, rcx, 715827883
	sar	esi, 31
	sar	rcx, 36
	sub	ecx, esi
	lea	ecx, [rcx+rcx*2]
	sal	ecx, 5
	sub	eax, ecx
	add	al, 32
	je	.L4
	mov	BYTE PTR [r15], al
	add	ebx, 1
.L20:
	mov	rax, QWORD PTR [rsp]
	movsx	r14, ebx
	lea	r15, [rax+r14]
.L4:
	cmp	ebx, DWORD PTR 12[rsp]
	jge	.L2
.L6:
	call	rand@PLT
	mov	rdx, QWORD PTR [rsp]
	lea	r15, [rdx+r14]
	test	al, 1
	jne	.L3
	test	r12d, r12d
	jle	.L4
	cmp	ebp, ebx
	jle	.L4
	mov	eax, 1
	.p2align 4,,10
	.p2align 3
.L5:
	movzx	ecx, BYTE PTR -1[r13+rax]
	add	ebx, 1
	cmp	r12d, eax
	setg	sil
	cmp	ebp, ebx
	mov	BYTE PTR -1[r15+rax], cl
	setg	cl
	add	rax, 1
	test	sil, cl
	jne	.L5
	jmp	.L20
.L7:
	mov	r15, QWORD PTR [rsp]
.L2:
	mov	BYTE PTR [r15], 0
	add	rsp, 24
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
