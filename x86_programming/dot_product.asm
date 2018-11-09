
    segment .data
a   dq  1, 2, 3, 4, 5
b   dq  2, 6, 4, 5, 6
  
  
    global  _main
    extern  _printf
    segment .text
   
_main:
    push rbp
    mov  rbp, rsp
    sub  rsp, 16 


    section .bss
variable: resb 4