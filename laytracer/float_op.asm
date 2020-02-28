


        global  _main
        extern  _printf

        section .data
double1: dq 1.3

        section .text

nx equ  12 
ny equ  8
i  equ  4
j  equ  0

format:  db  "x: %f", 10, 0
format2: db  "y: %f", 10, 0

_main:
        push    rbp                   ;setup stackframe
        mov     rbp, rsp
        sub     rsp, 16               ;get 16byte space. +0 

        mov     dword [rsp + nx], 200 ;local variable initialization
        mov     dword [rsp + ny], 100
        mov     dword [rsp + i],   0
        mov     dword [rsp + j],   0


        ;print x
        xor     rax, rax
        mov     eax, dword [rsp + nx]
        
        movsd    xmm1, [rel double1] 
        ;printf xmm0:double number, rax:#vector(float) argument, rdi:format data
        cvtsi2sd  xmm0, rax 
        addsd   xmm0, xmm1
        lea     rdi, [rel format]
        mov     rax, 1 
        call    _printf
       
        ;print y 
        xor     rax, rax
        mov     eax, dword [rsp + ny]

        lea     rdi, [rel format2]
        mov     rsi, rax 
        call    _printf 

        


        ; mov     rsp, rbp 
        ; pop     rbp
        leave                     ; restore rbx before returning
        ret


