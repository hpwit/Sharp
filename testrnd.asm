org 100h
call PRNG
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
sub 3
ld HL,TWALL
add A,(HL)
bit 7,a
jp nz,inf
cp 15
jp c, store
ld a,14
jp store
inf:
ld a,0
store:
ld (HL),a
POP HL
POP DE
RET ; 0-255
db 0ffh,0ffh,0ffh,0ffh
TWIDTH: DB 14H
TWALL:  DB 0DH
RVAL16: DB 30H
RVAL88: DB 81H
