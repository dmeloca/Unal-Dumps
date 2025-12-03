.data
	fmt: .asciz "Remainder: %d\n"
	remainder: .long 0
.text
.global main
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movl	$13, -4(%rbp)
	movl	$2, -8(%rbp)

	leaq	-4(%rbp), %rdi
	leaq	-8(%rbp), %rsi
	call	division

	leaq	fmt(%rip), %rdi
	movl	remainder(%rip), %esi
	xorl	%eax, %eax
	call	printf

	addq	$16, %rsp
	popq	%rbp
	xorl	%eax, %eax
	ret

division:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$16, %rsp

	movq	%rdi, -16(%rbp)
	movq	%rsi, -8(%rbp)

	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	cltd
	movq	-8(%rbp), %rcx
	movl	(%rcx), %ecx
	idivl	%ecx
	movl 	%edx, remainder(%rip)

	addq	$16, %rsp
	popq	%rbp
	ret
