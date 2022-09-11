global _start

section .data
	helloText: db "Hello, World!", 10
	helloTextLen equ $-helloText
section .text	
_start: 
	mov	rax,1
	mov	rdi,1
	mov	rsi,helloText
	mov	rdx,helloTextLen
	syscall
		

	mov	rax,60
	mov	rdi,0
	syscall
	
