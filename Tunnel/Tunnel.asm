screen_height: equ 12*8
start_wall: equ 36
wall_min: equ 12

org 100h
di
ld a,40h
out (40h),a
call init
call cls
call clsscreen
call create_wall
call shship
main_loop:
;ld a,96

;add 40h
;out (40h),a

ld a,(speed)
ld c,a
ld a ,(count)
and c
cp c
jp nz,nkey2
call puwall
call display
ld a,(scpos)
cp 143
jp nz,smain
ld a,00h
ld (scpos),a
jp keytes
smain:
ld hl,scpos
inc (hl)
keytes:
in a,(1Fh)
rlca
ret C
ld hl,(score2)
inc hl
ld (score2),hl
ld hl,(score)
inc hl

ld (score),hl

ld a,0ffh
and L
cp 0
jp nz ,not_dec
ld hl,wall_height
dec (hl)
ld a,(hl)
cp 25
jp  nc,nothing
ld ix,speed

ld a,(ix+0)
cp 0
jp z,nothing2



ld a,96
ld (wall_height),a
ld a,0
ld (wall_pos),a
call create_wall
ld a,0
ld (activ),a
ld (detec),a
ld b,144
lopp_wait:
push bc
ff:
ld a,(speed)
ld c,a
ld a ,(count)
and c
cp c
jp z,keytes2

ld hl,(count)
inc (hl)
jp ff
keytes2:
call puwall
call display
ld a,(scpos)
cp 143
jp nz,smain2
ld a,00h
ld (scpos),a
jp keytes2
smain2:
ld hl,scpos
inc (hl)

pop BC
djnz lopp_wait
ld a,start_wall
ld (wall_height),a
ld a,33
ld (wall_pos),a
ld a,50
ld (posx),a
ld a,28
ld (scro),a
ld a,0
ld (activ),a
ld a,0ffh
ld (detec),a
ld b,0
ld c,0
ld (score2),bc
ld ix,speed
srl (ix+0)
call cls
call clsscreen
call shship
call display
call create_wall
nothing:
call create_wall
jp not_dec
nothing2:
inc (hl)

not_dec:


nkey2:
ld a,(speed)
ld c,a
ld a ,(count)
and c
cp c
jp nz,nkey
call keyb
call shshi2
nkey:

ld hl,count
inc (hl)
ld a,(score2)
cp 150
jp nz,kl
ld (activ),a
kl:

ld a,(toup)
cp 0
jp z,main_loop
;;ending
ld bc,0ffffh
call wait
;;flash
ld a,0a7h
out (40h),a
ld bc,0ffffh
call wait
ld a,0a6h
out (40h),a
ld bc,0ffffh
call wait
ld a,0a7h
out (40h),a
ld bc,0ffffh
call wait
ld a,0a6h
out (40h),a
ld bc,0ffffh
call cls
ld hl,(score)
call  ToDec16
ld b,11
ld hl,scstr
ld de,0101h
call 0bff1h
;call cls
ret



shship:
;push hl

ld iy, ship
ld hl,shmap
inc iy
inc iy
ld a,0
l33:
push AF

push hl
ld bc,14
ld a,(iy+0)
ld (hl),a
inc iy
ld a,(iy+0)
add hl,bc
ld (hl),a
ld a,0
add hl,bc
ld (hl),a
add hl,bc
ld (hl),a
add hl,bc
ld (hl),a
add hl,bc
ld (hl),a
add hl,bc
ld (hl),a
add hl,bc
ld (hl),a
add hl,bc
ld (hl),a
add hl,bc
ld (hl),a
add hl,bc
ld (hl),a
add hl,bc
ld (hl),a
pop hl


ld a,(posx)
ld b,a
ld e,14
ld d,0
and A
push hl
l32:
push hl
rl (hl)
push af
add hl,de
pop af
rl (hl)
push af
add hl,de
pop af
rl (hl)
push af
add hl,de
pop af
rl (hl)
push af
add hl,de
pop af
rl (hl)
push af
add hl,de
pop af
rl (hl)
push af
add hl,de
pop af
rl (hl)
push af
add hl,de
pop af
rl (hl)
push af
add hl,de
pop af
rl (hl)
push af
add hl,de
pop af
rl (hl)
push af
add hl,de
pop af
rl (hl)
push af
add hl,de
pop af
rl (hl)
push af
add hl,de
pop af
pop hl
djnz l32
pop hl
inc iy
inc hl
pop af
inc A
cp 14
;pop de
jp nz,l33
;pop de
;pop hl
ret

shshi2:

ld a,(deltap)
cp 0
jp nz, sda
ret
sda:
ld iy, shmap
ld ix,shmap
ld bc,140
add iy,bc

ld a,0

l332:
push af
;ld b,(ix+0)
;ld c,(ix+14)
;ld d,(ix+28)
;ld e,(ix+42)
;ld h,(ix+56)
;ld l,(ix+70)

ld a,(deltap)
bit 7,A
jp nz,onde
sla (ix+0)
rl (ix+14)
rl (ix+28)
rl (ix+42)
rl (ix+56)
rl (ix+70)
rl (ix+84)
rl (ix+98)
rl (ix+112)
rl (ix+126)
rl (iy+0)
rl (iy+14)
jp ste
onde:
srl (iy+14)
rr (iy+0)
rr (ix+126)
rr (ix+112)
rr (ix+98)
rr (ix+84)
rr (ix+70)
rr (ix+56)
rr (ix+42)
rr (ix+28)
rr (ix+14)
rr (ix+0)

ste:
inc ix
inc iy
pop af
inc A
cp 14
;pop de
jp nz,l332
;pop de

ret

clsscreen:

ld hl,screen
ld de, screen
dec hl
ld b,0dh
ld c,74
ldir
ret

cls: 
LD B, 144
LD DE, 0
CLS0: LD A, 32
CALL 0BFEEH
RET
LD B,24
LD E,0
JP CLS0


create_wall:
ld hl,wall
ld c,0ffh
ld b,12
fill:
ld (hl),C
inc hl
djnz fill
ld a,(wall_height)
ld b,a
ld ix,wall
;and a
locreate:
and a
rl (ix+0)
rl (ix+1)
rl (ix+2)
rl (ix+3)
rl (ix+4)
rl (ix+5)
rl (ix+6)
rl (ix+7)
rl (ix+8)
rl (ix+9)
rl (ix+10)
rl (ix+11)
djnz locreate
;ld a,(wall_height)
ld a,(wall_pos)
cp 0
jp z, end_create
ld b,a
;inc b
;ld ix,wall
locreate2:
scf
rl (ix+0)
rl (ix+1)
rl (ix+2)
rl (ix+3)
rl (ix+4)
rl (ix+5)
rl (ix+6)
rl (ix+7)
rl (ix+8)
rl (ix+9)
rl (ix+10)
rl (ix+11)
djnz locreate2
end_create:
ret

PRNG:
ld ix,wall_height
ld a,96
sub (ix+0)
ld c,a
LD DE,(RVAL16)
LD H,E
LD L,1
ADD HL,DE
ADD HL,DE
ADD HL,DE
ADD HL,DE
ADD HL,DE
LD A,H
LD (RVAL16),HL
LD A,(RVAL88)
sub3:
cp 3
jp c,esub3
sub 3
jp sub3
esub3:
dec a

;ld a,01 ;line to remove
ld b,a
ld HL,wall_pos
add A,(HL)
bit 7,a
jp nz,inf
cp c
jp c, store
ld a,C
dec a
ld b,0
jp store
inf:
ld a,0
ld b,0
store:
ld (HL),a
ld a,b
ld (wall_scroll_offset),a
;POP HL
;POP DE
RET 


init:
;cls
;ld a,138
;ld (wall_pos),a
ld a,0ffh
ld (speed),a
ld a,start_wall
ld (wall_height),a
call clsscreen

ld a,33
ld (wall_pos),a
ld b,0
ld c,0
ld (score),bc
ld (score2),bc
ld a,50
ld (posx),a
ld a,28
ld (scro),a
ld a,0
ld (toup),a
ld a,0
ld (activ),a
ld (count),a
ld a,0ffh
ld (detec),a
ret


puwall:

ld a,(activ)
cp 0
jp z,spw
call PRNG
jp spw2
spw:
ld a,0
ld (wall_scroll_offset),a
spw2:
call mask
ld ix,screen
ld iy,screen
ld hl,wall
ld a,(scpos)
cp 0
jp z,beginning
sub 1
ld e,A
ld d,0
add ix,de
add iy,de
ld e,144
ld d,0
add iy,de
ld d, 1
ld e,1fh
ld b,12
loop_pos:
ld a,(hl)
ld (ix+0),A
ld (iy+0),A
inc hl
add ix,de
add iy,de
djnz loop_pos
ret
beginning:
ld e,143
ld d,0
add ix,de
ld e,1fh
ld d,1
ld b,12
loop_pos2:

ld a,(hl)
ld (ix+0),A
add ix,de
inc hl

djnz loop_pos2
ret


mask:
ld a,(wall_scroll_offset)
ld ix, wall
cp 0
jp nz,onmask
ret
onmask:
bit 7,A
jp nz,negatif
scf
rl (ix+0)
rl (ix+1)
rl (ix+2)
rl (ix+3)
rl (ix+4)
rl (ix+5)
rl (ix+6)
rl (ix+7)
rl (ix+8)
rl  (ix+9)
rl (ix+10)
rl (ix+11)
ret
negatif:
scf
rr (ix+11)
rr (ix+10)
rr (ix+9)
rr (ix+8)
rr (ix+7)
rr (ix+6)
rr (ix+5)
rr (ix+4)
rr (ix+3)
rr (ix+2)
rr (ix+1)
rr (ix+0)
ret



display:
ld d,1
ld e,1fh
ld hl,screen
ld ix,shmap
ld a,(scpos)
ld b,0
ld c,a
add hl,bc
ld a,(scro)
and 7
add 40h
out (40h),a
ld a,(scro)
srl A
srl A
srl A
;ld b,a
;ld (scro2),a
;ld b,a
cp 0
jp z,suitead
ld b,a
ld (scro2),a
advance:
add hl,de
push bc
ld bc,14
add ix,bc
pop bc
djnz advance
;ld (scro2),a
suitead:
ld e,143
ld d,0
ld c,0
loop_display:
ld a,0
out (40h),A
ld a,10h
out (40h),a
;ld a,(scro2)
;add a,c
ld a,c
and 7
or 0b0h
out (40h),A
ld a,c
ld b,144
ld c,41h
otir
ld c,a

push de
push hl
push bc
ld a,0
out (40h),A
ld a,12h
out (40h),a
;ld a,c
;or 0b0h
;out (40h),A
ld b,14
and a
ld d,0
ld e,112
and A
sbc hl,de
diss:

ld a,(ix+0)
ld d,(hl)
and d
jp z,sdf
ld d, A
ld a,(detec)
and d
;ld a,0
ld (toup),a
sdf:
ld a,(ix+0)
ld d,(hl)
or d
out (41h),a
inc ix
inc hl
djnz diss
pop bc
pop hl
pop de


add hl,de
inc c
ld a,c 
cp 7
jp nz,loop_display
ret



keyb:
;push hl
ld a,1
out (11h),A
in a,(10h)
and 4
jp nz,kw
ld a,4
out (11h),A
in a,(10h)
and 2
jp nz,ks
;pop hl
ld a,0
ld (deltap),a
ret
kw:
ld hl,posx
ld a,(hl)
dec A
bit 7,A
jp z,decr
ld a,0
ld (deltap),a
ret
decr:
dec (HL)
ld a,0ffh
ld (deltap),a
ld a,(hl)
ld hl,scro
sub (hl)
cp 8
jp nz,exi
ld a,(scro)
cp 0
jp z,exi
;ld hl, scro
dec (hl)
exi:
ret
ks:
ld hl,posx
ld a,(hl)
inc A
cp 86
jp c,incr
ld a,0
ld (deltap),a
ret
incr:
inc (HL)
ld a,1
ld (deltap),a
ld a,(hl)
ld hl,scro
sub (hl)
cp 26
jp nz,exi2
ld a,(scro)
cp 48
jp z,exi2
;ld hl, scro
inc (hl)
exi2:
;pop hl
ret


wait:
nop
nop
nop
nop
dec bc
ld a,b
or c
jp nz,wait
ret

; Divides HL by 10 using binary long division
; Input:  HL = 16-bit unsigned value
; Output: HL = quotient
;         A  = remainder (0–9)
; Uses:   AF, BC, DE

; Input:  HL = 16-bit value
; Output: [DE] = null-terminated ASCII decimal string
; Temp:   Uses a small buffer to reverse string

ToDec16:


    ld bc, scdstr   ; Temporary buffer for digits
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


;datas
wall_height: db 0
wall_pos: db 00
wall_scroll_offset: db 00
RVAL16: DB 30H
RVAL88: DB 81H
deltap: db 0
count: db 0
str2: db 'S','T','A','G','E',':'
stra2: db 49
scstr: db 'S','C','O','R','E',':'
scdstr: db 48,48,48,48,48
ship: db 0,0,32,0,113,4,249,6,255,7,255,7,255,7,249,4,249,4,248,0,112,0,80,0,112,0,32,0
toup:db 0
shift1:db 00H
shift2:db 00h
scpos:db 00h
spos:db 00h
scrod: db 41h,41h ,41h,41h,41h,41h

qs: db 255,255
rest: db 255,255
scro:db 24
posx:DB 24
scro2:db 0
score:db 0,0
score2:db 0,0
activ:db 00
endsc: db 0
speed: db 0
detec: db 0
zeero: db 0
screen: ds 3500
wall: ds 12


shmap: ds 168
