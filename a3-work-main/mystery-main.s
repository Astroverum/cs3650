# Write the assembly code for the main function of the mystery program
.global main
.text

# int main(int argc, char* argv[])
main:
# argc -> %rsi
# * argv[] -> %rdi
# arg1 -> %r10
# arg2 -> %rsi

  # Prologue:
  enter $0, $0

  # Body:
  # if (argc != 3)
  cmpq $3, %rdi
  jne error

  movq %rsi, %rbx # copy argv[] pointer to callee-saved register

  # Convert string arguments to long integers
  # arg1 = strtol(argv[1], NULL, 10);
  movq 8(%rbx), %rdi
  movq $0, %rsi
  movq $10, %rdx
  call strtol
  movq %rax, %r12  # copy first arg to r12 register

  # arg2 = strtol(argv[2], NULL, 10);
  movq 16(%rbx), %rdi
  movq $0, %rsi
  movq $10, %rdx
  call strtol
  movq %rax, %rsi  # copy second arg to rsi register

  # result = crunch(arg1, arg2\n);
  movq %r12, %rdi  # copy first arg to %rsi
  call crunch

  cmpq $0, %rax
  jl less     # if (result < 0)
  jg greater  # if (resutl > 0)
  # else { printf("tea"); }
  movq $tea_msg, %rdi
  call printf
  movq $0, %rax # exit with status of 0
  jmp end

less:
  # printf("hat\n")
  movq $hat_msg, %rdi
  call printf
  movq $0, %rax # exit with status of 0
  jmp end

greater:
  # printf("beer\n")
  movq $beer_msg, %rdi
  call printf
  movq $0, %rax # exit with status of 0
  jmp end

error:
  # printf("Two arguments required.\n");
  movq $error_msg, %rdi
  call printf

  movq $1, %rax    # Exit with status of 1
  jmp end

# Epilogue
end:
  leave
  ret


.data
error_msg:
  .asciz "Two arguments required.\n"
hat_msg:
  .asciz "hat\n"
tea_msg:
  .asciz "tea\n"
beer_msg:
  .asciz "beer\n"
