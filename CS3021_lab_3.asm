;min:
; a:r26, b:r27, c:r28, v:r1 (as result returned in r1)
; Use r9 for g, global variable g: r9
; function result returned in r1
; Assume we have all normal jumps, have nop after every jump
; return address is stored in r25
; Instruction in delay slot is always executed whether the jump is made or not
; when calling a jump the next line is also run,
; therefore a nop is necessary as the next line as it is an instruction that does nothing
; unless you would like that instruction to be run, then not necessary
add r0, 4,r9 ; g=4

min:
  add r26, r0, r1
  sub r27, r1, r0{c} ; b<v, {c} sets condition code flags
  jge min0
  xor r0,r0,r0       ; nop in delay slot
  add r27, r0,r1     ; v=b
min0:
  cmp r28, r1, r0{c} ; c<v
  jge min1
  xor r0,r0,r0       ; nop in delay slot
  add r28, r0,r1     ; v=c
min1:
  ret r25, r0        ; return address in r25, r0 gives offset
  xor r0,r0,r0       ; delay slot


; function result returned in r1
; i:r26, j:r27, k:r28, l:r29
; Pass parameters with registers r10-r15
; Parameters to min: first in r10, then r11, then r12
p:
  add r9, r0, r10  ; set up first parameter, result in r10, g into r10
  add r26, r0, r11 ; 2nd param in r11
  callr r25, min   ; pass the return address (r25), call min and save return address in r25
  add r27, r0, r12 ; 3rd param in r12
  add r1, r0, r10  ; first param for second call of min with result of min(g,i,j), result was in r1
  add r28, r0, r11 ; 2nd param (k)
  callr r25, min
  add r29, r0, r12 ; 3rd param (l)
  ret r25, 0       ; return result in r1
  xor r0,r0,r0

; result of gcd(a,b) in r1
; a:r26, b:r27
; pass parameters with registers r10-r15 to another function
gcd:
  sub r27, r0, r0{c} ; b == 0, {c} set condition flag
  je retA           ; b == 0 => true
  xor r0,r0,r0
  add r26, r0, r10  ; a is 1st param for mod(a,b)
  callr r25, mod    ; a % b in r1
  add r27, r0, r11  ; b is 2nd param for mod(a,b) put after call for efficiency
  add r27, r0, r10  ; b is 1st param for gcd
  callr r25, gcd
  add r1, r0, r11   ; result of (a%b/r1) is 2nd param for gcd
  ret r25, 0        ; return result of gcd(b,a%b) in r1
  xor r0,r0,r0
retA:
  add r26, r0, r1   ;
  ret r25, 0        ; return a in r1
  xor r0,r0,r0

END
