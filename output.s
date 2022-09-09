.text

welcome: .asciz "--== Tutorial on how to output with 2 variables ==--"
prompt_first: .asciz "Enter the first number.\n"
prompt_second: .asciz "Enter the second number.\n"
output: .asciz "First number is %ld and second number is %ld\n"
first: .asciz "%ld"
second: .asciz "%ld"

.global main               # making the main function visible

main: 
	# prologue
	push %rbp
	mov %rsp, %rbp

	call read          # calling main function
		
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

	subq $16, %rsp       # allocating space for input
	              	     # (highly recommend understanding how a stack works if this
			     # doesn't make sense)
	movq $0, %rax        
	movq $first, %rdi    # moving $first address to rdi
	leaq -16(%rbp), %rsi # loading effective address of -16 from rbp (where we 
			     # started allocating memory) to rsi (argument to store input)
	call scanf
		
	# showing power prompt
	movq $0, %rax
	movq $prompt_second, %rdi
	call printf
	
	movq $0, %rax
	movq $second, %rdi
	leaq -8(%rbp), %rsi  # check code above ^
	call scanf

	movq -16(%rbp), %rsi # copying the first input from the stack to rsi
	movq -8(%rbp), %rdx  # copying the second input from the stack to rdx
			     # (check lab manual by CTRL + Fing Parameters and you'll
			     # find the order of registers for args)
	movq $0, %rax
	movq $output, %rdi
	call printf

	movq %rbp, %rsp
	popq %rbp
	ret
