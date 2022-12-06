	.file	"random.c"
	.intel_syntax noprefix
	.text
	.globl	random_fill_array
	.type	random_fill_array, @function
random_fill_array:
	endbr64
	push	r14
	push	r13
	push	r12
	push	rbp
	push	rbx
	mov	rbp, rdi
	mov	r12d, esi
	mov	edi, edx
	call	srand@PLT
	lea	eax, [r12+r12*2]
	lea	r13d, 3[rax]
	test	eax, eax
	cmovns	r13d, eax
	sar	r13d, 2
	cmp	eax, 3
	jle	.L6
	mov	r14d, r13d
	mov	ebx, 0
.L3:
	call	rand@PLT
	neg	eax
	movsx	rdx, eax
	imul	rdx, rdx, 1374389535
	sar	rdx, 37
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	edx, edx, 100
	sub	eax, edx
	mov	DWORD PTR 0[rbp+rbx*4], eax
	add	rbx, 1
	cmp	r14d, ebx
	jg	.L3
	test	r13d, r13d
	mov	eax, 1
	cmovle	r13d, eax
.L2:
	cmp	r12d, r13d
	jle	.L4
	movsx	rdx, r13d
	lea	rbx, 0[rbp+rdx*4]
	lea	eax, -1[r12]
	sub	eax, r13d
	add	rax, rdx
	lea	rbp, 4[rbp+rax*4]
.L5:
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 1374389535
	sar	rdx, 38
	mov	ecx, eax
	sar	ecx, 31
	sub	edx, ecx
	imul	edx, edx, 200
	sub	eax, edx
	sub	eax, 100
	mov	DWORD PTR [rbx], eax
	add	rbx, 4
	cmp	rbx, rbp
	jne	.L5
.L4:
	mov	eax, r12d
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
.L6:
	mov	r13d, 0
	jmp	.L2
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
