	.file	"stringprocessor.c"
	.intel_syntax noprefix
	.text
	.globl	my_strstr
	.type	my_strstr, @function
my_strstr:
	endbr64
	xor	eax, eax
.L2:
	mov	dl, BYTE PTR [rdi+rax]
	lea	r8, [rdi+rax]
	test	dl, dl
	je	.L12
	cmp	BYTE PTR [rsi], dl
	jne	.L3
	mov	r9, rsi
	mov	rdx, rax
	sub	r9, rax
.L5:
	mov	cl, BYTE PTR 1[r9+rdx]
	test	cl, cl
	je	.L1
	inc	rdx
	cmp	cl, BYTE PTR [rdi+rdx]
	je	.L5
.L3:
	inc	rax
	jmp	.L2
.L12:
	xor	r8d, r8d
.L1:
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
