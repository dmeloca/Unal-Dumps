.data
	fmt: .asciz "Result: %d\n"

.text
.global main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	$5, -4(%rbp)
	movl	$4, -8(%rbp)
	movl	$3, -12(%rbp)
	movl	$2, -16(%rbp)

	leaq	-16(%rbp), %rdi
	call	sum_arr

	leaq	fmt(%rip), %rdi
	movl	%eax, %esi
	xorl	%eax, %eax
	call	printf

	addq	$16, %rsp
	popq	%rbp
	xorl	%eax, %eax
	ret


sum_arr:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	$0, -4(%rbp)
	movl	$0, -8(%rbp)

	movq	%rdi, -16(%rbp)

	movslq	-4(%rbp), %rcx
	movl	-8(%rbp), %eax
	movq	-16(%rbp), %rdx
	startw:
		cmpq	$4, %rcx
		jge	endw
		movl	(%rdx, %rcx, 4), %edi
		addl	%edi, %eax
		incq	%rcx
		jmp startw
	endw:
		nop

	addq	$16, %rsp
	popq	%rbp
	ret
