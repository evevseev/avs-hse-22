	.intel_syntax noprefix
	.text
	.local	ARRAY				# / Выделяем память под ARRAY
	.comm	ARRAY,4800000,32	# \
	.section	.rodata
# Подсказки при некорректных аргументах и строки для парсинга аргументов запуска
.LC0:
	.string	"-file"
	.align 8
.LC1:
	.string	"Usage: %s -file <input_file_path> [output_file_path]\n"
.LC2:
	.string	"-random"
	.align 8
.LC3:
	.string	"Usage: %s -random <from 0 to 300.000 array_size> <rand_seed>\n"
.LC4:
	.string	"-test"
.LC5:
	.string	"Usage: %s -test <seed>\n"
.LC6:
	.string	"Unknown arguments: %s\n"
	.align 8
.LC7:
	.string	"Time elapsed: %ld microseconds\n"
	.text
	.globl	main
	.type	main, @function

# ## main()
# ### Локальные перменные
# - DWORD -4[rbp]     - array_size
# - DWORD -8[rbp]     - rand_seed
# - DWORD -12[rbp]    - input_mode
# - DWORD -16[rbp]    - clocks_elapsed
# - DWORD -20[rbp]    - i
# - QWORD -32[rbp]    - file_path
# - QWORD -40[rbp]    - start_time 
# - QWORD -48[rbp]    - end_time
# - DWORD -52[rbp]    - количество аргументов запуска
# - QWORD -64[rbp]    - указатель на аргументы
# ### Параметры и возвращаемый результат
# - edi - argc
# - rsi - argc
# - rax (return) - exit code

main:
	endbr64

	push	rbp						# /  Стандартный пролог,
	mov	rbp, rsp					# \  cохранения указателя стэка вызывающей функции

	sub	rsp, 64						# < выделяем память под локальные переменные на стеке

									# / Сохраняем на стеке:
	mov	DWORD PTR -52[rbp], edi		# | edi - кол-во аргуметов запуска
	mov	QWORD PTR -64[rbp], rsi		# \ rsi - указать на массив с аргументами

	cmp	DWORD PTR -52[rbp], 1		# / if rsi != 1
	jne	.L2							# \ goto .L2
	mov	DWORD PTR -12[rbp], 0		# < input_mode = 0

	# read_array_from_console()
	# rdi - &array
	# rsi - max_size
	# rax (return) - array_size
	mov	esi, 300000						# / max_size
	lea	rdi, ARRAY[rip]					# | &ARRAY
	call	read_array_from_console@PLT # |
	mov	DWORD PTR -4[rbp], eax			# \ array_size = read_array_from_console(&ARRAY, 300000)

	jmp	.L3							

.L2:								# < if rsi != 1
	mov	rax, QWORD PTR -64[rbp]		# /
	add	rax, 8						# |
	mov	rax, QWORD PTR [rax]		# \ rax = argv[1]
	
	# strcmp()
	# rsi - 2nd string
	# rdi - 1st string
	# rax (return) - comparison result
	lea	rsi, .LC0[rip]				# / "-file"
	mov	rdi, rax					# | argv[1]
	call	strcmp@PLT				# \ strcmp(argv[1], "-file")

	test	eax, eax				# / if strcmp(argv[1], "-file") == 0
	jne	.L4							# \	goto .L4

	cmp	DWORD PTR -52[rbp], 2		# / if argc > 2
	jg	.L5							# \ go to L5

	mov	rax, QWORD PTR -64[rbp]		# /
	mov	rax, QWORD PTR [rax]		# \ rax = argv[0]

	# printf()
	# rsi - value
	# rdi - format
	# eax - count of xmm values 
	mov	rsi, rax					# / Печать сообщения об ошибке
	lea	rdi, .LC1[rip]				# |
	mov	eax, 0						# |
	call	printf@PLT				# \

	mov	eax, 1						# / exit(1)
	jmp	.L6							# \
.L5:
	mov	rax, QWORD PTR -64[rbp]		# < rax = &argv
	mov	rax, QWORD PTR 16[rax]		# < rax = argv[2]
	mov	QWORD PTR -32[rbp], rax		# / [можно оптимизировать ]
	mov	rax, QWORD PTR -32[rbp]		# \ Компилятор сохраняет на стеке, так как будет происходить повторное обращение при выводе
	
	# read_array_from_file()
	# rdi - &array
	# rsi - &filepath
	# edx - max_size
	# rax (return) - array_size
	mov	edx, 300000					# /
	mov	rsi, rax					# |
	lea	rdi, ARRAY[rip]				# |
	call	read_array_from_file@PLT # |
	mov	DWORD PTR -4[rbp], eax		# \ array_size = read_array_from_file(&ARRAY, &filepath, 300000)

	mov	DWORD PTR -12[rbp], 1		# < input_mode = 1
	jmp	.L3
.L4:
	mov	rax, QWORD PTR -64[rbp]		# < rax = &argv
	add	rax, 8						# / 
	mov	rax, QWORD PTR [rax]		# \ rax = argv[1]

	# strcmp()
	# rsi - 2nd string
	# rdi - 1st string
	# rax (return) - comparison result
	lea	rsi, .LC2[rip]				# /
	mov	rdi, rax					# | 
	call	strcmp@PLT				# \  strcmp(argv[1], "-random")

	test	eax, eax				# / if strcmp(argv[1], "-random") == 0
	jne	.L7							# \ goto .L7

	cmp	DWORD PTR -52[rbp], 3		# / if argc > 3:
	jg	.L8							# \		then go .L8
									
									# < else, выводим сообщение
	mov	rax, QWORD PTR -64[rbp]		# < rax = &argv
	mov	rax, QWORD PTR [rax]		# < rax = argv[0]

	# printf()
	# rsi - value
	# rdi - format
	# eax - count of xmm values 
	mov	rsi, rax					# / Выводим сообщение об ошибке
	lea	rdi, .LC3[rip]				# | текст подсказки 
	mov	eax, 0						# |
	call	printf@PLT				# \

	mov	eax, 1						# / exit(1)
	jmp	.L6							# \

.L8:
	mov	rax, QWORD PTR -64[rbp]     # < rax = &argv
	add	rax, 16						# /	rax = argv[2]
	mov	rax, QWORD PTR [rax]		# \

	# atoi()
	# rdi - string
	# rax (return) - int value
	mov	rdi, rax					# / argv[2] 
	call	atoi@PLT				# |
	mov	DWORD PTR -4[rbp], eax		# \ array_size = atoi(argv[2])

	mov	rax, QWORD PTR -64[rbp]		# < rax = &argv
	add	rax, 24						# /	rax = argv[3]
	mov	rax, QWORD PTR [rax]		# \

	# atoi()
	# rdi - string
	# rax (return) - int value
	mov	rdi, rax					# / argv[3] 	
	call	atoi@PLT				# |
	mov	DWORD PTR -8[rbp], eax		# \ rand_seed =  atoi(argv[3])

	# random_fill_array()
	# rdi - &array
	# esi - size
	# edx - seed
	# rax (return) - array_size
	mov	edx, DWORD PTR -8[rbp]		# / rand_seed
	mov	eax, DWORD PTR -4[rbp]		# | array_size
	mov	esi, eax					# |
	lea	rdi, ARRAY[rip]				# | &ARRAY
	call	random_fill_array@PLT	# \

	# print_array()
	# rdi - &array
	# esi - size
	mov	esi, DWORD PTR -4[rbp]		# / array_size
	lea	rdi, ARRAY[rip]				# | &ARRAY
	call	print_array@PLT			# | print_array(&ARRAY, array_size)

	mov	DWORD PTR -12[rbp], 2		# < input_mode = 2
	jmp	.L3							
.L7:
	mov	rax, QWORD PTR -64[rbp]		# /
	add	rax, 8						# |
	mov	rax, QWORD PTR [rax]		# \ rax = argv[1]

	# strcmp()
	# rsi - 2nd string
	# rdi - 1st string
	# rax (return) - comparison result
	lea	rsi, .LC4[rip]				# / strcmp(argv[1], "-test")
	mov	rdi, rax					# |
	call	strcmp@PLT				# \

	test	eax, eax				# / if strcmp(argv[1], "-test") == 0
	jne	.L9							# \	 if not, then gog L9

	cmp	DWORD PTR -52[rbp], 2		# / if argc > 2
	jg	.L10						# \   then go .L10

	mov	rax, QWORD PTR -64[rbp]		# / rax = arv[0]
	mov	rax, QWORD PTR [rax]		# \

	# printf()
	# rsi - value
	# rdi - format
	# eax - count of xmm values 
	mov	rsi, rax					# / Выводим сообщение об ошибке
	lea	rdi, .LC5[rip]				# |
	mov	eax, 0						# |
	call	printf@PLT				# \

	mov	eax, 1						# / exit(1)
	jmp	.L6							# \

.L10:								# -test
	mov	rax, QWORD PTR -64[rbp]		# /
	add	rax, 16						# |
	mov	rax, QWORD PTR [rax]		# \ rax = arv[1]

	# atoi()
	# rdi - string
	# rax (return) - int value
	mov	rdi, rax					# /
	call	atoi@PLT				# |
	mov	DWORD PTR -8[rbp], eax		# \ rand_seed = atoi(argv[2])
	mov	DWORD PTR -12[rbp], 3		# < input_mode = 3;
	jmp	.L3							# < переход к обработке

.L9:
	mov	rax, QWORD PTR -64[rbp]		# /
	add	rax, 8						# |
	mov	rax, QWORD PTR [rax]		# \ rax = argv[1]

	# printf()
	# rsi - value
	# rdi - format
	# eax - count of xmm values 
	mov	rsi, rax					# / Выводим сообщение об ошибке
	lea	rdi, .LC6[rip]				# |
	mov	eax, 0						# |
	call	printf@PLT				# \

	mov	eax, 1						# / exit(1)
	jmp	.L6							# \ 

# Обработка массива
.L3:
	mov	DWORD PTR -16[rbp], 0		# < clocks_elapsed = 0

	cmp	DWORD PTR -12[rbp], 3		# / if input == 3
	jne	.L11						# \ if not, go to .L11

	mov	DWORD PTR -20[rbp], 0		# < int i = 0
	jmp	.L12						# < for begin

# for loop if input_mode == 3
.L13:
	# random_fill_array()
	# rdi - &array
	# esi - size
	# edx - seed
	# rax (return) - array_size
	mov	eax, DWORD PTR -8[rbp] 		# / /
	mov	edx, eax					# | \ rand_seed
	mov	esi, 300000					# | array_size
	lea	rdi, ARRAY[rip]				# | &ARRAY
	call	random_fill_array@PLT	# \

	# clock()
	call	clock@PLT				# / 
	mov	QWORD PTR -40[rbp], rax		# \ start_time = clock()
	
	# process_array()
	# rdi - &array
	# esi - size
	mov	esi, 300000					# / размер массива
	lea	rdi, ARRAY[rip]				# | &ARRAY
	call	process_array@PLT		# \ 

	call	clock@PLT				# /
	mov	QWORD PTR -48[rbp], rax		# \ end_time = clock()

	mov	rax, QWORD PTR -48[rbp]		# /
	mov	edx, eax					# \ edx = end_time

	mov	rax, QWORD PTR -40[rbp]		# /	
	sub	edx, eax					# \ edx -= start_time

	mov	eax, DWORD PTR -16[rbp]		# / 
	add	eax, edx					# |	clocks_elapsed += edx
	mov	DWORD PTR -16[rbp], eax		# \

	add	DWORD PTR -20[rbp], 1		# < i += 1

.L12:
	cmp	DWORD PTR -20[rbp], 4999 	# / if i <= 4999
	jle	.L13						# |	go .L13
	jmp	.L14						# \ else go .L14 (output)


.L11:					
	# clock()
	call	clock@PLT				# / 
	mov	QWORD PTR -40[rbp], rax		# \ start_time = clock()

	# process_array()
	# rdi - &array
	# esi - size
	mov	eax, DWORD PTR -4[rbp]		# / array_size
	mov	esi, eax					# | \
	lea	rdi, ARRAY[rip]				# |	 &ARRAY
	call	process_array@PLT		# \

	# clock()
	call	clock@PLT				# /
	mov	QWORD PTR -48[rbp], rax		# \ end_time = clock()

	mov	rax, QWORD PTR -48[rbp]		# / 
	mov	edx, eax					# \ edx = end_time

	mov	rax, QWORD PTR -40[rbp]		# /
	sub	edx, eax					# \ edx -= start_time

	mov	eax, DWORD PTR -16[rbp]		# /	
	add	eax, edx					# |
	mov	DWORD PTR -16[rbp], eax		# \ clocks_elapsed += edx

.L14:
	cmp	DWORD PTR -12[rbp], 0		# / if input_mode == 0
	je	.L15						# | ||
	cmp	DWORD PTR -12[rbp], 2		# | input_mode == 2
	je	.L15						# \ got to .L15

	cmp	DWORD PTR -12[rbp], 1		# / if input_mode == 1
	jne	.L16						# |	&& argc == 3
	cmp	DWORD PTR -52[rbp], 3		# |if not, go to L16
	jne	.L16						# \


.L15:
	# print_array()
	# rdi - &array
	# esi - size
	mov	eax, DWORD PTR -4[rbp]		# / array_size
	mov	esi, eax					# \ 
	lea	rdi, ARRAY[rip]				# < &ARRAY
	call	print_array@PLT			# print array to console

	jmp	.L17						# go to ptinting elapsed time

# save to file
.L16:
	cmp	DWORD PTR -12[rbp], 1		# / continue further only if
	jne	.L17						# \	input_mode == 1

	mov	rax, QWORD PTR -64[rbp] 	# /
	mov	rax, QWORD PTR 24[rax]		# \ rax = arv[3]
	mov	QWORD PTR -32[rbp], rax		# < file_path = rax

	# save_array_to_file()
	# rdi - &array
	# rsi - size
	# edx - &filepath
	mov	rdx, QWORD PTR -32[rbp]		# / file_path
	mov	eax, DWORD PTR -4[rbp]		# |	/
	mov	esi, eax					# |	\ array_size
	lea	rdi, ARRAY[rip]				# | &ARRAY
	call	save_array_to_file@PLT	# \

.L17:
	# printf()
	# rsi - value
	# rdi - format
	# eax - count of xmm values
	mov	eax, DWORD PTR -16[rbp]		# / Пеачать clock_elapsed
	cdqe							# | < convert eax to rax (не обязателен)
	mov	rsi, rax					# |
	lea	rdi, .LC7[rip]				# |
	mov	eax, 0						# |
	call	printf@PLT				# \

	mov	eax, 0						# < eax = 0 (return 0)
.L6:
	leave							# / Exit :) 
	ret								# \
