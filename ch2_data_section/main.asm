    global  _main
    extern  _printf
    default  rel

    section .data

x_value: dq  34 
y_value: dq  8  



    section .text

hello: db "added number is %d", 10, 0


_main:
    push rbp
    mov  rbp, rsp

    mov  rax, [x_value]
    mov  rbx, [y_value]

    add  rax, rbx
    
    mov  rsi, rax   
    xor  rax, rax

    lea   rdi, [hello]
    call  _printf


    leave
    ret
