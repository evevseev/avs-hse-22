	.file	"fileio.c"
	.intel_syntax noprefix
# GNU C17 (Ubuntu 9.4.0-1ubuntu1~20.04.1) version 9.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 9.4.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0, isl version isl-0.22.1-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed:  -imultiarch x86_64-linux-gnu ../c-source/fileio.c
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
write_number_to_file:
	endbr64	
	push	rbp	#
	mov	rbp, rsp	#,
	sub	rsp, 32	#,
	mov	QWORD PTR -24[rbp], rdi	# filename, filename
	movsd	QWORD PTR -32[rbp], xmm0	# number, number
# ../c-source/fileio.c:8:   FILE *file = fopen(filename, "w");
	mov	rax, QWORD PTR -24[rbp]	# tmp84, filename
	lea	rsi, .LC0[rip]	#,
	mov	rdi, rax	#, tmp84
	call	fopen@PLT	#
	mov	QWORD PTR -8[rbp], rax	# file, tmp85
# ../c-source/fileio.c:9:   if (file == NULL) {
	cmp	QWORD PTR -8[rbp], 0	# file,
	jne	.L2	#,
# ../c-source/fileio.c:10:     printf("Error opening file!\n");
	lea	rdi, .LC1[rip]	#,
	call	puts@PLT	#
# ../c-source/fileio.c:11:     exit(1);
	mov	edi, 1	#,
	call	exit@PLT	#
.L2:
# ../c-source/fileio.c:13:   fprintf(file, "%.25f\n", number);
	mov	rdx, QWORD PTR -32[rbp]	# tmp86, number
	mov	rax, QWORD PTR -8[rbp]	# tmp87, file
	movq	xmm0, rdx	#, tmp86
	lea	rsi, .LC2[rip]	#,
	mov	rdi, rax	#, tmp87
	mov	eax, 1	#,
	call	fprintf@PLT	#
# ../c-source/fileio.c:14:   fclose(file);
	mov	rax, QWORD PTR -8[rbp]	# tmp88, file
	mov	rdi, rax	#, tmp88
	call	fclose@PLT	#
# ../c-source/fileio.c:15:   return number;
	movsd	xmm0, QWORD PTR -32[rbp]	# _8, number
# ../c-source/fileio.c:16: }
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
read_number_from_file:
	endbr64	
	push	rbp	#
	mov	rbp, rsp	#,
	sub	rsp, 32	#,
	mov	QWORD PTR -24[rbp], rdi	# filename, filename
# ../c-source/fileio.c:19:   FILE *file = fopen(filename, "r");
	mov	rax, QWORD PTR -24[rbp]	# tmp84, filename
	lea	rsi, .LC3[rip]	#,
	mov	rdi, rax	#, tmp84
	call	fopen@PLT	#
	mov	QWORD PTR -8[rbp], rax	# file, tmp85
# ../c-source/fileio.c:20:   if (file == NULL) {
	cmp	QWORD PTR -8[rbp], 0	# file,
	jne	.L5	#,
# ../c-source/fileio.c:21:     printf("Error opening file!\n");
	lea	rdi, .LC1[rip]	#,
	call	puts@PLT	#
# ../c-source/fileio.c:22:     exit(1);
	mov	edi, 1	#,
	call	exit@PLT	#
.L5:
# ../c-source/fileio.c:25:   fscanf(file, "%lf", &number);
	lea	rdx, -16[rbp]	# tmp86,
	mov	rax, QWORD PTR -8[rbp]	# tmp87, file
	lea	rsi, .LC4[rip]	#,
	mov	rdi, rax	#, tmp87
	mov	eax, 0	#,
	call	__isoc99_fscanf@PLT	#
# ../c-source/fileio.c:26:   fclose(file);
	mov	rax, QWORD PTR -8[rbp]	# tmp88, file
	mov	rdi, rax	#, tmp88
	call	fclose@PLT	#
# ../c-source/fileio.c:27:   return number;
	movsd	xmm0, QWORD PTR -16[rbp]	# _7, number
# ../c-source/fileio.c:28: }
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
