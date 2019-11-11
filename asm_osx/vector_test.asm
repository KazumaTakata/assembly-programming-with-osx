


        global  _main
        extern  _printf
        extern  _malloc
        extern  _print_vec3
        extern  _add_vec3
        extern  _sub_vec3
        extern  _init_vec3
        extern  _copy_vec3
        extern  _scala_mul_vec3
        extern  _unit_vec3

        section .data
        struc  Vec3
.x       resq 1 
.y       resq 1
.z       resq 1
        endstruc

double1: dq 3.44
double2: dq 2.4
double3: dq 1.24
double4: dq 1.3
double5: dq 5.4
double6: dq 66.4

        section .text



_main:
        push    rbp                   ;setup stackframe
        mov     rbp, rsp
        sub     rsp, 16               ;get 16byte space. +0 
        

        movsd     xmm0, [rel double1]
        movsd     xmm1, [rel double2]
        movsd     xmm2, [rel double3]
        call    _init_vec3
        mov     [rsp + 0], rax

 
        movsd     xmm0, [rel double4]
        movsd     xmm1, [rel double5]
        movsd     xmm2, [rel double6]
        call    _init_vec3
        mov     [rsp + 8], rax

        
        mov     rdi, [rsp + 0]
        mov     rsi, [rsp + 8]
        call    _sub_vec3


        mov     rdi, [rsp + 0]
        call    _print_vec3

        mov     rdi, [rsp + 0]
        call    _copy_vec3

        mov     rdi, rax
        call    _unit_vec3

        mov     rdi, rax
        call    _print_vec3

        
        leave

        ret



