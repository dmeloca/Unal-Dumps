.data
	fmt: .asciz "Result: %d\n"

.text
.global main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	$2, -4(%rbp)
	movl	$2, -8(%rbp)
	movl	$3, -12(%rbp)
	movl	$4, -16(%rbp)

	leaq	-4(%rbp), %rdi
	leaq	-8(%rbp), %rsi
	leaq	-12(%rbp), %rdx
	leaq	-16(%rbp), %rcx
	call	caller

	leaq	fmt(%rip), %rdi
	movl	%eax, %esi
	xorl	%eax, %eax
	call	printf

	addq	$16, %rsp
	popq	%rbp
	xorl	%eax, %eax
	ret

caller:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movq	%rdi, -32(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -16(%rbp)
	movq	%rcx, -8(%rbp)

	movq	-32(%rbp), %rax
	movl	(%rax), %edi
	movq	-24(%rbp), %rax
	movl	(%rax), %esi
	movq	-16(%rbp), %rax
	movl	(%rax), %edx
	call	foo
	movq	-8(%rbp), %rdx
	movl	(%rdx), %edx
	subl	%edx, %eax

	addq	$32, %rsp
	popq	%rbp
	ret

foo:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movl	%edi, -32(%rbp)
	movl	%esi, -24(%rbp)
	movl	%edx, -16(%rbp)

	movl	-32(%rbp), %eax
	imull	-24(%rbp), %eax
	addl	-16(%rbp), %eax

	addq	$32, %rsp
	popq	%rbp
	ret
