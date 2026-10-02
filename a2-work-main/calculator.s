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

  # TODO: Analyze operation and execute

  # if (op == '+')
  cmp $'+', %r12b
  je addition

  # if (op == '-')
  cmp $'-', %r12b
  je subtraction

  # if (op == '*')
  cmp $'*', %r12b
  je multiplication

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

print_result:
  # Print result
  movq $output_fmt, %rdi
  movq %r13, %rsi
  mov $0, %al
  call printf
  jmp done

  # TODO: Print error if operation cannot be (safely) performed

  # else if (op_char == '-') {
  #  ...
  # }
  # ...
  # else {
  #   // print error
  #   // return 1 from main
  # }

# Function epilogue
done:
  leave
  ret

# Start of the data section
.data

output_fmt: 
  .asciz "%ld\n"
scanf_fmt: 
  .asciz "%ld %c %ld"  # TODO: modify as needed

# "Slots" for scanf
a:  .quad 0
b:  .quad 0
op: .byte 0

