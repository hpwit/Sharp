10 org 100h
11 di
12 ld a,0
13 ld (da1),a
14l3:
15 ld a,(da1)
16 ld b,a
20 ld a,(790dh)
30 ld c,A
40 xor A
50 out (40h),a
60 ld a,10h
70 out (40h),a
80 ld a,c
85 add a,b
90 and 7
100 or 0b0h
110 out (40h),A
120 ld c,0
125l1:
126  push bc
127 ld hl,map
128 ld b,0
129 add hl,bc
130 ld a,(hl)
170 ld d,0
180 ld e,A
190 sla e
200 sla e
210 sla e
211 sla E
212 sla e

220 ld hl,tiles

231 ld a,(da1)
232 and 1
233 jp z, suite
234 ld a,16
235suite: 
236 add a,e
237 ld e,a
238 add hl,de
240 ld b,10h
250pix16:
260 ld a,(hl)
270 out (41h),A
275 inc hl
280 djnz pix16
281 pop bc
282 inc C
283 ld a,C
284 cp 9
285 jp c,l1
290 ld a,(da1)
300 inc A
310 ld (da1),A
320 cp 2
330 jp c,l3
340 call 0BFCDh
350 ret


1000tiles:
1020gras:   db 0h , 0h, 0h,10h,60h, 0h, 0h, 0h,0ch, 0h, 0h, 0h, 0h, 0h,80h, 0h, 0h, 0h,10h,20h, 0h, 0h,06h,01h, 0h, 0h, 0h, 0h, 0h,31h, 0h, 0h
1030tree:   db 0h ,0C0h,10h,2Ch,4Ah,28h,	5h,21h,18h,71h,3Dh,0FEh,7Ch,68h,0A0h,40h, 3h,	4h,	0Ah,11h,88h,0CBh,0FCh,0FCh,0FFh,0FBh,0DFh,9Fh,17h,	9h,	0Fh,	7h
1040palm:   db 8h,	0Ch,0C6h,0E6h,76h,3Eh,3Eh,1Ch,0FCh,5Eh,0FEh,3Fh,37h,63h,0C3h,	2h, 0h,	0h,	1h,	0h,80h,0C0h,0E0h,0D8h,0AFh,0D5h,0BFh,	0h,	0h,	0h,	0h,	0h


2000map:
2010 db 0,1,2,2,1,1,1,1,0
2020 db 2,1,0,1,0,1,1,1,0
2030 db 0,0,0,0,0,0,1,1,2

3000da1:
3010 db 0,0