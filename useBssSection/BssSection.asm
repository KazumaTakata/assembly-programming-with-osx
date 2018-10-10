        global  _main
        extern  _printf

        section .text
_main:
        push   rdx                    ; we have to save this since we use it

        mov     ecx, 9              ; ecx will countdown to 0
        xor     rax, rax                ; rax will hold the current number
        xor     rbx, rbx                ; rbx will hold the next number
        inc     rbx                     ; rbx is originally 1
print:
        ; We need to call printf, but we are using rax, rbx, and rcx.  printf
        ; may destroy rax and rcx so we will save these before the call and
        ; restore them afterwards.
        mov     rax ,  qword [rel arraydata + 8*1]
        mov     [rel variable], rax
        push    rax                     ; caller-save register
        push    rcx                     ; caller-save register
        mov     r8, [rel variable]  
        lea     rdi, [rel format]             ; set 1st parameter (format)
        lea     rsi, [rel r8]               ; set 2nd parameter (current_number)

        ; Stack is already aligned because we pushed three 8 byte registers
        call    _printf                  ; printf(format, current_number)

        pop     rcx                     ; restore caller-save register
        pop     rax                     ; restore caller-save register
        add     rax, 1

        mov     rdx, rax                ; save the current number
        mov     rax, rbx                ; next number is now current
        add     rbx, rdx                ; get the new next number
        dec     ecx                     ; count down
        jnz     print                   ; if not done counting, do some more
        pop     rdx
                            ; restore rbx before returning
        ret

          section   .data
format:  db        "%20ld", 10, 0
arraydata: dq      1, 2, 3, 4

        section .bss
variable: resb 4