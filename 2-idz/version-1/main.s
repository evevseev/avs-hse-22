	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"String to find was not provided"
.LC1:
	.string	"-file"
	.align 8
.LC2:
	.string	"Usage: %s <substr> -file <input_file_path> [output_file_path]\n"
.LC3:
	.string	"-random"
	.align 8
.LC4:
	.string	"Usage: %s <substr> -random <seed> <from 0 to 300.000 string_size>\n"
.LC5:
	.string	"-test"
	.align 8
.LC6:
	.string	"Usage: %s <substr> -test <seed>\n"
	.align 8
.LC7:
	.string	"Unknown argument or in wrong position: %s\n"
.LC8:
	.string	"w"
.LC9:
	.string	"%ld "
	.align 8
.LC10:
	.string	"Time elapsed: %ld microseconds\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64	
	push	rbp	
	mov	rbp, rsp

	sub	rsp, 112
	mov	DWORD PTR -100[rbp], edi	# < argc
	mov	QWORD PTR -112[rbp], rsi	# < argv

	cmp	DWORD PTR -100[rbp], 1	# if (argc < 2)
	jg	.L2						# goto .L2

	lea	rdi, .LC0[rip] 	# /
	call	puts@PLT	# \ printf("String to find was not provided\n")

	mov	edi, 1			# /
	call	exit@PLT	# \ exit(1) 

.L2:
	mov	rax, QWORD PTR -112[rbp]	# /
	mov	rax, QWORD PTR 8[rax]		# | argv[1]
	mov	QWORD PTR -48[rbp], rax		# \ tr_to_find = argv[1]

	cmp	DWORD PTR -100[rbp], 2	# / if (argc == 2) 
	jne	.L3						# \ if not, goto L3

	mov	edi, 300000							# /
	call	read_string_from_console@PLT	# |
	mov	QWORD PTR -16[rbp], rax				# \ str_to_search_in = read_string_from_console(MAX_SIZE)#

	mov	DWORD PTR -4[rbp], 0				# < input_mode = 0#
	jmp	.L4	#
.L3:

	mov	rax, QWORD PTR -112[rbp]	# //argv
	add	rax, 16						# ||
	mov	rax, QWORD PTR [rax]		# |\ rax = argv[2]
	lea	rsi, .LC1[rip]				# | "-file"
	mov	rdi, rax					# | rdi = argv[2]
	call	strcmp@PLT				# | 
	test	eax, eax				# | if (strcmp(argv[2], "-file") == 0) {
	jne	.L5							# \ if not, goto L5

	cmp	DWORD PTR -100[rbp], 3		# / if (argc > 3)
	jg	.L6							# \ if so, goto 3
         
	mov	rax, QWORD PTR -112[rbp]	# / /
	mov	rax, QWORD PTR [rax]		# | | rsi = argv[0]
	mov	rsi, rax					# | \
	lea	rdi, .LC2[rip]				# | "Usage: %s <substr> -file <input_file_path> [output_file_path]\n"
	mov	eax, 0						# |
	call	printf@PLT				# \ printf("Usage: %s <substr> -file <input_file_path> [output_file_path]\n", argv[0])#

	mov	eax, 1		# /
	jmp	.L7			# \ return 1
.L6:
	mov	rax, QWORD PTR -112[rbp]	# / 
	mov	rax, QWORD PTR 24[rax]		# |
	mov	QWORD PTR -64[rbp], rax		# \ file_path = argv[3]

	mov	rax, QWORD PTR -64[rbp]			# / 
	mov	esi, 300000						# |
	mov	rdi, rax						# | rdi = file_path
	call	read_string_from_file@PLT	# | 
	mov	QWORD PTR -16[rbp], rax			# \ str_to_search_in =  read_string_from_file(file_path, MAX_SIZE)

	mov	DWORD PTR -4[rbp], 1	# <  input_mode = 1
	jmp	.L4	
.L5:
	mov	rax, QWORD PTR -112[rbp]	# // 
	add	rax, 16						# ||
	mov	rax, QWORD PTR [rax]		# |\ rax = argv[2]
	lea	rsi, .LC3[rip]				# |/ 
	mov	rdi, rax					# |\ rdi = "-random"
	call	strcmp@PLT				# |eax = strcmp(argv[2], "-random")
	test	eax, eax				# |/ eax == 0?
	jne	.L8							# \\ if not, goto L8

	cmp	DWORD PTR -100[rbp], 4	# if (argc < 5)
	jg	.L9						# if so goto L9             
	mov	rax, QWORD PTR -112[rbp]	# /
	mov	rax, QWORD PTR [rax]		# |
	mov	rsi, rax					# \ rsi = argv[0]
	lea	rdi, .LC4[rip]				# rsi = "Usage: %s <substr> -random <seed> <from 0 to 300.000 string_size>\n
	mov	eax, 0						#
	call	printf@PLT				# printf("Usage: %s <substr> -random <seed> <from 0 to 300.000 string_size>\n", argv[0])

	mov	eax, 1	# /
	jmp	.L7		# \ return 1
.L9:      
	mov	rax, QWORD PTR -112[rbp]	# //
	add	rax, 32						# ||
	mov	rax, QWORD PTR [rax]		# ||
	mov	rdi, rax					# |\ rdi = argv[4]
	call	atoi@PLT				# |
	mov	DWORD PTR -56[rbp], eax		# \ string_size_to_generate = atoi(argv[4])

	mov	rax, QWORD PTR -112[rbp]	# //
	add	rax, 24						# ||
	mov	rax, QWORD PTR [rax]		# ||
	mov	rdi, rax					# |\ rdi = argv[3]
	call	atoi@PLT				# |
	mov	DWORD PTR -52[rbp], eax		# \ rand_seed = atoi(argv[3])
#             	
	mov	eax, DWORD PTR -56[rbp]	# //
	cdqe						# ||
	mov	rdi, rax				# |\rdi = string_size_to_generate
	call	malloc@PLT			# |
	mov	QWORD PTR -16[rbp], rax	# \ str_to_search_in = (char *) malloc(string_size_to_generate * sizeof(char))

	mov	rax, QWORD PTR -112[rbp]		# //
	add	rax, 8							# ||
	mov	rax, QWORD PTR [rax]			# |\ rax = argv[1]
	mov	ecx, DWORD PTR -52[rbp]			# | ecx = rand_seed
	mov	edx, DWORD PTR -56[rbp]			# |	edx = string_size_to_generate
	mov	rsi, QWORD PTR -16[rbp]			# | rsi = str_to_search_in
	mov	rdi, rax						# | rdi = rax
	call	generate_random_string@PLT	# \ generate_random_string(argv[1], str_to_search_in, string_size_to_generate, rand_seed)#

	mov	rax, QWORD PTR -16[rbp]	# //
	mov	rdi, rax				# |\ rdi = str_to_search_in
	call	puts@PLT			# \ puts(str_to_search_in)

	mov	DWORD PTR -4[rbp], 2	# < input_mode = 2
	jmp	.L4	
.L8:
	mov	rax, QWORD PTR -112[rbp]	# // 
	add	rax, 16						# || 
	mov	rax, QWORD PTR [rax]		# |\ rax = argv[2]
	lea	rsi, .LC5[rip]				# | "-test"
	mov	rdi, rax					# |
	call	strcmp@PLT				# \

	test	eax, eax				# / (strcmp(argv[2], "-test") == 0)
	jne	.L10						# \ if not, gp tp L10

	cmp	DWORD PTR -100[rbp], 3	# / if (argc > 3),
	jg	.L11					# \ gotot L11
              
	mov	rax, QWORD PTR -112[rbp]	# //
	mov	rax, QWORD PTR [rax]		# ||
	mov	rsi, rax					# |\ rsi = argv[0]
	lea	rdi, .LC6[rip]				# | "Usage: %s <substr> -test <seed>\n"
	mov	eax, 0						# |
	call	printf@PLT				# \ printf("Usage: %s <substr> -test <seed>\n", argv[0])

	mov	eax, 1	# / return 1
	jmp	.L7		# \
.L11:          
	mov	rax, QWORD PTR -112[rbp]		# //
	add	rax, 24							# ||
	mov	rax, QWORD PTR [rax]			# ||
	mov	rdi, rax						# |\ rdi = argv[3]
	call	atoi@PLT					# |
	mov	DWORD PTR -52[rbp], eax			# \ rand_seed = atoi(argv[3])

	mov	edi, 300000						# /
	call	malloc@PLT					# |
	mov	QWORD PTR -16[rbp], rax			# \ str_to_search_in = (char *) malloc(MAX_SIZE * sizeof(char))#
#             
	mov	rax, QWORD PTR -112[rbp]		# //
	add	rax, 8							# ||
	mov	rax, QWORD PTR [rax]			# |\ rax = argv[1]
	mov	edx, DWORD PTR -52[rbp]			# | rand_seed
	mov	rsi, QWORD PTR -16[rbp]			# | rsi = str_to_search_in
	mov	ecx, edx						# |
	mov	edx, 30000						# | 
	mov	rdi, rax						# |
	call	generate_random_string@PLT	# \ generate_random_string(argv[1], str_to_search_in, 30000, rand_seed)
	mov	DWORD PTR -4[rbp], 3	# input_mode = 3
	jmp	.L4	
.L10:
	mov	rax, QWORD PTR -112[rbp] # / / argv
	add	rax, 8					 # | | argv[1]
	mov	rax, QWORD PTR [rax]	 # | | 
	mov	rsi, rax				 # | \ rsi = argv[1]
	lea	rdi, .LC7[rip]			 # | rdi = "Unknown argument or in wrong position: %s\n"
	mov	eax, 0					 # | 
	call	printf@PLT			 # \ printf("Unknown argument or in wrong position: %s\n", argv[1])#

	mov	eax, 1	# / return 1
	jmp	.L7		# \
.L4:
	mov	QWORD PTR -40[rbp], 0	# <  output_file = NULL

#   if (input_mode == 1 && argc == 5)
	cmp	DWORD PTR -4[rbp], 1	# input_mode ?? 1
	jne	.L12					# if not, goto to L12
	cmp	DWORD PTR -100[rbp], 5	# argc ?? 5,
	jne	.L12					# if not, goto to L12
       
	mov	rax, QWORD PTR -112[rbp]	# / argv
	mov	rax, QWORD PTR 32[rax]		# |/
	mov	QWORD PTR -64[rbp], rax		# \\ file_path = &argv[4]

	mov	rax, QWORD PTR -64[rbp]	# / file_path
	lea	rsi, .LC8[rip]			# | rsi = "w"
	mov	rdi, rax				# | rdi = file_path
	call	fopen@PLT			# |
	mov	QWORD PTR -40[rbp], rax	# \ output_file = fopen(file_path, "w")
.L12:
	mov	DWORD PTR -8[rbp], 0	# < clocks_elapsed = 0

	cmp	DWORD PTR -4[rbp], 3	# / input_mode ==? 3,
	jne	.L13					# | < if not, goto to L13
	mov	eax, 4000				# | eax = 4000
	jmp	.L14					# \ < goto to L14
.L13:

	mov	eax, 1					# < eax = 1,
.L14:
	mov	DWORD PTR -68[rbp], eax	# < passes = eax

	mov	DWORD PTR -20[rbp], 0	# < i = 0
	jmp	.L15					# < goto for (i = 0; i < passes; i++)
.L21:
	call	clock@PLT			# /
	mov	QWORD PTR -80[rbp], rax	# \ tart_time = clock()

	mov	rdx, QWORD PTR -48[rbp]	# / 
	mov	rax, QWORD PTR -16[rbp]	# | 
	mov	rsi, rdx				# | str_to_find
	mov	rdi, rax				# | str_to_search_in
	call	my_strstr@PLT		# |
	mov	QWORD PTR -32[rbp], rax	# \found_substr_start = my_strstr(str_to_search_in, str_to_find)

	call	clock@PLT			# /
	mov	QWORD PTR -88[rbp], rax	# \ end_time = clock()

	mov	rax, QWORD PTR -88[rbp]	# // edx = end_time
	mov	edx, eax				# |\ 
	mov	rax, QWORD PTR -80[rbp]	# |/
	sub	edx, eax				# |\ edx -= start_time 
	mov	eax, DWORD PTR -8[rbp]	# |/ clocks_elapsed += edx
	add	eax, edx				# || 
	mov	DWORD PTR -8[rbp], eax	# \\

	jmp	.L16	# < while (found_substr_start != NULL)
.L20:
# if (input_mode == 0 || input_mode == 2 || input_mode == 1 && argc == 4) 
	cmp	DWORD PTR -4[rbp], 0	# input_mode == 0
	je	.L17					# if so, goto .L17

	cmp	DWORD PTR -4[rbp], 2	# input_mode == 2
	je	.L17					# if so, goto .L17

	cmp	DWORD PTR -4[rbp], 1	# input_mode == 4
	jne	.L18					# if not, goto L18

	cmp	DWORD PTR -100[rbp], 4	# argc == 4
	jne	.L18					# if not, goto L18
.L17:             
	mov	rax, QWORD PTR -32[rbp]	# // found_substr_start
	sub	rax, QWORD PTR -16[rbp]	# || rsi = found_substr_start - str_to_search_in
	mov	rsi, rax				# |\
	lea	rdi, .LC9[rip]			# | rdi = "%ld 
	mov	eax, 0					# | 
	call	printf@PLT			# \printf("%ld ", found_substr_start - str_to_search_in)

	jmp	.L19			# goto _L19
.L18:
	cmp	DWORD PTR -4[rbp], 1	# / if (input_mode == 1)
	jne	.L19					# \ if not, go to L19

	mov	rax, QWORD PTR -32[rbp]	# //
	sub	rax, QWORD PTR -16[rbp]	# || rax = str_to_search_in - found_substr_start
	mov	rdx, rax				# |\ rdx
	mov	rax, QWORD PTR -40[rbp]	# | output_file
	lea	rsi, .LC9[rip]			# | rsi = "%ld "
	mov	rdi, rax				# |	rdi = output_file 
	mov	eax, 0					# |	eax = 0
	call	fprintf@PLT			# \ fprintf(output_file, "%ld ", found_substr_start - str_to_search_in)
.L19:
	call	clock@PLT			# /
	mov	QWORD PTR -80[rbp], rax	# \ start_time = clock()

	mov	rax, QWORD PTR -32[rbp]	# //
	lea	rdx, 1[rax]				# |\ rdx = found_substr_start + 1
	mov	rax, QWORD PTR -48[rbp]	# |/
	mov	rsi, rax				# |\ str_to_find
	mov	rdi, rdx				# | found_substr_start + 1
	call	my_strstr@PLT		# | 
	mov	QWORD PTR -32[rbp], rax	# \ found_substr_start = my_strstr(found_substr_start + 1, str_to_find)

	call	clock@PLT			# /
	mov	QWORD PTR -88[rbp], rax	# \end_time = clock()

	mov	rax, QWORD PTR -88[rbp]	# //edx = end_time
	mov	edx, eax				# |\
	mov	rax, QWORD PTR -80[rbp]	# |/ start_time
	sub	edx, eax				# |\ end_time - start_time
	mov	eax, DWORD PTR -8[rbp]	# | eax = clocks_elapsed
	add	eax, edx				# | eax = clocks_elapsed + (end_time - start_time)
	mov	DWORD PTR -8[rbp], eax	# \ clocks_elapsed = eax
.L16:
	cmp	QWORD PTR -32[rbp], 0	# / while (found_substr_start != NULL)
	jne	.L20					# \ goto L20

	add	DWORD PTR -20[rbp], 1	# < i++
.L15:
	mov	eax, DWORD PTR -20[rbp]	# / i
	cmp	eax, DWORD PTR -68[rbp]	# | i < passes
	jl	.L21					# \ if so, go to L21

	cmp	QWORD PTR -40[rbp], 0	# / output_file != NULL
	je	.L22					# \ if not, skip

	mov	rax, QWORD PTR -40[rbp]	# / output_file
	mov	rdi, rax				# |
	call	fclose@PLT			# \ fclose(output_file)
.L22:
	cmp	DWORD PTR -4[rbp], 1	# / input_mode ==? 1,
	jne	.L23					# | if not, go to L23
	cmp	DWORD PTR -100[rbp], 5	# | argc ==? 5,
	je	.L24					# \ if so, go to L24

.L23:
	mov	edi, 10			# /
	call	putchar@PLT	# \ printf("\n")
.L24:
	mov	rax, QWORD PTR -16[rbp]	# //
	mov	rdi, rax				# |\ rdi = str_to_search_in
	call	free@PLT			# \ free(str_to_search_in)

	mov	eax, DWORD PTR -8[rbp]	# / clocks_elapsed
	cdqe						# |
	mov	rsi, rax				# |
	lea	rdi, .LC10[rip]			# | format
	mov	eax, 0					# | 
	call	printf@PLT			# \	printf("Time elapsed: %ld microseconds\n", clocks_elapsed * 1000000 / CLOCKS_PER_SEC)

	mov	eax, 0	# < return 0
.L7:
	leave	
	ret	
