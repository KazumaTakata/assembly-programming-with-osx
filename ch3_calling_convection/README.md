
#Calling Convections

For integers and pointers, rdi, rsi, rdx, rcx, r8, r9.
For floating-point (float, double), xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7 
[source](https://cs.lmu.edu/~ray/notes/nasmtutorial/)


When printf is called, rax store number of vector register argument (float type).
[source](https://stackoverflow.com/questions/6212665/why-is-eax-zeroed-before-a-call-to-printf)

rax        temporary register; with variable arguments
           passes information about the number of vector
           registers used;


