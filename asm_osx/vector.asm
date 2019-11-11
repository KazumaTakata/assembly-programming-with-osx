
        extern _printf
        extern _malloc
        global _print_vec3        
        global _add_vec3        
        global _sub_vec3
        global _init_vec3
        global _copy_vec3
        global _scala_mul_vec3
        global _unit_vec3
    
        section .data
        struc  Vec3
.x       resq 1 
.y       resq 1
.z       resq 1
        endstruc

zero_double: dq 0.0
one_double: dq 1.0

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
        

_length_vec3:
       movsd   xmm0,  [rel zero_double]
       movsd   xmm1,  [rdi + Vec3.x]
       mulsd   xmm1, xmm1
       addsd   xmm0, xmm1
       
       movsd   xmm1,  [rdi + Vec3.y]
       mulsd   xmm1, xmm1
       addsd   xmm0, xmm1

       movsd   xmm1,  [rdi + Vec3.z]
       mulsd   xmm1, xmm1
       addsd   xmm0, xmm1
    
       sqrtsd  xmm0, xmm0

       ret

_unit_vec3:
       call  _length_vec3
       movsd xmm1, [rel one_double]
       divsd xmm1, xmm0
       movsd xmm0, xmm1
       call  _scala_mul_vec3
       ret

_scala_mul_vec3:
       
       movsd    xmm1,  [rdi + Vec3.x] 
       mulsd    xmm1,  xmm0
       movsd    [rdi + Vec3.x], xmm1

       movsd    xmm1,  [rdi + Vec3.y] 
       mulsd    xmm1,  xmm0
       movsd    [rdi + Vec3.y], xmm1

       movsd    xmm1,  [rdi + Vec3.z] 
       mulsd    xmm1,  xmm0
       movsd    [rdi + Vec3.z], xmm1


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
        

_copy_vec3:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16 
            
        mov     [rsp + 0], rdi 
    
        mov     rdi, Vec3_size
        call    _malloc ;return addr in rax
       
        mov     rcx, [rsp + 0] 
        movsd     xmm0 , [rcx + Vec3.x]
        movsd     qword [rax + Vec3.x], xmm0
        movsd     xmm0, [rcx + Vec3.y]
        movsd     qword [rax + Vec3.y], xmm0
        movsd     xmm0, [rcx + Vec3.z] 
        movsd     qword [rax + Vec3.z], xmm0


        leave
        ret


_init_vec3:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        
        ;x y z
        movsd     [rsp + 0], xmm0
        movsd     [rsp + 8], xmm1
        movsd     [rsp + 16], xmm2
 
        mov     rdi, Vec3_size
        call    _malloc ;return addr in rax
        
        movsd     xmm0 , [rsp + 0]
        movsd     qword [rax + Vec3.x], xmm0
        movsd     xmm0, [rsp + 8]
        movsd     qword [rax + Vec3.y], xmm0
        movsd     xmm0, [rsp + 16] 
        movsd     qword [rax + Vec3.z], xmm0


        leave
        ret
