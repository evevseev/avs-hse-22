section .data
	helloText: db "Hello, World!", 10
	helloTextLen equ $-helloText
section .text
	global _start ; точка входа
	
_start: 
	mov rax,1 ; system write
	mov rdi,1 ; пишем в stdout 
	mov rsi,helloText ; сообщение
	mov rdx,helloTextLen ; его длинна
	syscall ; вызываем
		

	mov rax,60 ; system exit
	mov rdi,0 ; с кодом успеха 0
	syscall ; вызываем
	
