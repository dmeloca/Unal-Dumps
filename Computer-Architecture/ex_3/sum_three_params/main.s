.data
	fmt: .asciz "Result: %d\n"

.text
.global main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	$1, -4(%rbp)
	movl	$2, -8(%rbp)
	movl	$3, -12(%rbp)

	movl	-4(%rbp), %edi
	movl	-8(%rbp), %esi
	movl	-12(%rbp), %edx
	call	sum 

	leaq	fmt(%rip), %rdi
	movl	%eax, %esi
	xorl	%eax, %eax
	call	printf

	addq	$16, %rsp
	popq	%rbp
	xorl	%eax, %eax
	ret


sum:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp
	
	movl	%edi, -16(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -8(%rbp)

	movl	-16(%rbp), %eax
	addl	-12(%rbp), %eax
	addl 	-8(%rbp), %eax


	addq	$16, %rsp
	popq	%rbp
	ret
