	.file	"arrayprocessor.c"
	.intel_syntax noprefix
	.text
	.globl	process_array
	.type	process_array, @function
process_array:
	endbr64
	xor	eax, eax
.L2:
	cmp	esi, eax
	jle	.L1
	mov	edx, DWORD PTR [rdi+rax*4]
	test	edx, edx
	jg	.L1
	sub	edx, 5
	mov	DWORD PTR [rdi+rax*4], edx
	inc	rax
	jmp	.L2
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
