	.file	"random.c"
	.intel_syntax noprefix
	.text
	.globl	random_fill_array
	.type	random_fill_array, @function
random_fill_array:
	endbr64
	push	r14
	xor	r14d, r14d
	push	r13
	mov	r13d, 100
	push	r12
	mov	r12d, esi
	push	rbp
	mov	rbp, rdi
	mov	edi, edx
	push	rbx
	lea	ebx, [r12+r12*2]
	call	srand@PLT
	mov	eax, ebx
	mov	ecx, 4
	cdq
	idiv	ecx
	movsx	rbx, eax
.L2:
	cmp	ebx, r14d
	jle	.L8
	call	rand@PLT
	neg	eax
	cdq
	idiv	r13d
	mov	DWORD PTR 0[rbp+r14*4], edx
	inc	r14
	jmp	.L2
.L8:
	test	ebx, ebx
	mov	eax, 0
	mov	r13d, 200
	cmovs	rbx, rax
.L4:
	cmp	r12d, ebx
	jle	.L9
	call	rand@PLT
	cdq
	idiv	r13d
	sub	edx, 100
	mov	DWORD PTR 0[rbp+rbx*4], edx
	inc	rbx
	jmp	.L4
.L9:
	pop	rbx
	mov	eax, r12d
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
	.size	random_fill_array, .-random_fill_array
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
