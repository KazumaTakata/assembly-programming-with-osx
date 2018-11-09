    segment .text
    global _main
    extern _printf

a equ 0
b equ 8
max equ 16


print_max:
    push rbp
    mov  rbp, rsp
    sub  rsp, 32
    mov  [rel rsp + a], rdi
    mov  [rel rsp + b], rsi
    
    mov [rel rsp + max], rdi
    cmp  rsi, rdi
    jng  skip
    mov  [rel rsp + max], rsi

skip:


    segment .text
    lea  rdi, [rel fmt]
    mov  rsi, [rel rsp + a]
    mov  rdx, [rel rsp + b]
    mov  rcx, [rel rsp + max]
    xor  eax, eax
    call _printf
    leave
    ret

_main:
    push rbp
    mov rbp, rsp
    mov rdi, 100
    mov rsi, 200
    call print_max
    xor eax, eax
    leave
    ret


    segment .data
fmt db 'max(%ld,%ld) = %ld', 0xa, 0