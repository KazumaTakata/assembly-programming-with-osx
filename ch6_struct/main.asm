    global  _main
    extern  _printf
    extern  _malloc
    default  rel


    section .data
    struc Token
.type resq  1
.value resq 1
    endstruc


    section .text


string: db "sample string", 0

i equ 0

_main:
    push rbp
    mov  rbp, rsp
    sub  rsp, 16


    mov rdi, 0
    lea rsi, [string]
    call _init_Token


    xor  rax, rax
    leave
    ret


_init_Token:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 16 

    mov [rsp + 0], rdi
    mov [rsp + 8], rsi


    mov rdi, Token_size
    call _malloc

    mov rcx, [rsp + 0]
    mov qword [rax + Token.type], rcx

    mov rcx, [rsp + 8]
    mov qword [rax + Token.value], rcx




    leave
    ret
        
