# gcc -O3 -o Ass2.exe Ass2.s
# After running, enter positive integer then Enter

.intel_syntax noprefix  # use the intel syntax, not AT&T syntax. do not prefix registers with %

.section .data        # memory variables

input: .asciz "%d"    # string terminated by 0 that will be used for scanf parameter
output: .asciz "The sum is: %f\n"     # string terminated by 0 that will be used for printf parameter

n: .int 0                    # n is variable, got from user using scanf
sumation: .double 0.0        # sumation is the variable, initialized to 0, calculated by the program, sumation=(1 + 1/1) + (2 + 1/4) + (3 + 1/9) + (4 + 1/16) + ... + (n + 1/(n^2))
v: .double 1.0               # v is the variable, initialized to 1, use in firstLoop and secondLoop
d: .double 1.0               # d is the variable, initialized to 1, use in firstLoop
x: .double 0.0               # x is the variable, initialized to 0, use in secondLoop

.section .text        # instructions
.globl _main          # make _main accessible from external

_main:                # the label denoting the program's start
   push OFFSET n      # push to stack the 2nd parameter to scanf (the integer variable n's address)
   push OFFSET input  # push to stack the 1st parameter to scanf
   call _scanf        # call scanf, the two arguments at the top of the stack will be used in reverse.
   add esp, 8         # pop the above two arguments from the stack (the esp register keeps track of the stack top, 8=2*4 bytes popped as param was 4 bytes)
   
   mov ecx, n         # ecx <- n (num of iterations)

firstLoop:
   # the four instructions listed below increase sumation by 1/d
   fld qword ptr v              # push 1 to the floating point stack
   fdiv qword ptr d             # pop top of the floating point stack (1), divide it over d then push the final result (1/d)
   fdiv qword ptr d             # pop top of the floating point stack (1/d), divide it over d then push the final result (1/d*2)

   fadd qword ptr sumation      # pop top of the floating point stack (1/d*2), add it to sumation, then push the final result (sumation+(1/d*2))
   fstp qword ptr sumation      # pop top of the floating point stack (sumation+(1/d*2)) into the memory variable sumation

   # the three instructions listed below increase d by 1   
   fld qword ptr d              # push 1 to the floating point stack
   fadd qword ptr v             # pop top of the floating point stack (1), add it to d then push the final result (d+1)
   fstp qword ptr d             # pop top of the floating point stack (d+1) into the memory variable d

   loop firstLoop               # ecx -=1 , then goto firstLoop only if ecx != 0   

mov ecx, n                      # ecx <- n (num of iterations)

secondLoop:
   # the four instructions listed below increase sumation by 1+x
   fld qword ptr v              # push 1 to the floating point stack
   fadd qword ptr x             # pop top of the floating point stack (1), add it to x then push the final result (1+x)

   fadd qword ptr sumation      # pop top of the floating point stack (1+x), add it to sumation, then push the final result (sumation+(1+x))
   fstp qword ptr sumation      # pop top of the floating point stack (sumation+(1+x)) into the memory variable sumation

   # the three instructions listed below increase x by 1   
   fld qword ptr x              # push 1 to the floating point stack
   fadd qword ptr v             # pop top of the floating point stack (1), add it to x then push the final result (x+1)
   fstp qword ptr x             # pop top of the floating point stack (x+1) into the memory variable x

   loop secondLoop              # ecx -=1 , then goto secondLoop only if ecx != 0
   
   push [sumation+4]            # push to stack the high 32-bits of the second parameter to printf (the double at label sumation)
   push sumation                # push to stack the low 32-bits of the second parameter to printf (the double at label sumation)
   push OFFSET output           # push to stack the first parameter to printf
   call _printf                 # call printf
   add esp, 12                  # pop the two parameters

   ret                          # main function end
