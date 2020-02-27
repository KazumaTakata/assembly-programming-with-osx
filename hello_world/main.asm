    global  _main
    extern  _printf
    default  rel


    section .text

hello: db "hello world", 10, 0


_main:
    push rbp
    mov  rbp, rsp
    sub  rsp, 16 ;16 bit stack alignment


    lea   rdi, [hello]
    call  _printf


    leave
    ret

    
