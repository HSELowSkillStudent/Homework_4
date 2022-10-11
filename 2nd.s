# Опционально. Реализовать вычисление факториала на языке ассемблера в виде подпрограммы, 
# получающей на вход значение аргумента. Вывод результатов должна осуществлять главная функция.

.intel_syntax noprefix

.section	.rodata
.LLU:
	.string	"%llu"
.LLUn:
	.string	"%llu\n"

.text
.globl	fact
.type	fact, @function
fact:
	push	rbp
	mov	rbp, rsp
	sub 	rsp, 16
	
	mov	QWORD PTR -16[rbp], rdi
	mov	QWORD PTR -8[rbp], 1
	jmp	.L2
.WHILE:
	mov	rax, QWORD PTR -8[rbp]   # rax = res
	imul	rax, QWORD PTR -16[rbp]  # res *= a
	mov	QWORD PTR -8[rbp], rax   # res = rax;
	sub	QWORD PTR -16[rbp], 1    # a--;
.L2:
	cmp	QWORD PTR -16[rbp], 1
	ja	.WHILE			 # while(a > 1)
	mov	rax, QWORD PTR -8[rbp]   # rax = res
	
	leave
	ret

.globl	main
.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	
	and 	rsp, ~15
	sub	rsp, 16
	
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rax, -16[rbp]
	mov	rsi, rax
	lea	rax, .LLU[rip]
	mov	rdi, rax
	mov	eax, 0
	call	scanf@PLT
	
	mov	rdi, QWORD PTR -16[rbp]
	call	fact
	
	mov	rsi, rax
	lea	rax, .LLUn[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	
	xor	eax, eax
	leave
	ret
