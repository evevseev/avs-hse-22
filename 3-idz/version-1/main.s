	.file	"main.c"
	.intel_syntax noprefix
# GNU C17 (Ubuntu 9.4.0-1ubuntu1~20.04.1) version 9.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 9.4.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version isl-0.22.1-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed:  -imultiarch x86_64-linux-gnu ../c-source/main.c
# -masm=intel -mtune=generic -march=x86-64 -fno-asynchronous-unwind-tables
# -fno-jump-tables -fno-stack-protector -fno-exceptions -fverbose-asm
# -Wformat -Wformat-security -fstack-clash-protection -fcf-protection
# options enabled:  -fPIC -fPIE -faggressive-loop-optimizations
# -fassume-phsa -fauto-inc-dec -fcommon -fdelete-null-pointer-checks
# -fdwarf2-cfi-asm -fearly-inlining -feliminate-unused-debug-types
# -ffp-int-builtin-inexact -ffunction-cse -fgcse-lm -fgnu-runtime
# -fgnu-unique -fident -finline-atomics -fipa-stack-alignment
# -fira-hoist-pressure -fira-share-save-slots -fira-share-spill-slots
# -fivopts -fkeep-static-consts -fleading-underscore -flifetime-dse
# -flto-odr-type-merging -fmath-errno -fmerge-debug-strings -fpeephole
# -fplt -fprefetch-loop-arrays -freg-struct-return
# -fsched-critical-path-heuristic -fsched-dep-count-heuristic
# -fsched-group-heuristic -fsched-interblock -fsched-last-insn-heuristic
# -fsched-rank-heuristic -fsched-spec -fsched-spec-insn-heuristic
# -fsched-stalled-insns-dep -fschedule-fusion -fsemantic-interposition
# -fshow-column -fshrink-wrap-separate -fsigned-zeros
# -fsplit-ivs-in-unroller -fssa-backprop -fstack-clash-protection
# -fstdarg-opt -fstrict-volatile-bitfields -fsync-libcalls -ftrapping-math
# -ftree-cselim -ftree-forwprop -ftree-loop-if-convert -ftree-loop-im
# -ftree-loop-ivcanon -ftree-loop-optimize -ftree-parallelize-loops=
# -ftree-phiprop -ftree-reassoc -ftree-scev-cprop -funit-at-a-time
# -fverbose-asm -fzero-initialized-in-bss -m128bit-long-double -m64 -m80387
# -malign-stringops -mavx256-split-unaligned-load
# -mavx256-split-unaligned-store -mfancy-math-387 -mfp-ret-in-387 -mfxsr
# -mglibc -mieee-fp -mlong-double-80 -mmmx -mno-sse4 -mpush-args -mred-zone
# -msse -msse2 -mstv -mtls-direct-seg-refs -mvzeroupper

	.text
	.globl	f
	.type	f, @function
f:
	endbr64	
	push	rbp	#
	mov	rbp, rsp	#,
	movsd	QWORD PTR -8[rbp], xmm0	# x, x
# ../c-source/main.c:14:   return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	movsd	xmm0, QWORD PTR -8[rbp]	# tmp91, x
	mulsd	xmm0, xmm0	# _1, tmp91
# ../c-source/main.c:14:   return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	mulsd	xmm0, QWORD PTR -8[rbp]	# _2, x
# ../c-source/main.c:14:   return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	movsd	xmm2, QWORD PTR -8[rbp]	# tmp92, x
	movsd	xmm1, QWORD PTR .LC0[rip]	# tmp93,
	mulsd	xmm1, xmm2	# _3, tmp92
# ../c-source/main.c:14:   return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	mulsd	xmm1, QWORD PTR -8[rbp]	# _4, x
# ../c-source/main.c:14:   return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	subsd	xmm0, xmm1	# _2, _4
	movapd	xmm1, xmm0	# _5, _2
# ../c-source/main.c:14:   return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	movsd	xmm2, QWORD PTR -8[rbp]	# tmp94, x
	movsd	xmm0, QWORD PTR .LC1[rip]	# tmp95,
	mulsd	xmm0, xmm2	# _6, tmp94
# ../c-source/main.c:14:   return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	addsd	xmm0, xmm1	# _7, _5
# ../c-source/main.c:14:   return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	movsd	xmm1, QWORD PTR .LC2[rip]	# tmp96,
	subsd	xmm0, xmm1	# _9, tmp96
# ../c-source/main.c:15: }
	pop	rbp	#
	ret	
	.size	f, .-f
	.globl	get_random_double
	.type	get_random_double, @function
get_random_double:
	endbr64	
	push	rbp	#
	mov	rbp, rsp	#,
	sub	rsp, 16	#,
	movsd	QWORD PTR -8[rbp], xmm0	# min, min
	movsd	QWORD PTR -16[rbp], xmm1	# max, max
# ../c-source/main.c:18:   return min + (double) rand() / RAND_MAX * (max - min);
	call	rand@PLT	#
# ../c-source/main.c:18:   return min + (double) rand() / RAND_MAX * (max - min);
	cvtsi2sd	xmm0, eax	# _2, _1
# ../c-source/main.c:18:   return min + (double) rand() / RAND_MAX * (max - min);
	movsd	xmm1, QWORD PTR .LC3[rip]	# tmp89,
	divsd	xmm0, xmm1	# _2, tmp89
	movapd	xmm1, xmm0	# _3, _2
# ../c-source/main.c:18:   return min + (double) rand() / RAND_MAX * (max - min);
	movsd	xmm0, QWORD PTR -16[rbp]	# tmp90, max
	subsd	xmm0, QWORD PTR -8[rbp]	# _4, min
# ../c-source/main.c:18:   return min + (double) rand() / RAND_MAX * (max - min);
	mulsd	xmm0, xmm1	# _5, _3
# ../c-source/main.c:18:   return min + (double) rand() / RAND_MAX * (max - min);
	addsd	xmm0, QWORD PTR -8[rbp]	# _10, min
# ../c-source/main.c:19: }
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
	mov	DWORD PTR -100[rbp], edi	# argc, argc
	mov	QWORD PTR -112[rbp], rsi	# argv, argv
# ../c-source/main.c:31:   rf_function func = &f;
	lea	rax, f[rip]	# tmp113,
	mov	QWORD PTR -40[rbp], rax	# func, tmp113
# ../c-source/main.c:32:   double a = 1;
	movsd	xmm0, QWORD PTR .LC4[rip]	# tmp114,
	movsd	QWORD PTR -48[rbp], xmm0	# a, tmp114
# ../c-source/main.c:33:   double b = 3;
	movsd	xmm0, QWORD PTR .LC5[rip]	# tmp115,
	movsd	QWORD PTR -56[rbp], xmm0	# b, tmp115
# ../c-source/main.c:35:   if (argc < 2) {
	cmp	DWORD PTR -100[rbp], 1	# argc,
	jg	.L6	#,
# ../c-source/main.c:36:     printf("Not enough arguments. Please specify epsilon.\n");
	lea	rdi, .LC6[rip]	#,
	call	puts@PLT	#
# ../c-source/main.c:37:     return 1;
	mov	eax, 1	# _34,
	jmp	.L7	#
.L6:
# ../c-source/main.c:38:   } else if (argc == 2) {
	cmp	DWORD PTR -100[rbp], 2	# argc,
	jne	.L8	#,
# ../c-source/main.c:39:     input_mode = 0;
	mov	DWORD PTR -4[rbp], 0	# input_mode,
# ../c-source/main.c:40:     epsilon = atof(argv[1]);
	mov	rax, QWORD PTR -112[rbp]	# tmp116, argv
	add	rax, 8	# _1,
# ../c-source/main.c:40:     epsilon = atof(argv[1]);
	mov	rax, QWORD PTR [rax]	# _2, *_1
	mov	rdi, rax	#, _2
	call	atof@PLT	#
	movq	rax, xmm0	# tmp117,
	mov	QWORD PTR -24[rbp], rax	# epsilon, tmp117
	jmp	.L9	#
.L8:
# ../c-source/main.c:42:     if (strcmp(argv[2], "-file") == 0) {
	mov	rax, QWORD PTR -112[rbp]	# tmp118, argv
	add	rax, 16	# _3,
# ../c-source/main.c:42:     if (strcmp(argv[2], "-file") == 0) {
	mov	rax, QWORD PTR [rax]	# _4, *_3
	lea	rsi, .LC7[rip]	#,
	mov	rdi, rax	#, _4
	call	strcmp@PLT	#
# ../c-source/main.c:42:     if (strcmp(argv[2], "-file") == 0) {
	test	eax, eax	# _5
	jne	.L10	#,
# ../c-source/main.c:43:       if (argc < 4) {
	cmp	DWORD PTR -100[rbp], 3	# argc,
	jg	.L11	#,
# ../c-source/main.c:44:         printf("Usage: %s <epsilon> -file <input_file_path> [output_file_path]\n", argv[0]);
	mov	rax, QWORD PTR -112[rbp]	# tmp119, argv
	mov	rax, QWORD PTR [rax]	# _6, *argv_45(D)
	mov	rsi, rax	#, _6
	lea	rdi, .LC8[rip]	#,
	mov	eax, 0	#,
	call	printf@PLT	#
# ../c-source/main.c:45:         return 1;
	mov	eax, 1	# _34,
	jmp	.L7	#
.L11:
# ../c-source/main.c:47:       file_path = argv[3];
	mov	rax, QWORD PTR -112[rbp]	# tmp120, argv
	mov	rax, QWORD PTR 24[rax]	# tmp121, MEM[(char * *)argv_45(D) + 24B]
	mov	QWORD PTR -64[rbp], rax	# file_path, tmp121
# ../c-source/main.c:48:       epsilon = read_number_from_file(file_path);
	mov	rax, QWORD PTR -64[rbp]	# tmp122, file_path
	mov	rdi, rax	#, tmp122
	call	read_number_from_file@PLT	#
	movq	rax, xmm0	# tmp123,
	mov	QWORD PTR -24[rbp], rax	# epsilon, tmp123
# ../c-source/main.c:49:       input_mode = 1;
	mov	DWORD PTR -4[rbp], 1	# input_mode,
	jmp	.L9	#
.L10:
# ../c-source/main.c:50:     } else if (strcmp(argv[1], "-random") == 0) {
	mov	rax, QWORD PTR -112[rbp]	# tmp124, argv
	add	rax, 8	# _7,
# ../c-source/main.c:50:     } else if (strcmp(argv[1], "-random") == 0) {
	mov	rax, QWORD PTR [rax]	# _8, *_7
	lea	rsi, .LC9[rip]	#,
	mov	rdi, rax	#, _8
	call	strcmp@PLT	#
# ../c-source/main.c:50:     } else if (strcmp(argv[1], "-random") == 0) {
	test	eax, eax	# _9
	jne	.L12	#,
# ../c-source/main.c:51:       if (argc < 3) {
	cmp	DWORD PTR -100[rbp], 2	# argc,
	jg	.L13	#,
# ../c-source/main.c:52:         printf("Usage: %s -random <seed>\n", argv[0]);
	mov	rax, QWORD PTR -112[rbp]	# tmp125, argv
	mov	rax, QWORD PTR [rax]	# _10, *argv_45(D)
	mov	rsi, rax	#, _10
	lea	rdi, .LC10[rip]	#,
	mov	eax, 0	#,
	call	printf@PLT	#
# ../c-source/main.c:53:         return 1;
	mov	eax, 1	# _34,
	jmp	.L7	#
.L13:
# ../c-source/main.c:55:       srand(atoi(argv[2]));
	mov	rax, QWORD PTR -112[rbp]	# tmp126, argv
	add	rax, 16	# _11,
# ../c-source/main.c:55:       srand(atoi(argv[2]));
	mov	rax, QWORD PTR [rax]	# _12, *_11
	mov	rdi, rax	#, _12
	call	atoi@PLT	#
# ../c-source/main.c:55:       srand(atoi(argv[2]));
	mov	edi, eax	#, _14
	call	srand@PLT	#
# ../c-source/main.c:56:       epsilon = get_random_double(0.001, 0.00000001);
	movsd	xmm0, QWORD PTR .LC11[rip]	# tmp127,
	mov	rax, QWORD PTR .LC12[rip]	# tmp128,
	movapd	xmm1, xmm0	#, tmp127
	movq	xmm0, rax	#, tmp128
	call	get_random_double	#
	movq	rax, xmm0	# tmp129,
	mov	QWORD PTR -24[rbp], rax	# epsilon, tmp129
# ../c-source/main.c:57:       input_mode = 2;
	mov	DWORD PTR -4[rbp], 2	# input_mode,
	jmp	.L9	#
.L12:
# ../c-source/main.c:58:     } else if (strcmp(argv[1], "-test") == 0) {
	mov	rax, QWORD PTR -112[rbp]	# tmp130, argv
	add	rax, 8	# _15,
# ../c-source/main.c:58:     } else if (strcmp(argv[1], "-test") == 0) {
	mov	rax, QWORD PTR [rax]	# _16, *_15
	lea	rsi, .LC13[rip]	#,
	mov	rdi, rax	#, _16
	call	strcmp@PLT	#
# ../c-source/main.c:58:     } else if (strcmp(argv[1], "-test") == 0) {
	test	eax, eax	# _17
	jne	.L14	#,
# ../c-source/main.c:59:       if (argc < 3) {
	cmp	DWORD PTR -100[rbp], 2	# argc,
	jg	.L15	#,
# ../c-source/main.c:60:         printf("Usage: %s -test <seed>\n", argv[0]);
	mov	rax, QWORD PTR -112[rbp]	# tmp131, argv
	mov	rax, QWORD PTR [rax]	# _18, *argv_45(D)
	mov	rsi, rax	#, _18
	lea	rdi, .LC14[rip]	#,
	mov	eax, 0	#,
	call	printf@PLT	#
# ../c-source/main.c:61:         return 1;
	mov	eax, 1	# _34,
	jmp	.L7	#
.L15:
# ../c-source/main.c:63:       srand(atoi(argv[2]));
	mov	rax, QWORD PTR -112[rbp]	# tmp132, argv
	add	rax, 16	# _19,
# ../c-source/main.c:63:       srand(atoi(argv[2]));
	mov	rax, QWORD PTR [rax]	# _20, *_19
	mov	rdi, rax	#, _20
	call	atoi@PLT	#
# ../c-source/main.c:63:       srand(atoi(argv[2]));
	mov	edi, eax	#, _22
	call	srand@PLT	#
# ../c-source/main.c:64:       epsilon = get_random_double(0.001, 0.00000001);
	movsd	xmm0, QWORD PTR .LC11[rip]	# tmp133,
	mov	rax, QWORD PTR .LC12[rip]	# tmp134,
	movapd	xmm1, xmm0	#, tmp133
	movq	xmm0, rax	#, tmp134
	call	get_random_double	#
	movq	rax, xmm0	# tmp135,
	mov	QWORD PTR -24[rbp], rax	# epsilon, tmp135
# ../c-source/main.c:65:       input_mode = 3;
	mov	DWORD PTR -4[rbp], 3	# input_mode,
	jmp	.L9	#
.L14:
# ../c-source/main.c:67:       printf("Unknown argument or in wrong position");
	lea	rdi, .LC15[rip]	#,
	mov	eax, 0	#,
	call	printf@PLT	#
# ../c-source/main.c:68:       return 1;
	mov	eax, 1	# _34,
	jmp	.L7	#
.L9:
# ../c-source/main.c:72:   if (epsilon < 0) {
	pxor	xmm0, xmm0	# tmp136
	comisd	xmm0, QWORD PTR -24[rbp]	# tmp136, epsilon
	jbe	.L26	#,
# ../c-source/main.c:73:     printf("Epsilon must be positive.\n");
	lea	rdi, .LC17[rip]	#,
	call	puts@PLT	#
# ../c-source/main.c:74:     return 1;
	mov	eax, 1	# _34,
	jmp	.L7	#
.L26:
# ../c-source/main.c:77:   clocks_elapsed = 0;
	mov	DWORD PTR -8[rbp], 0	# clocks_elapsed,
# ../c-source/main.c:78:   passes = input_mode == 3 ? 4000000 : 1;
	cmp	DWORD PTR -4[rbp], 3	# input_mode,
	jne	.L18	#,
# ../c-source/main.c:78:   passes = input_mode == 3 ? 4000000 : 1;
	mov	eax, 4000000	# iftmp.0_35,
	jmp	.L19	#
.L18:
# ../c-source/main.c:78:   passes = input_mode == 3 ? 4000000 : 1;
	mov	eax, 1	# iftmp.0_35,
.L19:
# ../c-source/main.c:78:   passes = input_mode == 3 ? 4000000 : 1;
	mov	DWORD PTR -68[rbp], eax	# passes, iftmp.0_35
# ../c-source/main.c:80:   for (i = 0; i < passes; i++) {
	mov	DWORD PTR -12[rbp], 0	# i,
# ../c-source/main.c:80:   for (i = 0; i < passes; i++) {
	jmp	.L20	#
.L21:
# ../c-source/main.c:81:     start_time = clock();
	call	clock@PLT	#
	mov	QWORD PTR -80[rbp], rax	# start_time, tmp137
# ../c-source/main.c:83:     answer = find_root(func, a, b, epsilon);
	movsd	xmm1, QWORD PTR -24[rbp]	# tmp138, epsilon
	movsd	xmm0, QWORD PTR -56[rbp]	# tmp139, b
	mov	rdx, QWORD PTR -48[rbp]	# tmp140, a
	mov	rax, QWORD PTR -40[rbp]	# tmp141, func
	movapd	xmm2, xmm1	#, tmp138
	movapd	xmm1, xmm0	#, tmp139
	movq	xmm0, rdx	#, tmp140
	mov	rdi, rax	#, tmp141
	call	find_root@PLT	#
	movq	rax, xmm0	# tmp142,
	mov	QWORD PTR -32[rbp], rax	# answer, tmp142
# ../c-source/main.c:85:     end_time = clock();
	call	clock@PLT	#
	mov	QWORD PTR -88[rbp], rax	# end_time, tmp143
# ../c-source/main.c:86:     clocks_elapsed += (end_time - start_time);
	mov	rax, QWORD PTR -88[rbp]	# tmp144, end_time
	mov	edx, eax	# _23, tmp144
	mov	rax, QWORD PTR -80[rbp]	# tmp145, start_time
	sub	edx, eax	# _23, _24
	mov	eax, edx	# _25, _23
# ../c-source/main.c:86:     clocks_elapsed += (end_time - start_time);
	add	DWORD PTR -8[rbp], eax	# clocks_elapsed, _25
# ../c-source/main.c:80:   for (i = 0; i < passes; i++) {
	add	DWORD PTR -12[rbp], 1	# i,
.L20:
# ../c-source/main.c:80:   for (i = 0; i < passes; i++) {
	mov	eax, DWORD PTR -12[rbp]	# tmp146, i
	cmp	eax, DWORD PTR -68[rbp]	# tmp146, passes
	jl	.L21	#,
# ../c-source/main.c:90:   if (input_mode == 1 && argc >= 5) {
	cmp	DWORD PTR -4[rbp], 1	# input_mode,
	jne	.L22	#,
# ../c-source/main.c:90:   if (input_mode == 1 && argc >= 5) {
	cmp	DWORD PTR -100[rbp], 4	# argc,
	jle	.L22	#,
# ../c-source/main.c:91:     file_path = argv[4];
	mov	rax, QWORD PTR -112[rbp]	# tmp147, argv
	mov	rax, QWORD PTR 32[rax]	# tmp148, MEM[(char * *)argv_45(D) + 32B]
	mov	QWORD PTR -64[rbp], rax	# file_path, tmp148
# ../c-source/main.c:92:     write_number_to_file(file_path, answer);
	mov	rdx, QWORD PTR -32[rbp]	# tmp149, answer
	mov	rax, QWORD PTR -64[rbp]	# tmp150, file_path
	movq	xmm0, rdx	#, tmp149
	mov	rdi, rax	#, tmp150
	call	write_number_to_file@PLT	#
	jmp	.L23	#
.L22:
# ../c-source/main.c:94:     if (input_mode == 2) {
	cmp	DWORD PTR -4[rbp], 2	# input_mode,
	jne	.L24	#,
# ../c-source/main.c:95:       printf("Epsilon: %.15f\n", epsilon);
	mov	rax, QWORD PTR -24[rbp]	# tmp151, epsilon
	movq	xmm0, rax	#, tmp151
	lea	rdi, .LC18[rip]	#,
	mov	eax, 1	#,
	call	printf@PLT	#
.L24:
# ../c-source/main.c:97:     if (input_mode != 3) {
	cmp	DWORD PTR -4[rbp], 3	# input_mode,
	je	.L23	#,
# ../c-source/main.c:98:       printf("%.25f\n", answer);
	mov	rax, QWORD PTR -32[rbp]	# tmp152, answer
	movq	xmm0, rax	#, tmp152
	lea	rdi, .LC19[rip]	#,
	mov	eax, 1	#,
	call	printf@PLT	#
.L23:
# ../c-source/main.c:102:   printf("Time elapsed: %u microseconds\n", clocks_elapsed * 1000000 / CLOCKS_PER_SEC);
	mov	eax, DWORD PTR -8[rbp]	# tmp153, clocks_elapsed
	imul	eax, eax, 1000000	# _26, tmp153,
# ../c-source/main.c:102:   printf("Time elapsed: %u microseconds\n", clocks_elapsed * 1000000 / CLOCKS_PER_SEC);
	mov	eax, eax	# tmp154, _26
	imul	rax, rax, 1125899907	# tmp155, tmp154,
	shr	rax, 32	# tmp156,
	shr	eax, 18	# _27,
	mov	eax, eax	# _28, _27
	mov	rsi, rax	#, _28
	lea	rdi, .LC20[rip]	#,
	mov	eax, 0	#,
	call	printf@PLT	#
# ../c-source/main.c:103:   return 0;
	mov	eax, 0	# _34,
.L7:
# ../c-source/main.c:104: }
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
