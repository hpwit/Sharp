10  org 2000h
11 call cls
12 ld b,10
13 ld de,0000h
15 ld hl, intro
16 call 0bff1h
20  call 0bce8h
30  call 0bce5h
40  ld b,a
50  call 0bce5h
60  ld c,a
70  push bc
75 pop hl
80  push bc
90  ld bc,size
100 call ToDec1
110  ;pop bc
120 call 0bce5h
130 ld h,a
140  call 0bce5h
150 ld l,a
160  push hl
170  ;push bc
180  ld bc,size2
190  call hexa
200  ld b,22
210  ld hl,text1
220  ld de,0000h
230  call 0bff1h
200  ld b,8
210  ld hl,text3
220  ld de,0100h
230  call 0bff1h
240  pop hl
250  pop bc
252 ld de,00
260label:
270  ld a,b
280  or c
290  jp z,fin
300  call 0bce5h
310  ld (hl),A
311 inc de
312 push de
313  inc hl
314  dec bc
315 push bc
316 push hl
317 push de
318 pop hl
333 ld bc,size3
334  call ToDec1
335  ld b,22
336  ld hl,text1
337  ld de,0000h
338  call 0bff1h
339 pop hl
340 pop bc
341 pop de
342 in a,(1Fh)
343 rlca
344 ret C
349  jp label
350fin:
351  call 0bcebh
352  ld b,15
353  ld hl,text3
354  ld de,0100h
355  call 0bff1h
356 ld a,2
357 ld (7921h),a
370  ret
380ToDec1:
390     ;ld bc, scdstr   ; Temporary buffer for digits
400     inc bc
410     inc bc
420     inc bc
430     inc bc
440    ; ld a, 0             ; Digit count
450    ; ld (DigitCount), a
460    ld e,4
470DLoop:
480     call DM10       ; HL = HL / 10, A = remainder (0–9)
490     add a, 48
500     ld (bc), a          ; Store ASCII digit
510     dec bc
520     ;ld a, (DigitCount)
530    ; inc a
540    ;ld (DigitCount), a
550    ld a,e
560    dec a
570    ld e,a
580    cp 0
590    jp nz,DLoop
600DoneD:
610     ; Reverse the digits into output buffer (DE)
620    ; ld a, (DigitCount)
630    ; or a
640     ;jr nz, OutputDigits
650     ; HL was zero, so output '0'
660     ret
670DM10:
680 push bc
690 push de
700     ld bc, 0        ; BC will store the quotient
710     ld de, 0        ; DE is the remainder
720     ld a, 16        ; 16 bits to process
730D10Lp:
740    ; Shift DE:HL left by 1 bit (double the whole number)
750     add hl, hl      ; HL <<= 1
760     rl e
770     rl d
780     push af
790     ; After shift, remainder is in DE
800     ; Try to subtract 10 from DE
810     ld a, d
820     cp 0
830     jr nz, SkipS
840     ld a, e
850     cp 10
860     jr c, SkipS
870     ; Subtract 10 from DE
880     ld a, e
890     sub 10
900     ld e, a
910     ; Set current quotient bit
920     sla c           ; shift left C
930     rl b
940     inc c           ; set bit 0
950     jr Ski
960SkipS:
970     ; Set current quotient bit to 0
980     sla c           ; shift left C
990     rl b
1000Ski:
1010 pop af
1020     dec a
1030     cp 0
1040     jp nz, D10Lp
1050     ; Move quotient from BC to HL
1060     ld h, b
1070     ld l, c
1080     ld a, e         ; remainder in A
1090     ld (qs),bc
1100     ld (rest),de
1110     pop de
1120     pop bc
1130     ret


1140cls: 
1150 LD B, 144
1160 LD DE, 0
1170CLS0: LD A, 32
1180 CALL 0BFEEH
1190 RET
1200 LD B,24
1210 LD E,0
1220 JP CLS0

1221hexa:
1223 ld A,h
1224 srl A
1225 srl A
1226 srl A
1227 srl A
1228 add a,48
1229 cp 58
1230 jp c,s1
1231 add a,7
1232s1:
1233 ld (bc),A
1234 inc bc
1235 ld a,h
1236 and 0fh
1237 add a,48
1238 cp 58
1239 jp c,s2
1240 add a,7
1241s2:
1242 ld (bc),A
1243 inc bc
1244 ld A,l
1245 srl A
1246 srl A
1247 srl A
1248 srl A
1249 add a,48
1250 cp 58
1251 jp c,s22
1252 add a,7
1253s22:
1254 ld (bc),A
1255 inc bc
1256 ld a,l
1257 and 0fh
1258 add a,48
1259 cp 58
1260 jp c,s21
1261 add a,7
1263s21:
1263 ld (bc),A
1264 ret



1270qs: db 255,255
1280rest: db 255,255
1290intro: db 'W','A','I','T','I','N','G','.','.','.'
1300text1: db 'L','o','a','d','i','n','g','.','.','.',32
1310size3: db 48,48,48,48,48
1320dd: db '/'
1330size: db 48,48,48,48,48
1340text3: db 'a','t',':'
1350size2: db 48,48,48,48,'h',' ','D','o','n','e'

