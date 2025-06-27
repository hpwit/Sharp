org 100h
di
;ld a,4Fh
;out (40h),a
call init
call shship
mainl:
ld a,(scro)
add a,40h
out (40h),a
call puwall

call keyb
call shshi2
call displ3
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
;ret
in a,(1Fh)
rlca
ret C
ld hl,(score)
inc hl
ld (score),hl
ld a,(score)
cp 100
jp nz,kl
ld (activ),a
kl:
ld a,(toup)
cp 0
jp z,mainl
ret


init:
;cls
ld c,0
ld hl,screen
lcls:
ld a,0
ld b,144
lcls1:
ld (hl),a
inc hl
djnz lcls1
inc c
ld a,c
cp 16
jp nz,lcls

ld a,22
ld (twall),a
ld b,0
ld c,0
ld (score),bc
ld a,25
ld (posx),a
ld a,8
ld (scro),a
ld a,0
ld (toup),a
ld a,0
ld (activ),a
ret


puwall:

ld a,(activ)
cp 0
jp z,spw
call PRNG
jp spw2
spw:
ld a,22
spw2:
call mask
ld ix,screen
ld iy,screen
push bc
ld b,0
ld a,(scpos)
cp 0
jp z,START
sub 1

ld c,a
add ix,bc
add iy,bc
ld b,0
ld c,144
add iy,bc
pop bc
ld (ix),B
ld (iy),b
ld a,C
ld b,1
ld c,1fh
add ix,bc
add iy,bc
ld (ix),A
ld (iy),A
add ix,bc
add iy,bc
ld (ix),d
ld (iy),d
add ix,bc
add iy,bc
ld (ix),e
ld (iy),e
add ix,bc
add iy,bc
ld (ix),h
ld (iy),h
add ix,bc
add iy,bc
ld (ix),l
ld (iy),l
ld hl,shift1
add ix,bc
add iy,bc
ld a,(hl)
ld (ix),A
ld (iy),A
inc hl
add ix,bc
add iy,bc
ld a,(hl)
ld (ix),A
ld (iy),A

ret
start:
ld a,143

ld c,a
add ix,bc
pop bc
ld (ix),B
ld a,C
ld b,1
ld c,1fh
add ix,bc
ld (ix),A
add ix,bc
ld (ix),d
add ix,bc
ld (ix),e
add ix,bc
ld (ix),h
add ix,bc
ld (ix),l
ld hl,shift1
add ix,bc
ld a,(hl)
ld (ix),A
inc hl
add ix,bc
ld a,(hl)
ld (ix),A

ret




;create a random number do -3 and add the wall
PRNG:
;PUSH DE
;PUSH HL
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
ld HL,TWALL
add A,(HL)
bit 7,a
jp nz,inf
cp 40
jp c, store
ld a,40
jp store
inf:
ld a,0
store:
ld (HL),a
;POP HL
;POP DE
RET 

mask:
push af
ld a,0ffh
ld (shift1),A
ld (shift2),a
pop af
ld ix,shift1
ld iy ,shift2
ld b,0
ld c,0h
ld d,0h
ld e,0ffh
ld h,0ffh
ld l,0ffh
lmask:
cp 0
jp z,elmask
scf
rl B
rl C
rl d
rl e
rl h
rl l
rl (ix)
rl (iy)
dec A
jp lmask
elmask:
ret



shship:
;push hl

ld iy, ship
ld ix,shmap

ld a,0
l33:
push af
ld b,(iy)
inc iy
ld c,(iy)
ld d,0
ld h,0
ld l,0
ld a,0
ld (shift1),A
ld (shift2),a

ld a,(posx)
ld e,0

l32:
cp 0
jp z,el32
sla B
rl c
rl d
rl e
rl H
rl l
push hl
ld hl,shift1
rl (hl)
ld hl,shift2
rl (hl)
pop hl
dec a
jp l32
el32:
ld (ix),b
ld (ix+14),c
ld (ix+28),d
ld (ix+42),E
ld (ix+56),h
ld (ix+70),l
ld a,(shift1)
ld (ix+84),a
ld a,(shift2)
ld (ix+98),a
inc iy
inc ix
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

ld a,0

l332:
push af
ld b,(ix)
ld c,(ix+14)
ld d,(ix+28)
ld e,(ix+42)
ld h,(ix+56)
ld l,(ix+70)

ld a,(deltap)
bit 7,A
jp nz,onde
sla B
rl c
rl d
rl e
rl H
rl l
rl (ix+84)
rl (ix+98)
jp ste
onde:
srl (ix+98)
rr (ix+84)
rr l
rr H
rr E
rr d
rr c
rr B
ste:
ld (ix),b
ld (ix+14),c
ld (ix+28),d
ld (ix+42),E
ld (ix+56),h
ld (ix+70),l


inc ix
pop af
inc A
cp 14
;pop de
jp nz,l332
;pop de

ret


keyb:
;push hl
ld a,1
out (11h),A
in a,(10h)
and 4
jp nz,kw
ld a,2
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
cp 50
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
cp 10h
jp z,exi2
;ld hl, scro
inc (hl)
exi2:
;pop hl
ret

displ3:
ld d,0
ld e,143
ld hl,screen
ld ix,shmap
ld a,(scpos)
ld b,0
ld c,a
add hl,bc
ld c,0
mdisp3:
ld a,0
out (40h),A
ld a,10h
out (40h),a
ld a,c
or 0b0h
out (40h),A
ld b,144
k13:
ld a,(hl)
out (41h),A
inc hl
djnz k13
push de
push hl
push bc
ld a,0
out (40h),A
ld a,12h
out (40h),a
ld a,c
or 0b0h
out (40h),A
ld b,14
and a
ld d,0
ld e,112
and A
sbc hl,de
diss:

ld a,(ix)
ld d,(hl)
and d
jp z,sdf
ld a,0 ;uncomment this line for collision detection
ld (toup),a
sdf:
ld a,(ix)
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
ld a,C
cp 8
jp nz,mdisp3
;pop bc
;pop hl
ret


TWIDTH: DB 14H
TWALL:  DB 22
RVAL16: DB 30H
RVAL88: DB 81H
deltap: db 0
;ship: db 65,16,227,24,247,29,255,31,255,31,255,31,249,19,241,17,240,1,160,0,160,0,224,0,64,0,64,0
ship: db 0,0,32,0,113,4,249,6,255,7,255,7,255,7,249,4,249,4,248,0,112,0,80,0,112,0,32,0
toup:db 0
shift1:db 00H
shift2:db 00h
scpos:db 00h
spos:db 00h
scrod: db 41h,41h ,41h,41h,41h,41h
scro:db 0fh
posx:DB 24
scro2:db 0
score:db 0,0
activ:db 0
screen: ds 2304
shmap: ds 120


