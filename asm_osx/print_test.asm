
        extern _printf
        global _print_vec3        
        global _add_vec3        
        global _sub_vec3

        section .data
        struc  Vec3
.x       resq 1 
.y       resq 1
.z       resq 1
        endstruc



        section .text

vector1_addr  equ 0
vector2_addr  equ 8

format_vector:  db  "(%f, %f, %f)", 10, 0


_add_vec3:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16

        mov     [rsp + vector2_addr], rsi
        mov     rax, [rsp + vector2_addr]
        movsd   xmm0 , qword [rax + Vec3.x]
 
        mov     [rsp + vector1_addr], rdi
        mov     rax, [rsp + vector1_addr]
        movsd   xmm1, qword [rax + Vec3.x]

        addsd   xmm1, xmm0
        movsd   qword [rax + Vec3.x], xmm1

        mov     [rsp + vector2_addr], rsi
        mov     rax, [rsp + vector2_addr]
        movsd   xmm0 , qword [rax + Vec3.y]
 
        mov     [rsp + vector1_addr], rdi
        mov     rax, [rsp + vector1_addr]
        movsd   xmm1, qword [rax + Vec3.y]

        addsd   xmm1, xmm0
        movsd   qword [rax + Vec3.y], xmm1



        mov     [rsp + vector2_addr], rsi
        mov     rax, [rsp + vector2_addr]
        movsd   xmm0 , qword [rax + Vec3.z]
 
        mov     [rsp + vector1_addr], rdi
        mov     rax, [rsp + vector1_addr]
        movsd   xmm1, qword [rax + Vec3.z]

        addsd   xmm1, xmm0
        movsd   qword [rax + Vec3.z], xmm1

        leave
        ret
        

_sub_vec3:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16

        mov     [rsp + vector2_addr], rsi
        mov     rax, [rsp + vector2_addr]
        movsd   xmm0 , qword [rax + Vec3.x]
 
        mov     [rsp + vector1_addr], rdi
        mov     rax, [rsp + vector1_addr]
        movsd   xmm1, qword [rax + Vec3.x]

        subsd   xmm1, xmm0
        movsd   qword [rax + Vec3.x], xmm1

        mov     [rsp + vector2_addr], rsi
        mov     rax, [rsp + vector2_addr]
        movsd   xmm0 , qword [rax + Vec3.y]
 
        mov     [rsp + vector1_addr], rdi
        mov     rax, [rsp + vector1_addr]
        movsd   xmm1, qword [rax + Vec3.y]

        subsd   xmm1, xmm0
        movsd   qword [rax + Vec3.y], xmm1



        mov     [rsp + vector2_addr], rsi
        mov     rax, [rsp + vector2_addr]
        movsd   xmm0 , qword [rax + Vec3.z]
 
        mov     [rsp + vector1_addr], rdi
        mov     rax, [rsp + vector1_addr]
        movsd   xmm1, qword [rax + Vec3.z]

        subsd   xmm1, xmm0
        movsd   qword [rax + Vec3.z], xmm1

        leave
        ret
        



_print_vec3:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16

        mov     [rsp + vector1_addr], rdi
        mov     rax, [rsp + vector1_addr]
        movsd     xmm0, qword [rax + Vec3.x]
 
        mov     [rsp + vector1_addr], rdi
        mov     rax, [rsp + vector1_addr]
        movsd     xmm1 , qword [rax + Vec3.y]
  
        mov     [rsp + vector1_addr], rdi
        mov     rax, [rsp + vector1_addr]
        movsd     xmm2 , qword [rax + Vec3.z]
     
        mov     rax, 3 
        lea     rdi, [rel format_vector]
        call    _printf

        leave
        ret
        

