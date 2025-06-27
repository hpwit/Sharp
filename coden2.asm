org 100h
di
ld a,40h
out (40h),a
mainl:
call puwall
;call scroll
;ret
;call displ2
call keyb
call shship
;call disshi
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
jp mainl


puwall:


call PRNG
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
;ld hl,shift1
;add ix,bc
;add iy,bc
;ld a,(hl)
;ld (ix),A
;ld (iy),A
;inc hl
;add ix,bc
;add iy,bc
;ld a,(hl)
;ld (ix),A
;ld (iy),A

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
;ld hl,shift1
;add ix,bc
;ld a,(hl)
;ld (ix),A
;inc hl
;add ix,bc
;ld a,(hl)
;ld (ix),A

ret


scroll:
push hl
push de
push bc
ld hl,screen
ld de,screen
inc hl
ld b,4
ld c,88h
ldir
pop bc
pop de
pop hl
ret



;create a random number do -3 and add the wall
PRNG: PUSH DE
PUSH HL
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
cp 24
jp c, store
ld a,24
jp store
inf:
ld a,0
store:
ld (HL),a
POP HL
POP DE
RET 

mask:
;push af
;ld a,0ffh
;ld (shift1),A
;ld (shift2),a
;pop af
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
;push hl
;ld hl,shift1
;rl (hl)
;ld hl,shift2
;rl (hl)
;pop hl
dec A
jp lmask
elmask:
ret



shship:
push hl

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
;ld a,0
;ld (shift1),A
;ld (shift2),a

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
;push hl
;ld hl,shift1
;rl (hl)
;ld hl,shift2
;rl (hl)
;pop hl
dec a
jp l32
el32:
ld (ix),b
ld (ix+14),c
ld (ix+28),d
ld (ix+42),E
ld (ix+56),h
ld (ix+70),l
;ld a,(shift1)
;ld (ix+84),a
;ld a,(shift2)
;ld (ix+98),a
inc iy
inc ix
pop af
inc A
cp 14
;pop de
jp nz,l33
;pop de
pop hl
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
ret
kw:
ld hl,posx
ld a,(hl)
dec A
bit 7,A
jp z,decr
;pop hl
ret
decr:
dec (HL)
;pop hl
ret
ks:
ld hl,posx
ld a,(hl)
inc A
cp 50
jp c,incr
;pop h
ret
incr:
inc (HL)
;pop hl
ret

displ3:
;push hl
;push bc
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
;ld e,0ffh
k13:
;ld a,e
;cp 0
;jp z,nt
;ld a,(scpos)
;ld
;add a,b
;sub 144
;jp nz,nt 
;ld a,0
;push bc
;ld c,144
;ld b,0
;and a
;sbc hl,bc
;ld e,0
;pop bc
nt:
ld a,b
cp 98
jp c,put2
cp 112
jp nc,put2
put:
ld a,(hl)
or (ix)
inc ix
jp suite
put2:
ld a,(hl)
suite:
out (41h),A
inc hl
djnz k13
;inc B
;ld a,B
;cp 144
;jp nz, k13
;ld a,(scpos)
;cp 0
;jp z,se
;push bc
;ld b,0
;ld c,142
;add hl,bc
;pop bc
se:
;push bc
;ld b,0
;ld c,143
add hl,de
;pop bc
inc c
ld a,C
cp 6
jp nz,mdisp3
;pop bc
;pop hl
ret


TWIDTH: DB 14H
TWALL:  DB 0DH
RVAL16: DB 30H
RVAL88: DB 81H
posx:DB 14
ship: db 65,16,227,24,247,29,255,31,255,31,255,31,249,19,241,17,240,1,160,0,160,0,224,0,64,0,64,0
shmap: ds 120 
shift1:db 00H
shift2:db 00h
scpos:db 00h
spos:db 00h
screen: ds 2296



