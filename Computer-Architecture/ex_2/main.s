.data
    # int32_t m=150; # prueba 1
    #m: .long    150
    # int32_t m=50;  # prueba 2
    m: .long    50
    fmt1: .asciz "a[4] = %d\n"
    fmt2: .asciz "arr[3] = %d\n"
    fmt3: .asciz "arr[4] = %d\n"

.text
.global main
main:
	pushq   %rbp
	movq    %rsp,%rbp
	subq	$48, %rsp

	movl	$5, -4(%rbp)	# size
	movl	$0, -12(%rbp)	# *arr
	movl	$1, -16(%rbp)	# i
	movl	$3, -20(%rbp)	# j

	# Initiate the local array
	movl	$90, -24(%rbp)	# a[4]
	movl	$80, -28(%rbp)	# a[3]
	movl	$70, -32(%rbp)	# a[2]
	movl	$60, -36(%rbp)	# a[1]
	movl	$50, -40(%rbp)	# a[0]

	# arr = (int32_t *)malloc(size * sizeof(int32_t))
	movl	-4(%rbp), %edi
	sall	$2, %edi
	call	malloc
	movq	%rax, -12(%rbp)
	
	# Initiate the dynamic array
	movq	-12(%rbp), %rax
	movl	$55, (%rax)
	movl	$45, 4(%rax)
	movl	$35, 8(%rax)
	movl	$25, 12(%rax)
	movl	$15, 16(%rax)
	
	# arr[j-1]
	movslq	-20(%rbp), %rax	# %eax <-- (j)
	decq	%rax
	movq	-12(%rbp), %rdx	# %rdx <-- *arr
	movl	(%rdx, %rax, 4), %ecx # %rcx <-- (arr[j-1])
	
	# a[i+j]
	movl	-20(%rbp), %eax
	addl	-16(%rbp), %eax
	movslq	%eax, %rax
	movl	-40(%rbp, %rax, 4), %edx 

	# arr[j-1]+a[i+j]
	addl %edx, %ecx

	# a[4] = ((arr[j-1]+a[i+j])/4)+m
	sarl	$2, %ecx
	addl	m(%rip), %ecx
	movl	%ecx, -24(%rbp)

	# printf("a[4] = %d\n", a[4])
	leaq	fmt1(%rip), %rdi
	movl	-24(%rbp), %esi
	xorl	%eax, %eax
	call	printf


	# arr[i]
	movslq	-16(%rbp), %rax
	movq	-12(%rbp), %rcx
	movl	(%rcx, %rax, 4), %eax	# %eax <-- (arr[i])

	# (arr[i]+a[4])*32
	movl	-24(%rbp), %ecx
	addl	%ecx, %eax
	sall	$5, %eax

	# arr[j] = ((arr[i]+a[4])*32)-m
	subl	m(%rip), %eax
	movslq	-20(%rbp), %rcx
	movslq	-12(%rbp), %rdx
	movl	%eax, (%rdx, %rcx, 4)

	# printf("arr[3] = %d\n",arr[3]);
	leaq	fmt2(%rip), %rdi
	movl	%eax, %esi
	xorl	%eax, %eax
	call	printf

	# if(m<100){
	cmpl	$100, m(%rip)
	jge	else
	# a[4]*21
	movl	-24(%rbp), %eax
	imul	$21, %eax
	# arr[j+1] = a[4]*21
	movslq	-20(%rbp), %rcx
	incq	%rcx
	movq	-12(%rbp), %rdx
	movl	%eax, (%rdx, %rcx, 4)
	jmp	endif
	#} else {
	else:
		movq	-12(%rbp), %rax
		movl	12(%rax), %eax
		cltd
		movl	$5, %ecx
		idivl	%ecx
		movslq	-20(%rbp), %rcx
		incq	%rcx
		movq	-12(%rbp), %rdx
		movl	%eax, (%rdx, %rcx, 4)
	#}
	endif:
		leaq	fmt3(%rip), %rdi
		movl	%eax, %esi
		xorl	%eax, %eax
		call	printf


	# free(arr);
	movq	-12(%rbp), %rdi
	call	free

	addq	$48, %rsp
	popq    %rbp
	movl    $0, %eax           # return 0
	ret
