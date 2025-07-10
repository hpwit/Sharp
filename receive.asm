org 2000h
call 0bce8h
call 0bce5h
ld b,a
call 0bce5h
ld c,a
call 0bce5h
ld h,a
call 0bce5h
ld l,a
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
