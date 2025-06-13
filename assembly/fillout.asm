;here is my tale on the pset instruction 
; this program will fill out the screen with pixels by pixels
; NB: i m anot a z80 expert so please be indulgent if there are shortcut to this.

org 100h
ld b,0
l1: ld a,b
cp 48
jp z,fini
ld c,0
l2: ld a,c
cp 144
jp z, endl2
call pixel
inc c
jp l2
endl2: inc b
jp l1
fini: ret




; this function put a pixel at position (C,B)
; register changed:  A
pixel:di
push DE
call locate
in a,(41h)
call 852bh
in a,(41h)
ld E,A
call locate
ld a,b
and 7
ld d,1
shift:cp 0
jp z,ends
sla d
dec a
jp shift
edns: ld a,d
or e
out (41h),A
call 852bh
pop de
ei
ret

;this function put the 'cursor' to the write place to read/write a 8 bits pixels string
; register changed A
locate: push bc
ld a,c
and 0fh
out (40h),A
call 852bh
srl c
srl c
srl c
srl c
ld a,10h
or c
out (40h),A
call 852bh
srl b
srl b
srl b
ld a,(790dh)
add a,b
and 7
or 0b0h
out (40h),a
call 852bh
pop bc
ret
 