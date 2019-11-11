


        global _color
        extern _copy_vec3
        extern _unit_vec3
        extern _init_vec3               
        extern _add_vec3
        extern _scala_mul_vec3
        

 
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
half_double: dq 0.5
point_seven_double: dq 0.7

        section .text


origin equ 0
direction equ 8
u_direction equ 16
t      equ  24
vec1   equ  32
vec2   equ  40


_color: 
    push    rbp
    mov     rbp, rsp
    sub     rsp, 48


    mov     [rsp + origin], rdi
    mov     [rsp + direction ], rsi


    mov   rdi, [rsp + direction]
    call  _copy_vec3
  
    mov   rdi, rax 
    call _unit_vec3 

    mov     [rsp + u_direction], rax
    mov     rax ,[rsp + u_direction]
    movsd   xmm0 , [rax + Vec3.y]
    addsd   xmm0 , [rel one_double]
    mulsd   xmm0 , [rel half_double]
    movsd   [rsp + t], xmm0


    
    movsd   xmm0, [rel one_double]
    movsd   xmm1, [rel one_double]
    movsd   xmm2, [rel one_double]
        
    call _init_vec3
    mov   [rsp + vec1] , rax
   
    movsd  xmm0, [rel one_double]
    movsd  xmm1, [rsp + t]
    subsd  xmm0, xmm1

    mov   rdi,  [rsp + vec1]
    call _scala_mul_vec3
   
 
    movsd   xmm0, [rel half_double]
    movsd   xmm1, [rel point_seven_double]
    movsd   xmm2, [rel one_double ]
        
    call _init_vec3
    mov   [rsp + vec2] , rax
   
    movsd  xmm0, [rsp + t] 
    mov   rdi,  [rsp + vec2]
    call _scala_mul_vec3
   
    
    mov   rdi, [rsp + vec1]
    mov   rsi, [rsp + vec2]

    call _add_vec3 

    mov  rax, [rsp + vec1]
    

    leave
    ret







