	.file	"random.c"
	.intel_syntax noprefix
	.text
	.globl	generate_random_string
	.type	generate_random_string, @function
generate_random_string:
	endbr64
	push	r15
	push	r14
	xor	r14d, r14d
	push	r13
	push	r12
	mov	r12d, edx
	push	rbp
	mov	rbp, rdi
	mov	edi, ecx
	push	rbx
	mov	rbx, rsi
	sub	rsp, 24
	call	srand@PLT
	xor	eax, eax
	or	rcx, -1
	mov	rdi, rbp
	repnz scasb
	not	rcx
	lea	eax, -1[rcx]
	mov	DWORD PTR 8[rsp], eax
	lea	eax, -1[r12]
	mov	DWORD PTR 12[rsp], eax
.L2:
	movsx	r15, r14d
	lea	r13, [rbx+r15]
	cmp	DWORD PTR 12[rsp], r14d
	jle	.L19
	call	rand@PLT
	test	al, 1
	jne	.L16
	xor	eax, eax
.L3:
	mov	r14d, r15d
	cmp	DWORD PTR 8[rsp], eax
	jle	.L2
	cmp	r12d, r15d
	jle	.L2
	mov	cl, BYTE PTR 0[rbp+rax]
	inc	rax
	mov	BYTE PTR [rbx+r15], cl
	inc	r15
	jmp	.L3
.L16:
	call	rand@PLT
	mov	esi, 96
	cdq
	idiv	esi
	add	dl, 32
	je	.L2
	mov	BYTE PTR 0[r13], dl
	inc	r14d
	jmp	.L2
.L19:
	mov	BYTE PTR 0[r13], 0
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
