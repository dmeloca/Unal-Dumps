.data
	fmt: .asciz "result: %d\n"

.text
.global main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	
	# int32_t a=1, b=2, c;
	movl	$1, -4(%rbp)
	movl	$2, -8(%rbp)

	movl	-4(%rbp), %edi
	movl	-8(%rbp), %esi
	call	sum
	movl	%eax, %esi

	leaq	fmt(%rip), %rdi
	xorl 	%eax, %eax
	call	printf
	
	addq	$16, %rsp
	popq	%rbp
	movl	$0, %eax
	ret

sum:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp


	movl	%edi, -16(%rbp)
	movl	%esi, -12(%rbp)

	movl	-16(%rbp), %eax
	addl	-12(%rbp), %eax


	addq	$16, %rsp
	popq	%rbp
	ret

