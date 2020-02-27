    global  _main
    extern  _printf
    default  rel

    section .text

equal_message: db "equal", 10, 0
notequal_message: db "not equal", 10, 0

string: db "sample"


_main:
    push rbp
    mov  rbp, rsp

    mov  rax, [string]
    mov  rbx, [string+1]




;if rax == rbx {
    cmp  rax, rbx
    jne  _else

    lea  rdi, [equal_message]
    xor  rax, rax
    call  _printf

    jmp _fi
;}
;else {
_else:

    lea  rdi, [notequal_message]
    xor  rax, rax
    call  _printf

_fi:
;}

    xor  rax, rax
    leave
    ret
