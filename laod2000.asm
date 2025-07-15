 org 2000h

 call 0bce8h
 call 0bce5h
 ld b,a
 call 0bce5h
 ld c,a
 ld hl,bc
 push bc
 ld bc,size
 call  ToDec16
 pop bc
call 0bce5h
ld h,a
 call 0bce5h
ld l,a
 push hl
 push bc
 ld bc,size2
 call  ToDec16
 ld b,26
 ld hl,text1
 ld de,0101h
 call 0bff1h
 pop bc
 pop hl

label:
 ld a,b
 or c
 jp z,fin
 call 0bce5h
 ld (hl),A
 inc hl
 dec bc
 jp label
fin:
 call 0bcebh
 ret
ToDec16:


    ;ld bc, scdstr   ; Temporary buffer for digits
    inc bc
    inc bc
    inc bc
    inc bc
   ; ld a, 0             ; Digit count
   ; ld (DigitCount), a
   ld e,4
DivideLoop:
    call DivMod10       ; HL = HL / 10, A = remainder (0–9)
    add a, 48
    ld (bc), a          ; Store ASCII digit
    dec bc

    ;ld a, (DigitCount)
   ; inc a
   ;ld (DigitCount), a
   ld a,e
   dec a
   ld e,a

   cp 0
   jp nz,DivideLoop

DoneDividing:
    ; Reverse the digits into output buffer (DE)
   ; ld a, (DigitCount)
   ; or a
    ;jr nz, OutputDigits

    ; HL was zero, so output '0'


    ret

DivMod10:
push bc
push de
    ld bc, 0        ; BC will store the quotient
    ld de, 0        ; DE is the remainder
    ld a, 16        ; 16 bits to process
Div10Loop:
    ; Shift DE:HL left by 1 bit (double the whole number)
    add hl, hl      ; HL <<= 1
    rl e
    rl d
    push af
    ; After shift, remainder is in DE
    ; Try to subtract 10 from DE
    ld a, d
    cp 0
    jr nz, SkipSub
    ld a, e
    cp 10
    jr c, SkipSub

    ; Subtract 10 from DE
    ld a, e
    sub 10
    ld e, a

    ; Set current quotient bit
    sla c           ; shift left C
    rl b
    inc c           ; set bit 0
    jr SkipShift

SkipSub:
    ; Set current quotient bit to 0
    sla c           ; shift left C
    rl b

SkipShift:
pop af
    dec a
    cp 0
    jp nz, Div10Loop

    ; Move quotient from BC to HL
    ld h, b
    ld l, c

    ld a, e         ; remainder in A
    ld (qs),bc
    ld (rest),de
    pop de
    pop bc
    ret

ReverseBits:
push bc
    LD B, 8        ; Bit count
    LD C, 0        ; Result

RevLoop:
    sla a           ; Rotate A left, MSB → Carry
    ;ccf
    Rr C          ; Rotate C left, Carry → LSB
    DJNZ RevLoop
    LD A, C        ; Return result in A
   pop bc
    RET

text1: db 'R','e','c','i','e','v','i','n','g', ' '
size: db 38,38,38,38,38,38
text2: db ' ','b','y','t','e','s',' ','a','t',' '
size2: db 38,38,38,38,38,38