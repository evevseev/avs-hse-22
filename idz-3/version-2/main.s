	.intel_syntax noprefix
	.text
	.globl	f
	.type	f, @function
f:
	endbr64	
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -8[rbp], xmm0	# x
	movsd	xmm0, QWORD PTR -8[rbp]	# x
	mulsd	xmm0, xmm0
	mulsd	xmm0, QWORD PTR -8[rbp]	# x
	movsd	xmm2, QWORD PTR -8[rbp]	# x
	movsd	xmm1, QWORD PTR .LC0[rip]
	mulsd	xmm1, xmm2	
	mulsd	xmm1, QWORD PTR -8[rbp]	# x
	subsd	xmm0, xmm1	
	movapd	xmm1, xmm0	
	movsd	xmm2, QWORD PTR -8[rbp]	# x
	movsd	xmm0, QWORD PTR .LC1[rip]
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC2[rip]
	subsd	xmm0, xmm1
	pop	rbp
	ret	
	.size	f, .-f
	.globl	get_random_double
	.type	get_random_double, @function

	# QWORD PTR -8[rbp], xmm0	# min
	# QWORD PTR -16[rbp], xmm1	# max
	# xmm0 # retrun
get_random_double:
	endbr64	
	push	rbp	
	mov	rbp, rsp	
	sub	rsp, 16	
	movsd	QWORD PTR -8[rbp], xmm0		# min
	movsd	QWORD PTR -16[rbp], xmm1	# max
	call	rand@PLT
	cvtsi2sd	xmm0, eax
	movsd	xmm1, QWORD PTR .LC3[rip]	
	divsd	xmm0, xmm1	
	movapd	xmm1, xmm0	
	movsd	xmm0, QWORD PTR -16[rbp]	# max
	subsd	xmm0, QWORD PTR -8[rbp]	# min
	mulsd	xmm0, xmm1
	addsd	xmm0, QWORD PTR -8[rbp]	# min
	leave	
	ret	
	.size	get_random_double, .-get_random_double
	.section	.rodata
	.align 8
.LC6:
	.string	"Not enough arguments. Please specify epsilon."
.LC7:
	.string	"-file"
	.align 8
.LC8:
	.string	"Usage: %s <epsilon> -file <input_file_path> [output_file_path]\n"
.LC9:
	.string	"-random"
.LC10:
	.string	"Usage: %s -random <seed>\n"
.LC13:
	.string	"-test"
.LC14:
	.string	"Usage: %s -test <seed>\n"
	.align 8
.LC15:
	.string	"Unknown argument or in wrong position"
.LC17:
	.string	"Epsilon must be positive."
.LC18:
	.string	"Epsilon: %.15f\n"
.LC19:
	.string	"%.25f\n"
	.align 8
.LC20:
	.string	"Time elapsed: %u microseconds\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64	
	push	rbp	#
	mov	rbp, rsp	#,
	sub	rsp, 112	#,
	mov	DWORD PTR -100[rbp], edi	# argc
	mov	QWORD PTR -112[rbp], rsi	# argv
	lea	rax, f[rip]
	mov	QWORD PTR -40[rbp], rax	# func
	movsd	xmm0, QWORD PTR .LC4[rip]
	movsd	QWORD PTR -48[rbp], xmm0	# a
	movsd	xmm0, QWORD PTR .LC5[rip]	
	movsd	QWORD PTR -56[rbp], xmm0	# b
	cmp	DWORD PTR -100[rbp], 1	# argc
	jg	.L6
	lea	rdi, .LC6[rip]
	call	puts@PLT
	mov	eax, 1
	jmp	.L7
.L6:
	cmp	DWORD PTR -100[rbp], 2	# argc,
	jne	.L8	#,
	mov	DWORD PTR -4[rbp], 0	# input_mode,
	mov	rax, QWORD PTR -112[rbp]	# argv
	add	rax, 8
	mov	rax, QWORD PTR [rax]	
	mov	rdi, rax	
	call	atof@PLT	
	movq	rax, xmm0	
	mov	QWORD PTR -24[rbp], rax	# epsilon
	jmp	.L9	
.L8:
	mov	rax, QWORD PTR -112[rbp]	# argv
	add	rax, 16
	mov	rax, QWORD PTR [rax]	
	lea	rsi, .LC7[rip]
	mov	rdi, rax	
	call	strcmp@PLT	
	test	eax, eax	
	jne	.L10
	cmp	DWORD PTR -100[rbp], 3	# argc
	jg	.L11
	mov	rax, QWORD PTR -112[rbp]	# argv
	mov	rax, QWORD PTR [rax]
	mov	rsi, rax
	lea	rdi, .LC8[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 1	
	jmp	.L7	
.L11:
	mov	rax, QWORD PTR -112[rbp]	# argv
	mov	rax, QWORD PTR 24[rax]	
	mov	QWORD PTR -64[rbp], rax	# file_path
	mov	rax, QWORD PTR -64[rbp]	# file_path
	
	# QWORD PTR -24[rbp], rdi	# filename
	# xmm0 return # numbert
	mov	rdi, rax
	call	read_number_from_file@PLT	
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax	# epsilon
	mov	DWORD PTR -4[rbp], 1	# input_mode
	jmp	.L9	
.L10:
	mov	rax, QWORD PTR -112[rbp]	# argv
	add	rax, 8	
	mov	rax, QWORD PTR [rax]	
	lea	rsi, .LC9[rip]	
	mov	rdi, rax	
	call	strcmp@PLT	
	test	eax, eax
	jne	.L12	
	cmp	DWORD PTR -100[rbp], 2	# argc
	jg	.L13
	mov	rax, QWORD PTR -112[rbp]	# argv
	mov	rax, QWORD PTR [rax]	
	mov	rsi, rax	
	lea	rdi, .LC10[rip]
	mov	eax, 0
	call	printf@PLT	
	mov	eax, 1
	jmp	.L7	
.L13:
	mov	rax, QWORD PTR -112[rbp]	# argv
	add	rax, 16	
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT	
	mov	edi, eax
	call	srand@PLT	
	movsd	xmm0, QWORD PTR .LC11[rip]	
	mov	rax, QWORD PTR .LC12[rip]	

	# xmm0	# min
	# xmm1	# max
	# xmm0 # retrun
	movapd	xmm1, xmm0	
	movq	xmm0, rax	
	call	get_random_double	
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax	# epsilon
	mov	DWORD PTR -4[rbp], 2	# input_mode
	jmp	.L9	#
.L12:
	mov	rax, QWORD PTR -112[rbp]	# argv
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC13[rip]
	mov	rdi, rax	
	call	strcmp@PLT
	test	eax, eax
	jne	.L14
	cmp	DWORD PTR -100[rbp], 2	# argc
	jg	.L15
	mov	rax, QWORD PTR -112[rbp]	# argv
	mov	rax, QWORD PTR [rax]	
	mov	rsi, rax	
	lea	rdi, .LC14[rip]	
	mov	eax, 0	
	call	printf@PLT
	mov	eax, 1	
	jmp	.L7	
.L15:
	mov	rax, QWORD PTR -112[rbp]	# argv
	add	rax, 16	
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	edi, eax
	call	srand@PLT	
	movsd	xmm0, QWORD PTR .LC11[rip]	
	mov	rax, QWORD PTR .LC12[rip]	

	# xmm0	# min
	# xmm1	# max
	# xmm0 # retrun
	movapd	xmm1, xmm0	
	movq	xmm0, rax	
	call	get_random_double	
	movq	rax, xmm0	
	mov	QWORD PTR -24[rbp], rax	# epsilon
	mov	DWORD PTR -4[rbp], 3	# input_mode
	jmp	.L9	
.L14:
	lea	rdi, .LC15[rip]
	mov	eax, 0	
	call	printf@PLT	
	mov	eax, 1
	jmp	.L7	
.L9:
	pxor	xmm0, xmm0	
	comisd	xmm0, QWORD PTR -24[rbp]	# epsilon
	jbe	.L26
	lea	rdi, .LC17[rip]	
	call	puts@PLT	
	mov	eax, 1
	jmp	.L7	
.L26:
	mov	DWORD PTR -8[rbp], 0	# clocks_elapsed,
	cmp	DWORD PTR -4[rbp], 3	# input_mode,
	jne	.L18	
	mov	eax, 4000000
	jmp	.L19	
.L18:
	mov	eax, 1	
.L19:
	mov	DWORD PTR -68[rbp], eax	# passes
	mov	DWORD PTR -12[rbp], 0	# i,
	jmp	.L20
.L21:
	call	clock@PLT	
	mov	QWORD PTR -80[rbp], rax	# start_time,
	movsd	xmm1, QWORD PTR -24[rbp]	#  epsilon
	movsd	xmm0, QWORD PTR -56[rbp]	#  b
	mov	rdx, QWORD PTR -48[rbp]	#  a
	mov	rax, QWORD PTR -40[rbp]	#  func

	# rdi	# func
	# xmm0	# a
	# xmm1	# b
	# xmm2	# eps
	# xmm0 # return
	movapd	xmm2, xmm1
	movapd	xmm1, xmm0
	movq	xmm0, rdx
	mov	rdi, rax
	call	find_root@PLT
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax	# answer
	call	clock@PLT	#
	mov	QWORD PTR -88[rbp], rax	# end_time, 
	mov	rax, QWORD PTR -88[rbp]	#  end_time
	mov	edx, eax	
	mov	rax, QWORD PTR -80[rbp]	#  start_time
	sub	edx, eax	
	mov	eax, edx	
	add	DWORD PTR -8[rbp], eax	# clocks_elapsed
	add	DWORD PTR -12[rbp], 1	# i,
.L20:
	mov	eax, DWORD PTR -12[rbp]	# i
	cmp	eax, DWORD PTR -68[rbp]	# passes
	jl	.L21	
	cmp	DWORD PTR -4[rbp], 1	# input_mode,
	jne	.L22	
	cmp	DWORD PTR -100[rbp], 4	# argc,
	jle	.L22	
	mov	rax, QWORD PTR -112[rbp]	#  argv
	mov	rax, QWORD PTR 32[rax]	
	mov	QWORD PTR -64[rbp], rax	# file_path, 
	mov	rdx, QWORD PTR -32[rbp]	#  answer
	mov	rax, QWORD PTR -64[rbp]	#  file_path
	
	# rdi	# filename
	# xmm0	# number
	movq	xmm0, rdx	
	mov	rdi, rax 
	call	write_number_to_file@PLT	
	jmp	.L23	
.L22:
	cmp	DWORD PTR -4[rbp], 2	# input_mode,
	jne	.L24
	mov	rax, QWORD PTR -24[rbp]	#  epsilon
	movq	xmm0, rax
	lea	rdi, .LC18[rip]
	mov	eax, 1
	call	printf@PLT
.L24:
	cmp	DWORD PTR -4[rbp], 3	# input_mode,
	je	.L23	
	mov	rax, QWORD PTR -32[rbp]	#  answer
	movq	xmm0, rax	
	lea	rdi, .LC19[rip]	
	mov	eax, 1	
	call	printf@PLT
.L23:
	mov	eax, DWORD PTR -8[rbp]	#  clocks_elapsed
	imul	eax, eax, 1000000	#
	mov	eax, eax	#
	imul	rax, rax, 1125899907	
	shr	rax, 32	
	shr	eax, 18	
	mov	eax, eax	
	mov	rsi, rax	
	lea	rdi, .LC20[rip]	
	mov	eax, 0	
	call	printf@PLT	
	mov	eax, 0	
.L7:
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
	.long	4290772992
	.long	1105199103
	.align 8
.LC4:
	.long	0
	.long	1072693248
	.align 8
.LC5:
	.long	0
	.long	1074266112
	.align 8
.LC11:
	.long	3794832442
	.long	1044740494
	.align 8
.LC12:
	.long	3539053052
	.long	1062232653
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
