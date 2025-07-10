10 org 2000h
20 call 0bce8h
30 call 0bce5h
40 ld b,a
50 call 0bce5h
60 ld c,a
70 call 0bce5h
80 ld h,a
90 call 0bce5h
100 ld l,a
110label:
120 ld a,b
130 or c
140 jp z,fin
150 call 0bce5h
160 ld (hl),A
170 inc hl
180 dec bc
190 jp label
200fin:
210 call 0bcebh
220 ret
