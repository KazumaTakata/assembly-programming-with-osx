


        global  _main
        extern  _printf
        extern  _malloc

        section .data
        struc  Vec3
x       resq 1 
y       resq 1
z       resq 1
        endstruc

        section .text

format_vector:  db  "(%d, %d, %d)", 10, 0
format2: db  "y: %f", 10, 0

vector_add  equ 0

_main:
        push    rbp                   ;setup stackframe
        mov     rbp, rsp
        sub     rsp, 16               ;get 16byte space. +0 
        
        mov     rdi, Vec3_size
        call    _malloc
        
        mov     [rsp + 0], rax
        mov     rax, [rsp + 0]  
        mov     qword [rax + x], 3
        mov     qword [rax + y], 3
        mov     qword [rax + z], 4

        ; mov     rsp, rbp 
        ; pop     rbp

        
        mov     rdi, [rsp + 0]
        call    print_vec3
        leave                     ; restore rbx before returning
        ret


print_vec3:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16

        mov     [rsp + vector_add], rdi
        mov     rax, [rsp + vector_add]
        mov     rcx , qword [rax + x]
        mov     rsi, rcx
 
        mov     [rsp + vector_add], rdi
        mov     rax, [rsp + vector_add]
        mov     rcx , qword [rax + y]
        mov     rdx, rcx 
  
        mov     [rsp + vector_add], rdi
        mov     rax, [rsp + vector_add]
        mov     rcx , qword [rax + z]
      
        lea     rdi, [rel format_vector]
        call    _printf

        leave
        ret
        

