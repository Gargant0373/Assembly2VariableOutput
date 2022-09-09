.text

welcome: .asciz "--== Tutorial on how to output with 2 variables ==--"
prompt_first: .asciz "Enter the first number.\n"
prompt_second: .asciz "Enter the second number.\n"
output: .asciz "First number is %ld and second number is %ld\n"
first: .asciz "%ld"
second: .asciz "%ld"

.global main     # making the main function visible

main: 
	# prologue
	push %rbp
	mov %rsp, %rbp

	call read # calling main function
		
	# epilogue
	movq %rbp, %rsp
	popq %rbp

end:
	movq $0, %rdi
	call exit
	

read:
	# prologue
	push %rbp
	mov %rsp, %rbp
	
	# showing base prompt
	movq $0, %rax
	movq $prompt_first, %rdi
	call printf

	subq $16, %rsp # allocating space for input
	
	movq $0, %rax
	movq $first, %rdi
	leaq -16(%rbp), %rsi
	call scanf
		
	# showing power prompt
	movq $0, %rax
	movq $prompt_second, %rdi
	call printf
	
	movq $0, %rax
	movq $second, %rdi
	leaq -8(%rbp), %rsi
	call scanf

	movq -16(%rbp), %rsi
	movq -8(%rbp), %rdx
	movq $0, %rax
	movq $output, %rdi
	call printf

	movq %rbp, %rsp
	popq %rbp
	ret
