includelib legacy_stdio_definitions.lib
extern printf:proc
option casemap: none
.data
	g:
	dd 4
.code 

;parameter a = rcx, b = rdx, c = r8 (d=r9)
; x64

public min
min:
     mov rax, rcx      ; v =a
     cmp rdx, rax      ; if (b<v)
     jge min0
     mov rax, r8       ; v = b
min0 cmp r8, rax       ; if(c<v)
      jge min1
      mov rax, r8      ;v=c
min1: ret



;paramter i = rcx, j = rdx, k=r8, l=r9
public p

p:
    sub rsp, 32   ;allocate shadow space
    mov r10, rcx  ;i => temp(r10)
    mov r11, rdx  ;j => temp(r11)
    mov rcx, g    ;g=first paramter MIN1
    mov rdx, r10  ;i=second parameter MIN1
    mov r10, r8   ;k => temp(r10)
    mov r8, r11   ;j = thrid parameter MIN1
    call min
    add rsp, 32
    sub rsp, 32
    mov rcx, rax  ;result MIN1=first parameter MIN2
    mov rdx, r10  ;k=second parater MIN2
    mov r8, r9    ;l=third paramter MIN2
    call min
    ret

;parameter a = rcx, parameter b = rdx
gcd:
    cmp rdx, 0
    je b_equal_0
    add rsp, 32   ; shadow space?
    mov rax, rcx  ;a=>dividend
    mov rcx, rdx  ;b=first parameter GCD
    mov r8, rdx   ;b=> divisior
    xor rdx, rdx  ;clear for remainder (rax=quotient?)
    idiv r8       ;a/b => quotient=rax, remainder=rdx
    call gcd      ;therefore rdx=second paramter GCD  
    add rsp, 32   ;reallocate shadow space
b_equal_0:
    mov rax, rcx
    ret
