.intel_syntax noprefix
	
.section	.rodata
.LC0:
	.string	"max = %llu! = %llu\n"

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
	mov	rax, QWORD PTR -8[rbp]  # rax = res
	imul	rax, QWORD PTR -16[rbp] # res *= a
	mov	QWORD PTR -8[rbp], rax  # res = rax;
	sub	QWORD PTR -16[rbp], 1   # a--;
.L2:
	cmp	QWORD PTR -16[rbp], 1	# a ? 1
	ja	.WHILE			# while(a > 1)
	mov	rax, QWORD PTR -8[rbp]	# rax = res
	
	leave
	ret

.text
.globl	main
.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], 2	# a = 2;
	mov	QWORD PTR -16[rbp], 10	# k = 10;
	mov	QWORD PTR -8[rbp], 1	# b = 1;
	
.mainWHILE:
	mov	rax, QWORD PTR -24[rbp]
	mov	QWORD PTR -8[rbp], rax	# b = a;
	mov	rdi, QWORD PTR -16[rbp] # fact(k)
	call	fact
	
	mov	QWORD PTR -24[rbp], rax # a = fact(k);
	add	QWORD PTR -16[rbp], 1 	# k++;
	mov	rax, QWORD PTR -24[rbp] 
	cmp	rax, QWORD PTR -8[rbp]	a ? b
	ja	.mainWHILE		# while(a > b)
	
	mov	rax, QWORD PTR -16[rbp]
	sub	rax, 1			# k--;
	
	mov	rsi, rax
	mov 	rdx, QWORD PTR -8[rbp]  # b
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	
	xor	eax, eax
	leave
	ret
