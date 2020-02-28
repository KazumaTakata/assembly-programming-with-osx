    global  _main
    extern  _printf
    default  rel

    section .text

message: db "hello world 10 times", 10, 0

format: db "%c", 10, 0
lparen: db " <LPAREN> ", 0
rparen: db " <RPAREN> ", 0
number: db " <NUMBER> ", 0
space: db " <SPACE> ", 0
plus: db " <PLUS> ", 0






string: db "(+ 5 3)", 0

i equ 0

_main:
    push rbp
    mov  rbp, rsp
    sub  rsp, 16

    mov  al, byte [string]

    mov  rax, 0 
    mov  qword [rsp+i], rax

_loop:

    lea rcx, [string] 
    xor rbx, rbx
    mov bl, byte [rcx+rax]

;switch 
;case '(':
    cmp bl, '('
    jne _else1

 
    lea  rdi, [lparen]
    xor  rax, rax
    call  _printf
    jmp  _fi

_else1:
;case ')'    
 
    cmp bl, ')'
    jne _else2

 
    lea  rdi, [rparen]
    xor  rax, rax
    call  _printf
    jmp  _fi


_else2:
;case '[0-9]' 
    cmp bl, '0'
    jl _else3

    cmp bl, '9'
    jg _else3


 
    lea  rdi, [number]
    xor  rax, rax
    call  _printf
    jmp  _fi


_else3:
;case ' '
 
    cmp bl, ' '
    jne _else4

 
    lea  rdi, [space]
    xor  rax, rax
    call  _printf
    jmp  _fi


_else4:
;case '+'
 
    cmp bl, '+'
    jne _else5

 
    lea  rdi, [plus]
    xor  rax, rax
    call  _printf
    jmp  _fi

_else5:


_fi:

    ;lea  rdi, [format]
    ;mov  rsi, rbx 
    ;xor  rax, rax
    ;call  _printf

    mov rax, qword [rsp+i]   
    inc rax
    mov qword [rsp+i], rax

    cmp rax, 7 
    jne _loop


    xor  rax, rax
    leave
    ret
