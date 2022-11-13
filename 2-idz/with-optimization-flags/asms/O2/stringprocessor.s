	.file	"stringprocessor.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	my_strstr
	.type	my_strstr, @function
my_strstr:
	endbr64
	movzx	eax, BYTE PTR [rdi]
	test	al, al
	je	.L7
	movzx	r9d, BYTE PTR [rsi]
	xor	ecx, ecx
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L4:
	add	rcx, 1
	movzx	eax, BYTE PTR [rdi+rcx]
	test	al, al
	je	.L7
.L6:
	lea	r10, [rdi+rcx]
	cmp	r9b, al
	jne	.L4
	mov	r8, rsi
	mov	rax, rcx
	mov	edx, r9d
	sub	r8, rcx
	.p2align 4,,10
	.p2align 3
.L3:
	cmp	BYTE PTR [rdi+rax], dl
	jne	.L4
	add	rax, 1
	movzx	edx, BYTE PTR [r8+rax]
	test	dl, dl
	jne	.L3
	mov	rax, r10
	ret
	.p2align 4,,10
	.p2align 3
.L7:
	xor	r10d, r10d
	mov	rax, r10
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
