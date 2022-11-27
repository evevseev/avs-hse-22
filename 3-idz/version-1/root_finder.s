	.file	"root_finder.c"
	.intel_syntax noprefix
# GNU C17 (Ubuntu 9.4.0-1ubuntu1~20.04.1) version 9.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 9.4.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version isl-0.22.1-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed:  -imultiarch x86_64-linux-gnu ../c-source/root_finder.c
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
	.globl	find_root
	.type	find_root, @function
find_root:
	endbr64	
	push	rbp	#
	mov	rbp, rsp	#,
	sub	rsp, 64	#,
	mov	QWORD PTR -24[rbp], rdi	# func, func
	movsd	QWORD PTR -32[rbp], xmm0	# a, a
	movsd	QWORD PTR -40[rbp], xmm1	# b, b
	movsd	QWORD PTR -48[rbp], xmm2	# eps, eps
# ../c-source/root_finder.c:8:     double x = (a + b) / 2;
	movsd	xmm0, QWORD PTR -32[rbp]	# tmp91, a
	addsd	xmm0, QWORD PTR -40[rbp]	# _1, b
# ../c-source/root_finder.c:8:     double x = (a + b) / 2;
	movsd	xmm1, QWORD PTR .LC0[rip]	# tmp93,
	divsd	xmm0, xmm1	# tmp92, tmp93
	movsd	QWORD PTR -8[rbp], xmm0	# x, tmp92
# ../c-source/root_finder.c:9:     while (fabs(func(x)) > eps) {
	jmp	.L2	#
.L6:
# ../c-source/root_finder.c:10:         if (func(a) * func(x) < 0) {
	mov	rax, QWORD PTR -32[rbp]	# tmp94, a
	mov	rdx, QWORD PTR -24[rbp]	# tmp95, func
	movq	xmm0, rax	#, tmp94
	call	rdx	# tmp95
	movsd	QWORD PTR -56[rbp], xmm0	# %sfp,
# ../c-source/root_finder.c:10:         if (func(a) * func(x) < 0) {
	mov	rax, QWORD PTR -8[rbp]	# tmp96, x
	mov	rdx, QWORD PTR -24[rbp]	# tmp97, func
	movq	xmm0, rax	#, tmp96
	call	rdx	# tmp97
# ../c-source/root_finder.c:10:         if (func(a) * func(x) < 0) {
	movsd	xmm1, QWORD PTR -56[rbp]	# _2, %sfp
	mulsd	xmm1, xmm0	# _2, _3
# ../c-source/root_finder.c:10:         if (func(a) * func(x) < 0) {
	pxor	xmm0, xmm0	# tmp98
	comisd	xmm0, xmm1	# tmp98, _4
	jbe	.L9	#,
# ../c-source/root_finder.c:11:             b = x;
	movsd	xmm0, QWORD PTR -8[rbp]	# tmp99, x
	movsd	QWORD PTR -40[rbp], xmm0	# b, tmp99
	jmp	.L5	#
.L9:
# ../c-source/root_finder.c:13:             a = x;
	movsd	xmm0, QWORD PTR -8[rbp]	# tmp100, x
	movsd	QWORD PTR -32[rbp], xmm0	# a, tmp100
.L5:
# ../c-source/root_finder.c:15:         x = (a + b) / 2;
	movsd	xmm0, QWORD PTR -32[rbp]	# tmp101, a
	addsd	xmm0, QWORD PTR -40[rbp]	# _5, b
# ../c-source/root_finder.c:15:         x = (a + b) / 2;
	movsd	xmm1, QWORD PTR .LC0[rip]	# tmp103,
	divsd	xmm0, xmm1	# tmp102, tmp103
	movsd	QWORD PTR -8[rbp], xmm0	# x, tmp102
.L2:
# ../c-source/root_finder.c:9:     while (fabs(func(x)) > eps) {
	mov	rax, QWORD PTR -8[rbp]	# tmp104, x
	mov	rdx, QWORD PTR -24[rbp]	# tmp105, func
	movq	xmm0, rax	#, tmp104
	call	rdx	# tmp105
# ../c-source/root_finder.c:9:     while (fabs(func(x)) > eps) {
	movq	xmm1, QWORD PTR .LC2[rip]	# tmp106,
	andpd	xmm0, xmm1	# _7, tmp106
# ../c-source/root_finder.c:9:     while (fabs(func(x)) > eps) {
	comisd	xmm0, QWORD PTR -48[rbp]	# _7, eps
	ja	.L6	#,
# ../c-source/root_finder.c:17:     return x;
	movsd	xmm0, QWORD PTR -8[rbp]	# _21, x
# ../c-source/root_finder.c:18: }
	leave	
	ret	
	.size	find_root, .-find_root
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1073741824
	.align 16
.LC2:
	.long	4294967295
	.long	2147483647
	.long	0
	.long	0
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
