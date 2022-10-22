	.file	"main.c"
	.intel_syntax noprefix
	.text
	.local	ARRAY
	.comm	ARRAY,4800000,32
	.section	.rodata
# Для парсинга аргументов запуска
.LC0:
	.string	"-file"
	.align 8
# Подсказка при некорректных аргументах аргментах
.LC1:
	.string	"Usage: %s -file <input_file_path> [output_file_path]\n"
# Для парсинга аргументов запуска
.LC2:
	.string	"-random"
	.align 8
# Подсказка при некорректных аргументах аргментах
.LC3:
	.string	"Usage: %s -random <from 0 to 300.000 array_size> <rand_seed>\n"
# Для парсинга аргументов запуска
.LC4:
	.string	"-test"
# Подсказка при некорректных аргументах аргментах
.LC5:
	.string	"Usage: %s -test <seed>\n"
# Подсказка при некорректных аргументах аргментах
.LC6:
	.string	"Unknown arguments: %s\n"
	.align 8
# Шаблон сообщения для вывода времени исполнения
.LC7:
	.string	"Time elapsed: %ld microseconds\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64							# < Системное, можно удалить

	push	rbp						# /  Стандартный пролог сохранения указателя стэка вызывающей функции
	mov	rbp, rsp					# \

	sub	rsp, 64						# < выделяем память под локальные переменные

									# Сохраняем на стеке:
	mov	DWORD PTR -52[rbp], edi		# < edi - кол-во аргуметов запуска
	mov	QWORD PTR -64[rbp], rsi		# < rsi - указать на массив с аргументами

	cmp	DWORD PTR -52[rbp], 1		# / if rsi == 1
	jne	.L2							# \
	mov	DWORD PTR -12[rbp], 0	

	lea	rdi, ARRAY[rip]				# < Адрес результатирующего массива
	call	read_array_from_console@PLT
	mov	DWORD PTR -4[rbp], eax		# < Сохраняем результат (размер массива)

	jmp	.L3							# < else 

# < if rsi != 1
.L2:
	mov	rax, QWORD PTR -64[rbp]		# /
	add	rax, 8						# |
	mov	rax, QWORD PTR [rax]		# \ rax = argv[1]

	lea	rsi, .LC0[rip]				# / -file
	mov	rdi, rax					# | 
	call	strcmp@PLT				# \ strcmp(argv[1], "-file")

	test	eax, eax				# / if not so
	jne	.L4							# \ got to .L4

	cmp	DWORD PTR -52[rbp], 2		# / if argc > 2
	jg	.L5							# \ go to L5

	mov	rax, QWORD PTR -64[rbp]		# /
	mov	rax, QWORD PTR [rax]		# \ rax = argv[0]

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
	
	mov	rsi, rax					# < второй аргумент, путь к файлу
	lea	rdi, ARRAY[rip]				# < первый аргумент, куда читаем
	call	read_array_from_file@PLT
	mov	DWORD PTR -4[rbp], eax		# < array_size = результат функции

	mov	DWORD PTR -12[rbp], 1		# < input_mode = 1
	jmp	.L3
.L4:
	mov	rax, QWORD PTR -64[rbp]		# < rax = &argv
	add	rax, 8						# / 
	mov	rax, QWORD PTR [rax]		# \ rax = argv[1]

	lea	rsi, .LC2[rip]				# / strcmp(argv[1], "-random")
	mov	rdi, rax					# | 
	call	strcmp@PLT				# \ 

	test	eax, eax				# / if strcmp(argv[1], "-random") == 0
	jne	.L7							# \ if not, then .L7

	cmp	DWORD PTR -52[rbp], 3		# / if argc > 3:
	jg	.L8							# \		then go .L8
									
									# < else, выводим сообщение
	mov	rax, QWORD PTR -64[rbp]		# < rax = &argv
	mov	rax, QWORD PTR [rax]		# < rax = argv[0]

	mov	rsi, rax					# / Выводим сообщение об ошибке
	lea	rdi, .LC3[rip]				# |
	mov	eax, 0						# |
	call	printf@PLT				# \

	mov	eax, 1						# / exit(1)
	jmp	.L6							# \

.L8:
	mov	rax, QWORD PTR -64[rbp]     # < rax = &argv
	add	rax, 16						# /	rax = argv[2]
	mov	rax, QWORD PTR [rax]		# \

	mov	rdi, rax					# / Получаем число из argv[2] 
	call	atoi@PLT				# \
	mov	DWORD PTR -4[rbp], eax		# < array_size = atoi(argv[2])

	mov	rax, QWORD PTR -64[rbp]		# < rax = &argv
	add	rax, 24						# /	rax = argv[3]
	mov	rax, QWORD PTR [rax]		# \

	mov	rdi, rax					# / Получаем число из argv[3] 	
	call	atoi@PLT				# \
	mov	DWORD PTR -8[rbp], eax		# rand_seed =  atoi(argv[3])

	mov	edx, DWORD PTR -8[rbp]		# < третий, rand_seed
	mov	eax, DWORD PTR -4[rbp]		# / второй аргумент, array_size
	mov	esi, eax					# \
	lea	rdi, ARRAY[rip]				# < третий аргумент, &ARRAY
	call	random_fill_array@PLT	
	mov	DWORD PTR -12[rbp], 2		# < input_mode = 2
	jmp	.L3							
.L7:
	mov	rax, QWORD PTR -64[rbp]		# /
	add	rax, 8						# |
	mov	rax, QWORD PTR [rax]		# \ rax = argv[1]

	lea	rsi, .LC4[rip]				# / strcmp(argv[1], "-test")
	mov	rdi, rax					# |
	call	strcmp@PLT				# \

	test	eax, eax				# / if strcmp(argv[1], "-test") == 0
	jne	.L9							# \	 if not, then gog L9

	cmp	DWORD PTR -52[rbp], 2		# / if argc > 2
	jg	.L10						# \   then go .L10

	mov	rax, QWORD PTR -64[rbp]		# / rax = arv[0]
	mov	rax, QWORD PTR [rax]		# \

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

	mov	rdi, rax					# /
	call	atoi@PLT				# |
	mov	DWORD PTR -8[rbp], eax		# \ rand_seed = atoi(argv[2])
	mov	DWORD PTR -12[rbp], 3		# < input_mode = 3;
	jmp	.L3							# < переход к обработке
.L9:
	mov	rax, QWORD PTR -64[rbp]		# /
	add	rax, 8						# |
	mov	rax, QWORD PTR [rax]		# \ rax = argv[1]

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
	mov	eax, DWORD PTR -8[rbp] 		# / /	третий аргумент, 
	mov	edx, eax					# | \ edx = rand_seed
	mov	esi, 300000					# | второй аргумент, размер массива
	lea	rdi, ARRAY[rip]				# | первый аргумент, &ARRAY
	call	random_fill_array@PLT	# \

	call	clock@PLT				# / 
	mov	QWORD PTR -40[rbp], rax		# \ start_time = clock()
	
	mov	esi, 300000					# / второй аргумент, размер массива
	lea	rdi, ARRAY[rip]				# | первый аргумент, &ARRAY
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

# for loop if input_mode != 3
.L11:
	call	clock@PLT				# / 
	mov	QWORD PTR -40[rbp], rax		# \ start_time = clock()

	mov	eax, DWORD PTR -4[rbp]		# / / 2ой аргумент = array_size
	mov	esi, eax					# | \
	lea	rdi, ARRAY[rip]				# |	1ый аргумент = &ARRAY
	call	process_array@PLT		# \

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

# print array
.L15:
	mov	eax, DWORD PTR -4[rbp]		# / 2ой аргумент, array_size
	mov	esi, eax					# \ 
	lea	rdi, ARRAY[rip]				# < 1ый аргумент, &ARRAY
	call	print_array@PLT			# print array to console

	jmp	.L17						# go to ptinting elapsed time

# save to file
.L16:
	cmp	DWORD PTR -12[rbp], 1		# / continue further only if
	jne	.L17						# \	input_mode == 1

	mov	rax, QWORD PTR -64[rbp] 	# /
	mov	rax, QWORD PTR 24[rax]		# \ rax = arv[3]
	mov	QWORD PTR -32[rbp], rax		# < file_path = rax
	mov	rdx, QWORD PTR -32[rbp]		# / 3ий аргумент, file_path
	mov	eax, DWORD PTR -4[rbp]		# |	/
	mov	esi, eax					# |	\ 2ой аргумент, array_size
	lea	rdi, ARRAY[rip]				# | 1ый аргумент, &ARRAY
	call	save_array_to_file@PLT	# \

.L17:
	mov	eax, DWORD PTR -16[rbp]		# / Пеачать clock_elapsed
	cdqe							# | < системная штука, которую можно убрать
	mov	rsi, rax					# |
	lea	rdi, .LC7[rip]				# |
	mov	eax, 0						# |
	call	printf@PLT				# \

	mov	eax, 0						# < eax = 0 (return 0)
.L6:
	leave							# / Exit :) 
	ret								# \
	
	# А дальше, GCC оставляет свой след в истории написания IDZ 1 :)
	.size	main, .-main
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
