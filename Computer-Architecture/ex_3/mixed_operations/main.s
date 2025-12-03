.data
	fmt: .asciz "Result: %d\n"

.text
.global main
main:
	pushq	%rbp
	movl	%rsp, %rbp
	subq	$16, %rsp

	movl	$1, -4(%rbp)
	movl	$2, -8(%rbp)
	movl	$3, -12(%rbp)
	movl	$4, -14(%rbp)
	
	movl	-4(%rbp), %edi
	movl	-8(%rbp), %esi
	movl	-12(%rbp), %edx
	movl	-14(%rbp), %ecx
	call	mix

	leaq	fmt(%rip), %rdi
	movl	%eax, %esi
	xorl	%eax, %eax
	call	printf

	addq	$16, %rsp
	popq	%rbp
	xorl	%eax, %eax
	ret

mix:
	pushq	%rbp
	movl	%rsp, %rbp
	subq	$32, %rsp

	movl	%edi, -32(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -24(%rbp)
	movl	%ecx, -20(%rbp)

	movl	-32(%rbp), %eax
	addl	-28(%rbp), %eax
	movl	-24(%rbp), %edx
	addl	-20(%rbp), %edx
	mull	%edx, %eax

	addq	$32, %rsp
	popq	%rbp
	ret
