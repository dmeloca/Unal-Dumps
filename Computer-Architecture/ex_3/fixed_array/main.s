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
	movl	$4, -16(%rbp)

	movl	-4(%rbp), %edi
	movl	-8(%rbp), %esi
	movl	-12(%rbp), %edx
	movl	-16(%rbp), %ecx
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
	subq	$32, %rsp

	movl	%ecx, -4(%rbp)
	movl	%edx, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edi, -16(%rbp)

	movl	$0, %eax
	movl	$0, %ecx

	startw:
		cmp	$4, %eax
		movslq	%eax, %rdx
		jge	endw
		movl	-16(%rbp, %rdx, 4), %esi
		addl	%esi, %ecx
		incl	%eax
		jmp	startw
	endw:
		movl	%ecx, %eax
	addq	$32, %rsp
	popq	%rbp
	ret

