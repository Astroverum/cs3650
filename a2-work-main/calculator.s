# A terminal calculator
#
# Reads a line of input, interprets it as a simple arithmetic expression,
# and prints the result. The input format is
# <long_integer> <operation> <long_integer>

# Make `main` accessible outside of this module
.global main

# Start of the code section
.text

main:
  # Function prologue
  enter $0, $0

  # Use scanf to retrieve and process a line of input
  # This block implements the following line of C code: 
  #   scanf("%ld %c %ld", &a, &op, &b);
  # Take a look at the man page for scanf and ask questions. You can also look 
  # at scanf_example.c
  movq $scanf_fmt, %rdi
  movq $a, %rsi
  movq $op, %rdx
  movq $b, %rcx
  xorb %al, %al
  call scanf

  movb op, %r12b # load the operation for comparisons
  movq a, %r13  # and the LHS

  # Analyze operation and execute

  # if (op == '+')
  cmp $'+', %r12b
  je addition

  # if (op == '-')
  cmp $'-', %r12b
  je subtraction

  # if (op == '*')
  cmp $'*', %r12b
  je multiplication

  # if (op == '/')
  cmp $'/', %r12b
  je division

  # else
  jmp print_error

addition:
  # a + b
  addq b, %r13
  jmp print_result

subtraction:
  # a - b
  subq b, %r13
  jmp print_result

multiplication:
  # a * b
  imulq b, %r13
  jmp print_result

division:
  # check if b = 0
  cmpq $0, b
  je print_div_error

  # a / b
  movq a, %rax # move a to %rax as divisor
  idivq b
  movq %rax, %r13  # move quotient from %rax to %r13
  jmp print_result

print_result:
  # Print result
  movq $output_fmt, %rdi
  movq %r13, %rsi # set result as printf argument
  mov $0, %al
  call printf

  mov $0, %rax # set exit code to 0
  jmp done

# Print error if operation cannot be (safely) performed
print_error:
  movq $error_fmt, %rdi
  mov $0, %al
  call printf

  mov $1, %rax # set exit code to 1
  jmp done

print_div_error:
  movq $zero_division_error_fmt, %rdi
  mov $0, %al
  call printf

  mov $1, %rax # set exit code to 1
  jmp done

# Function epilogue
done:
  leave
  ret

# Start of the data section
.data

output_fmt: 
  .asciz "%ld\n"
scanf_fmt: 
  .asciz "%ld %c %ld"  # modify as needed
error_fmt:
  .asciz "Unknown operation\n"
zero_division_error_fmt:
  .asciz "Error: Division by Zero\n"

# "Slots" for scanf
a:  .quad 0
b:  .quad 0
op: .byte 0

