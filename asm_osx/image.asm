


        global  _main
        extern  _printf

        section .text

b  equ  32
g  equ  24
r  equ  16 
nx equ  12
ny equ  8
i  equ  4
j  equ  0




format:  db  "x: %d", 10, 0
format2: db  "y: %f", 10, 0
initB:   dq  0.2
rbgMax:  dq  255.99
header:  db "P3", 10, 0
format_digit_space: db "%d ",0
format_digit_newline: db "%d", 10, 0


_main:
        push    rbp                   ;setup stackframe
        mov     rbp, rsp
        sub     rsp, 48               ;get 16byte space. +0 

        mov     dword [rsp + nx], 200 ;local variable initialization
        mov     dword [rsp + ny], 100
        
        ;print P3 
        xor     rax, rax
        xor     rsi, rsi
        lea     rdi, [rel header]
        call    _printf
       

        ;print x
        xor     rax, rax
        mov     eax, dword [rsp + nx]

        lea     rdi, [rel format_digit_space]
        mov     rsi, rax 
        call    _printf
       
        ;print y 
        xor     rax, rax
        mov     eax, dword [rsp + ny]

        lea     rdi, [rel format_digit_newline]
        mov     rsi, rax 
        call    _printf 

 
        ;print 255 
        xor     rax, rax
        lea     rdi, [rel format_digit_newline]
        mov     rsi, 255 
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

        

        ;main loop
        
        ;convert 32bit int to 64bit double 
        ; r
        cvtsi2sd  xmm0, dword [rsp + i]
        cvtsi2sd  xmm1, dword [rsp + nx]
        divsd     xmm0, xmm1 
        movsd   qword [rsp + r]  , xmm0        
        
        ;g
        cvtsi2sd  xmm0, dword [rsp + j]
        cvtsi2sd  xmm1, dword [rsp + ny]
        divsd     xmm0, xmm1 
        movsd   qword [rsp + g]  , xmm0        

        ;b
        movsd   xmm0 , [rel initB]
        movsd   qword[rsp + b] , xmm0 
    

        ; generate ir
        movsd   xmm0, qword [rsp + r]        
        mulsd   xmm0, [rel rbgMax]

        xor     rax, rax
        cvtsd2si  eax, xmm0
        mov     rsi, rax
        mov     rax, 0 
        lea     rdi, [rel format_digit_space]
        
        call    _printf 

        ; generate ig
        movsd   xmm0, qword [rsp + g]        
        mulsd   xmm0, [rel rbgMax]

        xor     rax, rax
        cvtsd2si  eax, xmm0
        mov     rsi, rax
        mov     rax, 0 
        lea     rdi, [rel format_digit_space]
        
        call    _printf 

        ; generate ib
        movsd   xmm0, qword [rsp + b]        
        mulsd   xmm0, [rel rbgMax]

        xor     rax, rax
        cvtsd2si  eax, xmm0
        mov     rsi, rax
        mov     rax, 0 
        lea     rdi, [rel format_digit_newline]
        
        call    _printf 


        ;increment i
        mov     eax, dword [rsp + i]
        inc     eax
        mov     dword [rsp + i], eax
        cmp     dword [rsp + nx], eax 

jnz     loop_row   
        
        ;set i to 0 
        mov     dword [rsp + i], 0


        ;decrement j
        mov     eax, dword [rsp + j]
        dec     eax
        mov     dword [rsp + j], eax
        cmp     eax, -1 

jnz     loop_col   








        ; mov     rsp, rbp 
        ; pop     rbp
        leave                     ; restore rbx before returning
        ret


