    global  _main
    extern  _printf
    default  rel

    section .text

hello: db "hello %s", 10, 0
world: db "world", 0


_main:
    push rbp
    mov  rbp, rsp

    
    xor  rax, rax

    lea   rdi, [hello]
    lea   rsi, [world]

    call  _printf


    leave
    ret
