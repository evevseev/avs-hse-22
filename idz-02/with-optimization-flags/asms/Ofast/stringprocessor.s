	.file	"stringprocessor.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	my_strstr
	.type	my_strstr, @function
my_strstr:
	endbr64
	movzx	eax, BYTE PTR [rdi]
	mov	r8, rdi
	test	al, al
	je	.L7
	movzx	edx, BYTE PTR [rsi]
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L4:
	movzx	eax, BYTE PTR 1[r8]
	add	r8, 1
	test	al, al
	je	.L7
.L6:
	cmp	dl, al
	jne	.L4
	xor	eax, eax
	.p2align 4,,10
	.p2align 3
.L3:
	movzx	ecx, BYTE PTR [rsi+rax]
	cmp	BYTE PTR [r8+rax], cl
	jne	.L4
	add	rax, 1
	cmp	BYTE PTR [rsi+rax], 0
	jne	.L3
	mov	rax, r8
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	xor	r8d, r8d
	mov	rax, r8
	ret
	.size	my_strstr, .-my_strstr
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
