	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"w"
.LC1:
	.string	"Error opening file!"
.LC2:
	.string	"%.25f\n"
	.text
	.globl	write_number_to_file
	.type	write_number_to_file, @function

	# QWORD PTR -24[rbp], rdi	# filename
	# QWORD PTR -32[rbp], xmm0	# number
write_number_to_file:
	endbr64	
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi	# filename
	movsd	QWORD PTR -32[rbp], xmm0	# number


	mov	rax, QWORD PTR -24[rbp]	# filename
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax	# file

	cmp	QWORD PTR -8[rbp], 0	# file
	jne	.L2	#,

	lea	rdi, .LC1[rip]
	call	puts@PLT

	mov	edi, 1	#,
	call	exit@PLT
.L2:
	mov	rdx, QWORD PTR -32[rbp]	# number
	mov	rax, QWORD PTR -8[rbp]	# file
	movq	xmm0, rdx
	lea	rsi, .LC2[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT	

	mov	rax, QWORD PTR -8[rbp]	# file
	mov	rdi, rax
	call	fclose@PLT

	movsd	xmm0, QWORD PTR -32[rbp]	# number
	leave	
	ret	
	.size	write_number_to_file, .-write_number_to_file
	.section	.rodata
.LC3:
	.string	"r"
.LC4:
	.string	"%lf"
	.text
	.globl	read_number_from_file
	.type	read_number_from_file, @function

	# QWORD PTR -24[rbp], rdi	# filename
	# xmm0 return # numbert
read_number_from_file:
	endbr64	
	push	rbp	#
	mov	rbp, rsp	#,
	sub	rsp, 32	#,
	mov	QWORD PTR -24[rbp], rdi	# filename
	mov	rax, QWORD PTR -24[rbp]	# filename
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	call	fopen@PLT	
	mov	QWORD PTR -8[rbp], rax	# file
	cmp	QWORD PTR -8[rbp], 0	# file
	jne	.L5	#,
	lea	rdi, .LC1[rip]	#
	call	puts@PLT	#
	mov	edi, 1	#
	call	exit@PLT	#
.L5:
	lea	rdx, -16[rbp]	# 
	mov	rax, QWORD PTR -8[rbp]	
	lea	rsi, .LC4[rip]	#
	mov	rdi, rax	#
	mov	eax, 0	#
	call	__isoc99_fscanf@PLT	#
	mov	rax, QWORD PTR -8[rbp]	# , file
	mov	rdi, rax	#, tmp88
	call	fclose@PLT	#
	movsd	xmm0, QWORD PTR -16[rbp]	# number
	leave	
	ret	
	.size	read_number_from_file, .-read_number_from_file
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
