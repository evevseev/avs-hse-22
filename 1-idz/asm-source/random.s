	.file	"random.c"
	.intel_syntax noprefix
	.text
	.globl	random_fill_array
	.type	random_fill_array, @function
random_fill_array:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	mov	DWORD PTR -28[rbp], esi
	mov	DWORD PTR -32[rbp], edx
	mov	eax, DWORD PTR -32[rbp]
	mov	edi, eax
	call	srand@PLT
	mov	DWORD PTR -4[rbp], 0
	jmp	.L2
.L3:
	call	rand@PLT
	neg	eax
	mov	edx, eax
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rcx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rcx, rax
	movsx	rax, edx
	imul	rax, rax, 1374389535
	shr	rax, 32
	mov	esi, eax
	sar	esi, 5
	mov	eax, edx
	sar	eax, 31
	sub	esi, eax
	mov	eax, esi
	imul	eax, eax, 100
	sub	edx, eax
	mov	eax, edx
	mov	DWORD PTR [rcx], eax
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	edx, DWORD PTR -28[rbp]
	mov	eax, edx
	add	eax, eax
	add	eax, edx
	lea	edx, 3[rax]
	test	eax, eax
	cmovs	eax, edx
	sar	eax, 2
	cmp	DWORD PTR -4[rbp], eax
	jl	.L3
	jmp	.L4
.L5:
	call	rand@PLT
	movsx	rdx, eax
	imul	rdx, rdx, 1374389535
	shr	rdx, 32
	mov	ecx, edx
	sar	ecx, 6
	cdq
	sub	ecx, edx
	mov	edx, ecx
	imul	edx, edx, 200
	sub	eax, edx
	mov	edx, eax
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rcx, 0[0+rax*4]
	mov	rax, QWORD PTR -24[rbp]
	add	rax, rcx
	sub	edx, 100
	mov	DWORD PTR [rax], edx
	add	DWORD PTR -4[rbp], 1
.L4:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -28[rbp]
	jl	.L5
	mov	eax, DWORD PTR -28[rbp]
	leave
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
