	.file	"arrayprocessor.c"
	.intel_syntax noprefix
	.text
	.p2align 4
	.globl	process_array
	.type	process_array, @function
process_array:
	endbr64
	test	esi, esi
	jle	.L1
	lea	eax, -1[rsi]
	lea	rdx, 4[rdi+rax*4]
	jmp	.L3
	.p2align 4,,10
	.p2align 3
.L6:
	sub	eax, 5
	add	rdi, 4
	mov	DWORD PTR -4[rdi], eax
	cmp	rdi, rdx
	je	.L1
.L3:
	mov	eax, DWORD PTR [rdi]
	test	eax, eax
	jle	.L6
.L1:
	ret
	.size	process_array, .-process_array
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
