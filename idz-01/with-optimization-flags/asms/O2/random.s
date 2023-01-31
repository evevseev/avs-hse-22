	.file	"random.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	random_fill_array
	.type	random_fill_array, @function
random_fill_array:
	endbr64
	push	r13
	push	r12
	mov	r12d, esi
	push	rbp
	mov	rbp, rdi
	mov	edi, edx
	push	rbx
	sub	rsp, 8
	call	srand@PLT
	lea	eax, [r12+r12*2]
	test	eax, eax
	lea	ebx, 3[rax]
	cmovns	ebx, eax
	sar	ebx, 2
	cmp	eax, 3
	jle	.L6
	xor	r13d, r13d
	.p2align 4,,10
	.p2align 3
.L3:
	call	rand@PLT
	neg	eax
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1374389535
	sar	ecx, 31
	sar	rdx, 37
	sub	edx, ecx
	imul	edx, edx, 100
	sub	eax, edx
	mov	DWORD PTR 0[rbp+r13*4], eax
	add	r13, 1
	cmp	ebx, r13d
	jg	.L3
	test	ebx, ebx
	mov	eax, 1
	cmovle	ebx, eax
.L2:
	cmp	r12d, ebx
	jle	.L4
	lea	eax, -1[r12]
	movsx	rdx, ebx
	sub	eax, ebx
	lea	r13, 0[rbp+rdx*4]
	add	rax, rdx
	lea	rbx, 4[rbp+rax*4]
	.p2align 4,,10
	.p2align 3
.L5:
	call	rand@PLT
	add	r13, 4
	movsx	rdx, eax
	mov	ecx, eax
	imul	rdx, rdx, 1374389535
	sar	ecx, 31
	sar	rdx, 38
	sub	edx, ecx
	imul	edx, edx, 200
	sub	eax, edx
	sub	eax, 100
	mov	DWORD PTR -4[r13], eax
	cmp	r13, rbx
	jne	.L5
.L4:
	add	rsp, 8
	mov	eax, r12d
	pop	rbx
	pop	rbp
	pop	r12
	pop	r13
	ret
	.p2align 4,,10
	.p2align 3
.L6:
	xor	ebx, ebx
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
