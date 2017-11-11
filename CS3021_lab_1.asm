;;lib.asm
.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive

.data

	g DD 4
	;DD means doubleword 32bits, 4 bytes, int

.code

public min
	min:									;; a=[ebp+8]
		push ebp							;; c=[ebp+16]
        mov ebp, esp						;; b=[ebp+12]
        sub esp, 4                          ;; v => [ebp-4]
        mov eax, [ebp+8]
        mov [ebp-4], eax                    ;; v=a
        mov eax, [ebp + 12]
        cmp eax, [ebp-4]                     ;;if(b < v)
        jge min_not_b
        mov [ebp-4], eax                    ;;v=b
	min_not_b:
        mov eax, [ebp+16]
        cmp eax, [ebp-4]
        jge min_not_c
        mov [ebp-4], eax                    ;;v=c
	min_not_c:
        mov eax,[ebp-4]
        mov esp, ebp
        pop ebp
        ret 0

public p
;     i = rcx, j = edx, k= r8, l = r9
;     sub esp, 32  ;;shadow space
;     sub esp, 4   ;; ebp-4 = v(temp)
;     mov

p:
	push ebp
    mov ebp, esp
    sub esp, 4                              ;; v=>[ebp-4]

	mov eax, [esp+12]
    push eax		                        ;; [esp+16] J
	mov eax, [esp+8]
    push eax                                ;; [esp+12] I
    mov eax, [g]                              ;; move global to reg
    push eax                                ;; [esp + 8] G
    call min
    mov [ebp-4], eax						;; v = (answer from min function)
    add esp, 12

	mov eax, [esp+20]
    push eax                                ;; [esp+16] L
	mov eax, [esp+16]
    push eax                                ;; [esp+12] K
    mov eax, [ebp-4]
    push eax								;; [esp+8] V
    call min
    add esp, 12
    mov esp, ebp
    pop ebp
    ret 0


public gcd
gcd:
	push ebp
    mov ebp, esp						;; a @ [esp+12]
			                            ;; b @ [esp+ 8]

    mov ebx, 0
    mov eax, [ebp+8]                    ;;
    cmp ebx, eax                        ;; if(b==0)
    jne b_not_0
    mov eax, [ebp+12]
    jmp b_equal_0
b_not_0:

	mov eax, [ebp+8]					;; b @ [esp+12]
	push eax
	mov eax, [ebp+12]					;; %b(a=>eax)
	mov ebx, [ebp+8]
	xor edx, edx						;; clear edx due to sign
	idiv ebx
	mov eax, edx						;; a mod b [esp+8]
	push eax
	call gcd							;;eax => a mod b
	add esp, 8
b_equal_0:
	mov esp, ebp
	pop ebp
	ret 0

end
