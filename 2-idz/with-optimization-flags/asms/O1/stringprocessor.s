	.file	"stringprocessor.c"
	.intel_syntax noprefix
	.text
	.globl	my_strstr
	.type	my_strstr, @function
my_strstr:
	endbr64
	movzx	eax, BYTE PTR [rdi]
	test	al, al
	je	.L7
	movzx	edx, BYTE PTR [rsi]
	jmp	.L6
.L4:
	add	rdi, 1
	movzx	eax, BYTE PTR [rdi]
	test	al, al
	je	.L10
.L6:
	cmp	dl, al
	jne	.L4
	mov	eax, 0
.L3:
	movzx	ecx, BYTE PTR [rsi+rax]
	cmp	BYTE PTR [rdi+rax], cl
	jne	.L4
	add	rax, 1
	cmp	BYTE PTR [rsi+rax], 0
	jne	.L3
.L1:
	mov	rax, rdi
	ret
.L10:
	mov	edi, 0
	jmp	.L1
.L7:
	mov	edi, 0
	jmp	.L1
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
