# C "pseudocode"
# unsigned long array_max(unsigned long n, unsigned long *items) {
#     unsigned long max, i;
#     max = items[0];
#
#     for (i = 1; i < n; i++) {
#         if (items[i] > max) {
#             max = items[i];
#         }
#     }
#
#     return max;
# }

# Write the assembly code for the array_max function
.global array_max

# unsigned long array_max(unsigned long n, unsigned long *items)
array_max:
# n -> %rdi
# *items -> %rsi
# max -> %rax
  # Prologue
  enter $0, $0
  
  # Body
  movq (%rsi), %rax  # Set first item as max
  
  # for var init
  # i = 1
  movq $1, %rdx

for:
  # for condition
  # i < n
  cmpq %rdi, %rdx
  je for_done

  # loop body
  # {
  movq (%rsi, %rdx, 8), %rcx  # move value at items[i] into %rcx

  # if (items[i] > max)
  cmpq %rax, %rcx
  jle inc_i
  movq %rcx, %rax
  # }

inc_i:
  incq %rdx  # i++
  jmp for
  
# Epilogue
for_done:
  leave
  ret
