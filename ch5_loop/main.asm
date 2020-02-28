    global  _main
    extern  _printf
    default  rel

    section .text

message: db "hello world 10 times", 10, 0

string: db "(+ 3 3)", 0

i equ 0

_main:
    push rbp
    mov  rbp, rsp
    sub  rsp, 16

    mov  al, byte [string]

    mov  rax, 10
    mov  qword [rsp+i], rax

_loop:

    lea  rdi, [message]
    xor  rax, rax
    call  _printf


    mov rax, qword [rsp+i]

    cmp rax, 0
    sub rax, 1 
    mov qword [rsp+i], rax

    jne _loop


    xor  rax, rax
    leave
    ret
