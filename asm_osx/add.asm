


        global  _main
        extern  _printf

        section .text
_main:
        push    rbp                    ; we have to save this since we use it
        mov     rbp, rsp
        sub     rsp, 16 
        mov     ecx, 10
       
        mov     rax, 45 
        mov     qword [rsp + 16], rax 

print:
        push    rcx
        push    rcx
        lea     rdi, [rel format]
        mov     rsi, rax
        call    _printf

        pop     rcx
        pop     rcx
        
        mov     rax, qword [rsp + 16]
        add     rax, 1
        mov     qword [rsp + 16], rax

        dec     ecx
        jnz     print

        mov     rsp, rbp 
        pop     rbp
                            ; restore rbx before returning
        ret
format:
        db  "number is:%c", 10, 0
