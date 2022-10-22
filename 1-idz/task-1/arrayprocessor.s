	.file	"arrayprocessor.c"
	.intel_syntax noprefix
	.text
	.globl	process_array
	.type	process_array, @function
process_array:						#
	endbr64							# < служебная инструкция
	push	rbp						# / стандартный пролог
	mov	rbp, rsp					# \ 

	mov	QWORD PTR -24[rbp], rdi		# / сохраняем аргументы, &array
	mov	DWORD PTR -28[rbp], esi		# \ size
	mov	DWORD PTR -4[rbp], 0		# < i = 0
	jmp	.L2							# < переход к условию цикла

.L5:								# < тело цикла
	mov	eax, DWORD PTR -4[rbp]		# / eax = i
	cdqe							# \ системный вызов, преобразует DWORD в QWORD

	lea	rdx, 0[0+rax*4]				# < находим смещение iого элемента в массиве
	mov	rax, QWORD PTR -24[rbp]		# / rax = &array
	add	rax, rdx					# \ rax = &array[i]

	mov	eax, DWORD PTR [rax]		# < eax = значение array[i]
	test	eax, eax				# /
	jg	.L6							# \ если array[i] > 0, то переходим к .L6 (break)
	mov	eax, DWORD PTR -4[rbp]		# / eax = i
	cdqe							# \ системный вызов, преобразует DWORD в QWORD

	lea	rdx, 0[0+rax*4]				# < находим смещение iого элемента в массиве
	mov	rax, QWORD PTR -24[rbp]		# / rax = &array
	add	rax, rdx					# \ rax = &array[i]
	mov	edx, DWORD PTR [rax]		# < edx = значение array[i]
	
	mov	eax, DWORD PTR -4[rbp]		# / eax = i
	cdqe							# \ системный вызов, преобразует DWORD в QWORD
	
	lea	rcx, 0[0+rax*4]				# < находим смещение iого элемента в массиве
	mov	rax, QWORD PTR -24[rbp]		# / rax = &array
	add	rax, rcx					# \ rax = &array[i]
	sub	edx, 5						# / edx = rax - 5
	mov	DWORD PTR [rax], edx		# \ array[i] = array[i] - 5

	add	DWORD PTR -4[rbp], 1		# < i++

.L2:								# < условие цикла
	mov	eax, DWORD PTR -4[rbp]		# /
	cmp	eax, DWORD PTR -28[rbp]		# | if i < size
	jl	.L5							# | goto .L5 (обратно в цикл)
	jmp	.L7							# \ goto .L7 (выход из функции)

.L6:								# / break в цикле
	nop								# \

.L7:								# / выход из функции
	nop								# |
	pop	rbp							# |
	ret								# \
	
	# служебные метки gcc
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
