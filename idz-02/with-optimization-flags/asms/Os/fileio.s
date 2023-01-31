	.file	"fileio.c"
	.intel_syntax noprefix
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"r"
.LC1:
	.string	"File is too big"
.LC2:
	.string	"%c"
	.text
	.globl	read_string_from_file
	.type	read_string_from_file, @function
read_string_from_file:
	endbr64
	push	r14
	lea	r14, .LC2[rip]
	push	r13
	mov	r13d, esi
	lea	rsi, .LC0[rip]
	push	r12
	push	rbp
	push	rbx
	xor	ebx, ebx
	call	fopen@PLT
	mov	edx, 2
	xor	esi, esi
	mov	rbp, rax
	mov	rdi, rax
	call	fseek@PLT
	mov	rdi, rbp
	call	ftell@PLT
	xor	edx, edx
	xor	esi, esi
	mov	rdi, rbp
	mov	r12, rax
	call	fseek@PLT
	mov	rdi, r12
	call	malloc@PLT
	mov	r12, rax
.L3:
	cmp	r13d, ebx
	jg	.L2
	lea	rdi, .LC1[rip]
	call	puts@PLT
	mov	rdi, rbp
	call	fclose@PLT
	mov	edi, 5
	call	exit@PLT
.L2:
	lea	rdx, [r12+rbx]
	xor	eax, eax
	mov	rsi, r14
	mov	rdi, rbp
	call	__isoc99_fscanf@PLT
	inc	rbx
	inc	eax
	jne	.L3
	mov	rdi, rbp
	call	fclose@PLT
	pop	rbx
	mov	rax, r12
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
	.size	read_string_from_file, .-read_string_from_file
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
