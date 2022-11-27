	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	f
	.type	f, @function
f:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, xmm0
	mulsd	xmm0, QWORD PTR -8[rbp]
	movsd	xmm2, QWORD PTR -8[rbp]
	movsd	xmm1, QWORD PTR .LC0[rip]
	mulsd	xmm1, xmm2
	mulsd	xmm1, QWORD PTR -8[rbp]
	subsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm2, QWORD PTR -8[rbp]
	movsd	xmm0, QWORD PTR .LC1[rip]
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC2[rip]
	subsd	xmm0, xmm1
	pop	rbp
	ret
	.size	f, .-f
	.section	.rodata
.LC5:
	.string	"%lf"
.LC6:
	.string	"%.25f\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	lea	rax, f[rip]
	mov	QWORD PTR -8[rbp], rax
	movsd	xmm0, QWORD PTR .LC3[rip]
	movsd	QWORD PTR -16[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC4[rip]
	movsd	QWORD PTR -24[rbp], xmm0
	lea	rax, -40[rbp]
	mov	rsi, rax
	lea	rdi, .LC5[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	movsd	xmm1, QWORD PTR -40[rbp]
	movsd	xmm0, QWORD PTR -24[rbp]
	mov	rdx, QWORD PTR -16[rbp]
	mov	rax, QWORD PTR -8[rbp]
	movapd	xmm2, xmm1
	movapd	xmm1, xmm0
	movq	xmm0, rdx
	mov	rdi, rax
	call	find_root@PLT
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax
	lea	rdi, .LC6[rip]
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1071644672
	.align 8
.LC1:
	.long	2576980378
	.long	1070176665
	.align 8
.LC2:
	.long	0
	.long	1074790400
	.align 8
.LC3:
	.long	0
	.long	1072693248
	.align 8
.LC4:
	.long	0
	.long	1074266112
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
