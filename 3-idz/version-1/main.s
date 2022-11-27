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
# ../c-source/main.c:10:     return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	movsd	xmm0, QWORD PTR -8[rbp]	# tmp91, x
	mulsd	xmm0, xmm0	# _1, tmp91
# ../c-source/main.c:10:     return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	mulsd	xmm0, QWORD PTR -8[rbp]	# _2, x
# ../c-source/main.c:10:     return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	movsd	xmm2, QWORD PTR -8[rbp]	# tmp92, x
	movsd	xmm1, QWORD PTR .LC0[rip]	# tmp93,
	mulsd	xmm1, xmm2	# _3, tmp92
# ../c-source/main.c:10:     return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	mulsd	xmm1, QWORD PTR -8[rbp]	# _4, x
# ../c-source/main.c:10:     return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	subsd	xmm0, xmm1	# _2, _4
	movapd	xmm1, xmm0	# _5, _2
# ../c-source/main.c:10:     return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	movsd	xmm2, QWORD PTR -8[rbp]	# tmp94, x
	movsd	xmm0, QWORD PTR .LC1[rip]	# tmp95,
	mulsd	xmm0, xmm2	# _6, tmp94
# ../c-source/main.c:10:     return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	addsd	xmm0, xmm1	# _7, _5
# ../c-source/main.c:10:     return x * x * x - 0.5 * x * x + 0.2 * x - 4;
	movsd	xmm1, QWORD PTR .LC2[rip]	# tmp96,
	subsd	xmm0, xmm1	# _9, tmp96
# ../c-source/main.c:11: }
	pop	rbp	#
	ret	
	.size	f, .-f
	.section	.rodata
.LC5:
	.string	"%lf"
.LC6:
	.string	"%.25f\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64	
	push	rbp	#
	mov	rbp, rsp	#,
	sub	rsp, 48	#,
# ../c-source/main.c:14:     rf_function func = &f;
	lea	rax, f[rip]	# tmp85,
	mov	QWORD PTR -8[rbp], rax	# func, tmp85
# ../c-source/main.c:15:     double a = 1;
	movsd	xmm0, QWORD PTR .LC3[rip]	# tmp86,
	movsd	QWORD PTR -16[rbp], xmm0	# a, tmp86
# ../c-source/main.c:16:     double b = 3;
	movsd	xmm0, QWORD PTR .LC4[rip]	# tmp87,
	movsd	QWORD PTR -24[rbp], xmm0	# b, tmp87
# ../c-source/main.c:18:     scanf("%lf", &eps);
	lea	rax, -40[rbp]	# tmp88,
	mov	rsi, rax	#, tmp88
	lea	rdi, .LC5[rip]	#,
	mov	eax, 0	#,
	call	__isoc99_scanf@PLT	#
# ../c-source/main.c:19:     double root = find_root(func, a, b, eps);
	movsd	xmm1, QWORD PTR -40[rbp]	# eps.0_1, eps
	movsd	xmm0, QWORD PTR -24[rbp]	# tmp89, b
	mov	rdx, QWORD PTR -16[rbp]	# tmp90, a
	mov	rax, QWORD PTR -8[rbp]	# tmp91, func
	movapd	xmm2, xmm1	#, eps.0_1
	movapd	xmm1, xmm0	#, tmp89
	movq	xmm0, rdx	#, tmp90
	mov	rdi, rax	#, tmp91
	call	find_root@PLT	#
	movq	rax, xmm0	# tmp92,
	mov	QWORD PTR -32[rbp], rax	# root, tmp92
# ../c-source/main.c:20:     printf("%.25f\n", root);
	mov	rax, QWORD PTR -32[rbp]	# tmp93, root
	movq	xmm0, rax	#, tmp93
	lea	rdi, .LC6[rip]	#,
	mov	eax, 1	#,
	call	printf@PLT	#
# ../c-source/main.c:21:     return 0;
	mov	eax, 0	# _10,
# ../c-source/main.c:22: }
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
	.long	0
	.long	1072693248
	.align 8
.LC4:
	.long	0
	.long	1074266112
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
