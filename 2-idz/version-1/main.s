	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"String to find was not provided"rand
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
	mov	DWORD PTR -100[rbp], edi	; argc
	mov	QWORD PTR -112[rbp], rsi	; argv
; if (argc < 2) {
	cmp	DWORD PTR -100[rbp], 1	; argc
	jg	.L2	
; printf("String to find was not provided\n");
	lea	rdi, .LC0[rip]
	call	puts@PLT
;         exit(1)
	mov	edi, 1
	call	exit@PLT

.L2:
;     str_to_find = argv[1];
	mov	rax, QWORD PTR -112[rbp]; tmp124, argv
	mov	rax, QWORD PTR 8[rax]	; tmp125, MEM[(char * *)argv_59(D) + 8B]
	mov	QWORD PTR -48[rbp], rax	; str_to_find, tmp125
;     if (argc == 2) {
	cmp	DWORD PTR -100[rbp], 2	; argc
	jne	.L3

	mov	edi, 300000							; /
	call	read_string_from_console@PLT	; |
	mov	QWORD PTR -16[rbp], rax				; \ str_to_search_in = read_string_from_console(MAX_SIZE);

	mov	DWORD PTR -4[rbp], 0				; < input_mode = 0;
	jmp	.L4	;
.L3:
;         if (strcmp(argv[2], "-file") == 0) {
	mov	rax, QWORD PTR -112[rbp]	; tmp127, argv
	add	rax, 16	; _1,
;         if (strcmp(argv[2], "-file") == 0) {
	mov	rax, QWORD PTR [rax]	; _2, *_1
	lea	rsi, .LC1[rip]	;,
	mov	rdi, rax	;, _2
	call	strcmp@PLT	;
;         if (strcmp(argv[2], "-file") == 0) {
	test	eax, eax	; _3
	jne	.L5	;,
;             if (argc < 4) {
	cmp	DWORD PTR -100[rbp], 3	; argc,
	jg	.L6	;,
;                 printf("Usage: %s <substr> -file <input_file_path> [output_file_path]\n", argv[0]);
	mov	rax, QWORD PTR -112[rbp]	; tmp128, argv
	mov	rax, QWORD PTR [rax]	; _4, *argv_59(D)
	mov	rsi, rax	;, _4
	lea	rdi, .LC2[rip]	;,
	mov	eax, 0	;,
	call	printf@PLT	;
;                 return 1;
	mov	eax, 1	; _47,
	jmp	.L7	;
.L6:
;             file_path = argv[3];
	mov	rax, QWORD PTR -112[rbp]	; tmp129, argv
	mov	rax, QWORD PTR 24[rax]	; tmp130, MEM[(char * *)argv_59(D) + 24B]
	mov	QWORD PTR -64[rbp], rax	; file_path, tmp130
;             str_to_search_in = read_string_from_file(file_path, MAX_SIZE);
	mov	rax, QWORD PTR -64[rbp]	; tmp131, file_path
	mov	esi, 300000	;,
	mov	rdi, rax	;, tmp131
	call	read_string_from_file@PLT	;
	mov	QWORD PTR -16[rbp], rax	; str_to_search_in, tmp132
;             input_mode = 1;
	mov	DWORD PTR -4[rbp], 1	; input_mode,
	jmp	.L4	;
.L5:
;         } else if (strcmp(argv[2], "-random") == 0) {
	mov	rax, QWORD PTR -112[rbp]	; tmp133, argv
	add	rax, 16	; _5,
;         } else if (strcmp(argv[2], "-random") == 0) {
	mov	rax, QWORD PTR [rax]	; _6, *_5
	lea	rsi, .LC3[rip]	;,
	mov	rdi, rax	;, _6
	call	strcmp@PLT	;
;         } else if (strcmp(argv[2], "-random") == 0) {
	test	eax, eax	; _7
	jne	.L8	;,
;             if (argc < 5) {
	cmp	DWORD PTR -100[rbp], 4	; argc,
	jg	.L9	;,
;                 printf("Usage: %s <substr> -random <seed> <from 0 to 300.000 string_size>\n", argv[0]);
	mov	rax, QWORD PTR -112[rbp]	; tmp134, argv
	mov	rax, QWORD PTR [rax]	; _8, *argv_59(D)
	mov	rsi, rax	;, _8
	lea	rdi, .LC4[rip]	;,
	mov	eax, 0	;,
	call	printf@PLT	;
;                 return 1;
	mov	eax, 1	; _47,
	jmp	.L7	;
.L9:
;             string_size_to_generate = atoi(argv[4]);
	mov	rax, QWORD PTR -112[rbp]	; tmp135, argv
	add	rax, 32	; _9,
;             string_size_to_generate = atoi(argv[4]);
	mov	rax, QWORD PTR [rax]	; _10, *_9
	mov	rdi, rax	;, _10
	call	atoi@PLT	;
	mov	DWORD PTR -56[rbp], eax	; string_size_to_generate, tmp136
;             rand_seed = atoi(argv[3]);
	mov	rax, QWORD PTR -112[rbp]	; tmp137, argv
	add	rax, 24	; _11,
;             rand_seed = atoi(argv[3]);
	mov	rax, QWORD PTR [rax]	; _12, *_11
	mov	rdi, rax	;, _12
	call	atoi@PLT	;
	mov	DWORD PTR -52[rbp], eax	; rand_seed, tmp138
;             str_to_search_in = (char *) malloc(string_size_to_generate * sizeof(char));
	mov	eax, DWORD PTR -56[rbp]	; tmp139, string_size_to_generate
	cdqe
	mov	rdi, rax	;, _13
	call	malloc@PLT	;
	mov	QWORD PTR -16[rbp], rax	; str_to_search_in, tmp140
;             generate_random_string(argv[1], str_to_search_in, string_size_to_generate, rand_seed);
	mov	rax, QWORD PTR -112[rbp]	; tmp141, argv
	add	rax, 8	; _14,
;             generate_random_string(argv[1], str_to_search_in, string_size_to_generate, rand_seed);
	mov	rax, QWORD PTR [rax]	; _15, *_14
	mov	ecx, DWORD PTR -52[rbp]	; tmp142, rand_seed
	mov	edx, DWORD PTR -56[rbp]	; tmp143, string_size_to_generate
	mov	rsi, QWORD PTR -16[rbp]	; tmp144, str_to_search_in
	mov	rdi, rax	;, _15
	call	generate_random_string@PLT	;
;             printf("%s\n", str_to_search_in);
	mov	rax, QWORD PTR -16[rbp]	; tmp145, str_to_search_in
	mov	rdi, rax	;, tmp145
	call	puts@PLT	;
;             input_mode = 2;
	mov	DWORD PTR -4[rbp], 2	; input_mode,
	jmp	.L4	;
.L8:
;         } else if (strcmp(argv[2], "-test") == 0) {
	mov	rax, QWORD PTR -112[rbp]	; tmp146, argv
	add	rax, 16	; _16,
;         } else if (strcmp(argv[2], "-test") == 0) {
	mov	rax, QWORD PTR [rax]	; _17, *_16
	lea	rsi, .LC5[rip]	;,
	mov	rdi, rax	;, _17
	call	strcmp@PLT	;
;         } else if (strcmp(argv[2], "-test") == 0) {
	test	eax, eax	; _18
	jne	.L10	;,
;             if (argc < 4) {
	cmp	DWORD PTR -100[rbp], 3	; argc,
	jg	.L11	;,
;                 printf("Usage: %s <substr> -test <seed>\n", argv[0]);
	mov	rax, QWORD PTR -112[rbp]	; tmp147, argv
	mov	rax, QWORD PTR [rax]	; _19, *argv_59(D)
	mov	rsi, rax	;, _19
	lea	rdi, .LC6[rip]	;,
	mov	eax, 0	;,
	call	printf@PLT	;
;                 return 1;
	mov	eax, 1	; _47,
	jmp	.L7	;
.L11:
;             rand_seed = atoi(argv[3]);
	mov	rax, QWORD PTR -112[rbp]	; tmp148, argv
	add	rax, 24	; _20,
;             rand_seed = atoi(argv[3]);
	mov	rax, QWORD PTR [rax]	; _21, *_20
	mov	rdi, rax	;, _21
	call	atoi@PLT	;
	mov	DWORD PTR -52[rbp], eax	; rand_seed, tmp149
;             str_to_search_in = (char *) malloc(MAX_SIZE * sizeof(char));
	mov	edi, 300000	;,
	call	malloc@PLT	;
	mov	QWORD PTR -16[rbp], rax	; str_to_search_in, tmp150
;             generate_random_string(argv[1], str_to_search_in, 30000, rand_seed);
	mov	rax, QWORD PTR -112[rbp]	; tmp151, argv
	add	rax, 8	; _22,
;             generate_random_string(argv[1], str_to_search_in, 30000, rand_seed);
	mov	rax, QWORD PTR [rax]	; _23, *_22
	mov	edx, DWORD PTR -52[rbp]	; tmp152, rand_seed
	mov	rsi, QWORD PTR -16[rbp]	; tmp153, str_to_search_in
	mov	ecx, edx	;, tmp152
	mov	edx, 30000	;,
	mov	rdi, rax	;, _23
	call	generate_random_string@PLT	;
;             input_mode = 3;
	mov	DWORD PTR -4[rbp], 3	; input_mode,
	jmp	.L4	;
.L10:
;             printf("Unknown argument or in wrong position: %s\n", argv[1]);
	mov	rax, QWORD PTR -112[rbp]	; tmp154, argv
	add	rax, 8	; _24,
;             printf("Unknown argument or in wrong position: %s\n", argv[1]);
	mov	rax, QWORD PTR [rax]	; _25, *_24
	mov	rsi, rax	;, _25
	lea	rdi, .LC7[rip]	;,
	mov	eax, 0	;,
	call	printf@PLT	;
;             return 1;
	mov	eax, 1	; _47,
	jmp	.L7	;
.L4:
;     output_file = NULL;
	mov	QWORD PTR -40[rbp], 0	; output_file,
;     if (input_mode == 1 && argc == 5) {
	cmp	DWORD PTR -4[rbp], 1	; input_mode,
	jne	.L12	;,
;     if (input_mode == 1 && argc == 5) {
	cmp	DWORD PTR -100[rbp], 5	; argc,
	jne	.L12	;,
;         file_path = argv[4];
	mov	rax, QWORD PTR -112[rbp]	; tmp155, argv
	mov	rax, QWORD PTR 32[rax]	; tmp156, MEM[(char * *)argv_59(D) + 32B]
	mov	QWORD PTR -64[rbp], rax	; file_path, tmp156
;         output_file = fopen(file_path, "w");
	mov	rax, QWORD PTR -64[rbp]	; tmp157, file_path
	lea	rsi, .LC8[rip]	;,
	mov	rdi, rax	;, tmp157
	call	fopen@PLT	;
	mov	QWORD PTR -40[rbp], rax	; output_file, tmp158
.L12:
;     clocks_elapsed = 0;
	mov	DWORD PTR -8[rbp], 0	; clocks_elapsed,
;     passes = input_mode == 3 ? 4000 : 1;
	cmp	DWORD PTR -4[rbp], 3	; input_mode,
	jne	.L13	;,
;     passes = input_mode == 3 ? 4000 : 1;
	mov	eax, 4000	; iftmp.0_48,
	jmp	.L14	;
.L13:
;     passes = input_mode == 3 ? 4000 : 1;
	mov	eax, 1	; iftmp.0_48,
.L14:
;     passes = input_mode == 3 ? 4000 : 1;
	mov	DWORD PTR -68[rbp], eax	; passes, iftmp.0_48
;     for (i = 0; i < passes; i++) {
	mov	DWORD PTR -20[rbp], 0	; i,
;     for (i = 0; i < passes; i++) {
	jmp	.L15	;
.L21:
;         start_time = clock();
	call	clock@PLT	;
	mov	QWORD PTR -80[rbp], rax	; start_time, tmp159
;         found_substr_start = my_strstr(str_to_search_in, str_to_find);
	mov	rdx, QWORD PTR -48[rbp]	; tmp160, str_to_find
	mov	rax, QWORD PTR -16[rbp]	; tmp161, str_to_search_in
	mov	rsi, rdx	;, tmp160
	mov	rdi, rax	;, tmp161
	call	my_strstr@PLT	;
	mov	QWORD PTR -32[rbp], rax	; found_substr_start, tmp162
;         end_time = clock();
	call	clock@PLT	;
	mov	QWORD PTR -88[rbp], rax	; end_time, tmp163
;         clocks_elapsed += (end_time - start_time);
	mov	rax, QWORD PTR -88[rbp]	; tmp164, end_time
	mov	edx, eax	; _26, tmp164
	mov	rax, QWORD PTR -80[rbp]	; tmp165, start_time
	sub	edx, eax	; _28, _27
;         clocks_elapsed += (end_time - start_time);
	mov	eax, DWORD PTR -8[rbp]	; clocks_elapsed.1_29, clocks_elapsed
	add	eax, edx	; _30, _28
	mov	DWORD PTR -8[rbp], eax	; clocks_elapsed, _30
;         while (found_substr_start != NULL) {
	jmp	.L16	;
.L20:
;             if (input_mode == 0 || input_mode == 2 || input_mode == 1 && argc == 4) {
	cmp	DWORD PTR -4[rbp], 0	; input_mode,
	je	.L17	;,
;             if (input_mode == 0 || input_mode == 2 || input_mode == 1 && argc == 4) {
	cmp	DWORD PTR -4[rbp], 2	; input_mode,
	je	.L17	;,
;             if (input_mode == 0 || input_mode == 2 || input_mode == 1 && argc == 4) {
	cmp	DWORD PTR -4[rbp], 1	; input_mode,
	jne	.L18	;,
;             if (input_mode == 0 || input_mode == 2 || input_mode == 1 && argc == 4) {
	cmp	DWORD PTR -100[rbp], 4	; argc,
	jne	.L18	;,
.L17:
;                 printf("%ld ", found_substr_start - str_to_search_in);
	mov	rax, QWORD PTR -32[rbp]	; tmp166, found_substr_start
	sub	rax, QWORD PTR -16[rbp]	; _31, str_to_search_in
	mov	rsi, rax	;, _31
	lea	rdi, .LC9[rip]	;,
	mov	eax, 0	;,
	call	printf@PLT	;
	jmp	.L19	;
.L18:
;             } else if (input_mode == 1) {
	cmp	DWORD PTR -4[rbp], 1	; input_mode,
	jne	.L19	;,
;                 fprintf(output_file, "%ld ", found_substr_start - str_to_search_in);
	mov	rax, QWORD PTR -32[rbp]	; tmp167, found_substr_start
	sub	rax, QWORD PTR -16[rbp]	; tmp167, str_to_search_in
	mov	rdx, rax	; _32, tmp167
	mov	rax, QWORD PTR -40[rbp]	; tmp168, output_file
	lea	rsi, .LC9[rip]	;,
	mov	rdi, rax	;, tmp168
	mov	eax, 0	;,
	call	fprintf@PLT	;
.L19:
;             start_time = clock();
	call	clock@PLT	;
	mov	QWORD PTR -80[rbp], rax	; start_time, tmp169
;             found_substr_start = my_strstr(found_substr_start + 1, str_to_find);
	mov	rax, QWORD PTR -32[rbp]	; tmp170, found_substr_start
	lea	rdx, 1[rax]	; _33,
;             found_substr_start = my_strstr(found_substr_start + 1, str_to_find);
	mov	rax, QWORD PTR -48[rbp]	; tmp171, str_to_find
	mov	rsi, rax	;, tmp171
	mov	rdi, rdx	;, _33
	call	my_strstr@PLT	;
	mov	QWORD PTR -32[rbp], rax	; found_substr_start, tmp172
;             end_time = clock();
	call	clock@PLT	;
	mov	QWORD PTR -88[rbp], rax	; end_time, tmp173
;             clocks_elapsed += (end_time - start_time);
	mov	rax, QWORD PTR -88[rbp]	; tmp174, end_time
	mov	edx, eax	; _34, tmp174
	mov	rax, QWORD PTR -80[rbp]	; tmp175, start_time
	sub	edx, eax	; _36, _35
;             clocks_elapsed += (end_time - start_time);
	mov	eax, DWORD PTR -8[rbp]	; clocks_elapsed.2_37, clocks_elapsed
	add	eax, edx	; _38, _36
	mov	DWORD PTR -8[rbp], eax	; clocks_elapsed, _38
.L16:
;         while (found_substr_start != NULL) {
	cmp	QWORD PTR -32[rbp], 0	; found_substr_start,
	jne	.L20	;,
;     for (i = 0; i < passes; i++) {
	add	DWORD PTR -20[rbp], 1	; i,
.L15:
;     for (i = 0; i < passes; i++) {
	mov	eax, DWORD PTR -20[rbp]	; tmp176, i
	cmp	eax, DWORD PTR -68[rbp]	; tmp176, passes
	jl	.L21	;,
;     if (output_file != NULL) {
	cmp	QWORD PTR -40[rbp], 0	; output_file,
	je	.L22	;,
;         fclose(output_file);
	mov	rax, QWORD PTR -40[rbp]	; tmp177, output_file
	mov	rdi, rax	;, tmp177
	call	fclose@PLT	;
.L22:
;     if (!(input_mode == 1 && argc == 5)) { 
	cmp	DWORD PTR -4[rbp], 1	; input_mode,
	jne	.L23	;,
;     if (!(input_mode == 1 && argc == 5)) { 
	cmp	DWORD PTR -100[rbp], 5	; argc,
	je	.L24	;,
.L23:
;         printf("\n");
	mov	edi, 10	;,
	call	putchar@PLT	;
.L24:
;     free(str_to_search_in);
	mov	rax, QWORD PTR -16[rbp]	; tmp178, str_to_search_in
	mov	rdi, rax	;, tmp178
	call	free@PLT	;
;     printf("Time elapsed: %ld microseconds\n", clocks_elapsed * 1000000 / CLOCKS_PER_SEC);
	mov	eax, DWORD PTR -8[rbp]	; tmp179, clocks_elapsed
	cdqe
	mov	rsi, rax	;, _39
	lea	rdi, .LC10[rip]	;,
	mov	eax, 0	;,
	call	printf@PLT	;
;     return 0;
	mov	eax, 0	; _47,
.L7:
; }
	leave	
	ret	
