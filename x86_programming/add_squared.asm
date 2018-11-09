

    segment .data
a   dq   14
b   dd   5


    global  _main
    extern  _printf
    segment .text
   
_main:
    push rbp
    mov  rbp, rsp
    sub  rsp, 16 
    mov  rax, [rel a]
    imul rax, rax
    xor  rbx, rbx

    cmp rax, rbx
    jge bigger 

    lea  rdi, [rel format]             ; set 1st parameter (format)
    lea  rsi, [rel rax]               ; set 2nd parameter (current_number)

    call _printf

bigger:

    lea  rdi, [rel format]             ; set 1st parameter (format)
    lea  rsi, [rel rax]               ; set 2nd parameter (current_number)

    call _printf


    leave
    ret                  

format:
    db  "%2ld", 10, 0
    