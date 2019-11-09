


        global  _main
        extern  _printf

        section .text
nx equ  12
ny equ  8
i  equ  4
j  equ  0

format:  db  "x: %d", 10, 0
format2: db  "y: %d", 10, 0

_main:
        push    rbp                   ;setup stackframe
        mov     rbp, rsp
        sub     rsp, 16               ;get 16byte space. +0 

        mov     dword [rsp + nx], 200 ;local variable initialization
        mov     dword [rsp + ny], 100
 
        ;print x
        xor     rax, rax
        mov     eax, dword [rsp + nx]

        lea     rdi, [rel format]
        mov     rsi, rax 
        call    _printf
       
        ;print y 
        xor     rax, rax
        mov     eax, dword [rsp + ny]

        lea     rdi, [rel format2]
        mov     rsi, rax 
        call    _printf 



        ;init j
        xor     rax, rax
        mov     eax, dword [rsp + ny]
        dec     eax    
        mov     dword [rsp + j], eax  

        ;init i
        mov     dword [rsp + i],   0
               
loop_col:


loop_row:




        xor     rax, rax
        lea     rdi, [rel format2]
        mov     rsi, [rsp + i ] 
        call    _printf 



        mov     eax, dword [rsp + i]
        inc     eax
        mov     dword [rsp + i], eax
        cmp     dword [rsp + nx], eax 

jnz     loop_row   
        
        mov     dword [rsp + i], 0



        mov     eax, dword [rsp + j]
        dec     eax
        mov     dword [rsp + j], eax
        cmp     eax, 0 

jnz     loop_col   








        ; mov     rsp, rbp 
        ; pop     rbp
        leave                     ; restore rbx before returning
        ret


