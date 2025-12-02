.data 
	fmt: .asciz "Mayor %d\n"
.text 
.global main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	
	# Case #1
	# int32_t a=1, b=2;
	#movl	$1, -4(%rbp)	# a
	#movl	$2, -8(%rbp)	# b

	# Case #2
	# int32_t a=1, b=2;
	movl	$9, -4(%rbp)
	movl 	$4, -8(%rbp)


	movl	-4(%rbp), %edi
	movl	-8(%rbp), %esi
	call	max
	
	leaq	fmt(%rip), %rdi
	movl	%eax, %esi
	xorl	%eax, %eax
	call	printf

	addq	$16, %rsp
	popq	%rbp
	xorl	%eax, %eax
	ret

max: 
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	%edi, -16(%rbp)
	movl	%esi, -12(%rbp)

	movl	$0, -4(%rbp)

	movl	-16(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jle	else
	movl	%eax, -4(%rbp)
	jmp	endif
	else:
		movl -12(%rbp), %ecx
		movl %ecx, -4(%rbp)
	endif:
		movl -4(%rbp), %eax

	addq	$16, %rsp
	popq	%rbp
	ret



