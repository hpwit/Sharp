org 1000h
ld a,0ffh
ld (500h),a

xor A
out (40h),a
ld a,10h
out (40h),a
ld a,(790dh)
and 7
or 0b0h
out (40h),a

ld a,2
out (60h),a
ld a,127
out (61h),a
ld a,0DH
out (70h),a
di
ld bc,inte
ld (39h),bc

;ld (31h),bc
im 1
;ld a,0ffh
;out (16h),a
ei
loop:
;xor a
;out (40h),A
;or 10h
;out (40h),A
;ld a, (data)
ld b,144
er:
nop
;out (41h),A
djnz er

;and 0fh
;out (40h),A
;ld a,b
;srl a
;srl a
;srl a
;srl a
;and 07h
;or 10h
;out (40h),a
;ld a,b
;out (41h),a
;out (62h),a
;srl a
;cp 0

;jp nz,suite
;ld a,128
;out (62h),a
;ld a,0
;out (62h),a
;suite:

;in a,(1Fh)
;rlca
;jp  nC,loop
;di
;ld hl, 0bc37h
;ld (39h),bc
;ei
;HALT
;jr loop
ret
inte:
di
di
push af
in a,(16h)
;and 80h
;jr z ,noint
;cp 4
;jp z,noint
ld (500h),a
;jr z,noint
push hl
push bc
push de
push ix
push iy

ld hl,data

inc (hl)
;ld a, (hl)
;srl a
;cp 0

;jp nz,suite
;ld a,128
;out (62h),a
;ld a,0
;out (62h),a
suite:
in a,(62h)
out (41h),a
pop iy
pop ix
pop de
pop bc
pop hl
ld a,0ffh
jp intf
noint:
;in a,(19h)
;and 0fh
;out (19h),a
ld a,07fh
;in a,(16h)
;ld (7798h),a
intf:
CALL 0BA94h
out (16h),a
pop af
ei

;call 0bc37h
reti
df: db 65,65,65,65
data: db 255,255

