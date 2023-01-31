	.intel_syntax noprefix
	.text
	.globl	find_root
	.type	find_root, @function
find_root:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 64
	mov	QWORD PTR -24[rbp], rdi
	movsd	QWORD PTR -32[rbp], xmm0
	movsd	QWORD PTR -40[rbp], xmm1
	movsd	QWORD PTR -48[rbp], xmm2
	movsd	xmm0, QWORD PTR -32[rbp]
	addsd	xmm0, QWORD PTR -40[rbp]
	movsd	xmm1, QWORD PTR .LC0[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
	jmp	.L2
.L6:
	mov	rax, QWORD PTR -32[rbp]
	mov	rdx, QWORD PTR -24[rbp]
	movq	xmm0, rax
	call	rdx
	movsd	QWORD PTR -56[rbp], xmm0
	mov	rax, QWORD PTR -8[rbp]
	mov	rdx, QWORD PTR -24[rbp]
	movq	xmm0, rax
	call	rdx
	movsd	xmm1, QWORD PTR -56[rbp]
	mulsd	xmm1, xmm0
	pxor	xmm0, xmm0
	comisd	xmm0, xmm1
	jbe	.L9
	movsd	xmm0, QWORD PTR -8[rbp]
	movsd	QWORD PTR -40[rbp], xmm0
	jmp	.L5
.L9:
	movsd	xmm0, QWORD PTR -8[rbp]
	movsd	QWORD PTR -32[rbp], xmm0
.L5:
	movsd	xmm0, QWORD PTR -32[rbp]
	addsd	xmm0, QWORD PTR -40[rbp]
	movsd	xmm1, QWORD PTR .LC0[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -8[rbp], xmm0
.L2:
	mov	rax, QWORD PTR -8[rbp]
	mov	rdx, QWORD PTR -24[rbp]
	movq	xmm0, rax
	call	rdx
	movq	xmm1, QWORD PTR .LC2[rip]
	andpd	xmm0, xmm1
	comisd	xmm0, QWORD PTR -48[rbp]
	ja	.L6
	movsd	xmm0, QWORD PTR -8[rbp]
	leave
	ret
	.size	find_root, .-find_root
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1073741824
	.align 16
.LC2:
	.long	4294967295
	.long	2147483647
	.long	0
	.long	0
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
