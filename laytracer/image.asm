


        global  _main
        extern  _printf
        extern  _init_vec3
        extern _copy_vec3
        extern  _scala_mul_vec3
        extern  _add_vec3   
        extern _color

 
        section .data
        struc  Vec3
.x       resq 1 
.y       resq 1
.z       resq 1
        endstruc

zero_double: dq 0.0
one_double: dq 1.0
four_double: dq 4.0
two_double: dq 2.0
m_two_double: dq -2.0
m_one_double: dq -1.0

        section .text

u   equ    96
v   equ    88
color      equ 80
direction  equ 72
u_horizontal equ 64
v_vertical equ  56
origin    equ  48
vertical  equ  40
horizontal  equ  32
lower_left  equ  24 
ray equ 16
nx equ  12
ny equ  8
i  equ  4
j  equ  0




format:  db  "x: %d", 10, 0
format2: db  "y: %f", 10, 0
initB:   dq  0.2
rbgMax:  dq  255.00
header:  db "P3", 10, 0
format_digit_space: db "%d ",0
format_digit_newline: db "%d", 10, 0


_main:
        push    rbp                   ;setup stackframe
        mov     rbp, rsp
        sub     rsp, 112               ;get 16byte space. +0 

        mov     dword [rsp + nx], 200 ;local variable initialization
        mov     dword [rsp + ny], 100

        movsd   xmm0, [rel m_two_double]
        movsd   xmm1, [rel m_one_double]
        movsd   xmm2, [rel m_one_double]
        
        call _init_vec3
        mov   [rsp + lower_left] , rax
    

        movsd   xmm0, [rel four_double]
        movsd   xmm1, [rel zero_double]
        movsd   xmm2, [rel zero_double]
        
        call _init_vec3
        mov   [rsp + horizontal] , rax
    
 
        movsd   xmm0, [rel zero_double]
        movsd   xmm1, [rel two_double]
        movsd   xmm2, [rel zero_double]
        
        call _init_vec3
        mov   [rsp + vertical] , rax
    
 
        movsd   xmm0,[rel zero_double]
        movsd   xmm1,[rel zero_double]
        movsd   xmm2,[rel zero_double]
        
        call _init_vec3
        mov   [rsp + origin] , rax
    
  
        
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
        ; u
        divsd     xmm0, xmm1 
        movsd   qword [rsp + u]  , xmm0        
       

        mov   rdi, [rsp + horizontal]
        call _copy_vec3 
       
        mov   rdi, rax 
        mov   [rsp + u_horizontal], rax
        movsd   xmm0, [rsp + u]
        call _scala_mul_vec3
    
 
        ;g
        cvtsi2sd  xmm0, dword [rsp + j]
        cvtsi2sd  xmm1, dword [rsp + ny]
        divsd     xmm0, xmm1 
        movsd   [rsp + v]  , xmm0        

        mov   rdi, [rsp + vertical]
        call _copy_vec3 
       
        mov   rdi, rax 
        mov   [rsp + v_vertical], rax
        movsd  xmm0, [rsp + v]
        call _scala_mul_vec3
    
        ;direction 

        movsd   xmm0, [rel zero_double]
        movsd   xmm1, [rel zero_double]
        movsd   xmm2, [rel zero_double]
        
        call _init_vec3
        mov   [rsp + direction] , rax
        
        mov  rdi, [rsp + direction]
        mov  rsi, [rsp + u_horizontal]
        call _add_vec3

        
        mov  rdi, [rsp + direction]
        mov  rsi, [rsp + v_vertical]
        call _add_vec3

        mov  rdi, [rsp + direction]
        mov  rsi, [rsp + lower_left]
        call _add_vec3


        mov  rdi, [rsp + origin]
        mov  rsi, [rsp + direction]
       
        call _color

        mov  [rsp + color] , rax


        ; generate ir
        mov   rax, [rsp + color]
        movsd   xmm0, qword [rax + Vec3.x]         
        mulsd   xmm0, [rel rbgMax]

        xor     rax, rax
        cvtsd2si  eax, xmm0
        mov     rsi, rax
        mov     rax, 0 
        lea     rdi, [rel format_digit_space]
        
        call    _printf 

        ; generate ig
        mov   rax, [rsp + color]
        movsd   xmm0, qword [rax + Vec3.y]  
        mulsd   xmm0, [rel rbgMax]

        xor     rax, rax
        cvtsd2si  eax, xmm0
        mov     rsi, rax
        mov     rax, 0 
        lea     rdi, [rel format_digit_space]
        
        call    _printf 

        ; generate ib
        mov   rax, [rsp + color]
        movsd   xmm0, qword [rax + Vec3.z]  
        mulsd   xmm0, [rel rbgMax]
;        subsd   xmm0, [rel one_double]

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


