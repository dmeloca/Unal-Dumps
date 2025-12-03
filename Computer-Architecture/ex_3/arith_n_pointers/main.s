.data
	fmt: .asciz "Prod: %d, Div: %d\n"

.text
.global main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	$4, -4(%rbp)
	movl	$2, -8(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, -16(%rbp)

	movl	-4(%rbp), %edi
	movl	-8(%rbp), %esi
	leaq	-12(%rbp), %rdx
	leaq	-16(%rbp), %rcx
	call	prod_div

	leaq	fmt(%rip), %rdi
	movl	-12(%rbp), %esi
	movl	-16(%rbp), %edx
	xorl	%eax, %eax
	call	printf

	addq	$16, %rsp
	popq	%rbp
	xorl	%eax, %eax
	ret


prod_div:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp

	movl	%edi, -32(%rbp)
	movl	%esi, -28(%rbp)
	movq	%rdx, -20(%rbp)
	movq	%rcx, -12(%rbp)

	movl	-32(%rbp), %eax
	imull	-28(%rbp), %eax
	movq	-20(%rbp), %rdx
	movl	%eax, (%rdx)

	movl	-32(%rbp), %eax
	cltd
	movl	-28(%rbp), %ecx
	idiv	%ecx
	movq	-12(%rbp), %rcx
	movl	%eax, (%rcx)

	addq	$32, %rsp
	popq	%rbp
	xorl	%eax, %eax
	ret
