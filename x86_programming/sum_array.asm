
    segment .data
b   dq  2, 6, 4, 5, 6

  
  
    global  _main
    extern  _printf
    segment .text
   
_main:
    push rbp
    mov  rbp, rsp
    sub  rsp, 16

  
    lea rsi, [rel b]

    mov rdx, 5
    mov rcx, 0
    mov rbx, 0
    call loop

    mov  rax, rbx
    lea  rdi, [rel format]             ; set 1st parameter (format)
    lea  rsi, [rel rax]               ; set 2nd parameter (current_number)

    call _printf

    xor rax, rax   
    leave
    ret
loop: 
    mov rax, [rel rsi + 8*rcx]
    imul rax, rax
    add rbx, rax
    add rcx, 1
    cmp rcx, rdx
    jne loop
    xor rax, rax
    ret
 

format:
    db  "%2ld", 10, 0
    








    section .bss
variable: resb 4