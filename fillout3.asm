10 org 100h
20 ld b,0
30l1: ld a,b
40 cp 48
50 jp z,fini
60 ld c,0
70l2: ld a,c
80 cp 144
90 jp z, endl2
100 call pixel
110 inc c
120 jp l2
130endl2: inc b
140 jp l1
160fini: ret


200pixel:di
210 push DE

390 ld a,c
400 and 0fh
410 out (40h),A
430 ld a,c
440 ;call 852bh  
450 rrca 
460 rrca
470 rrca
480 rrca
485 and 0Fh
490 or 10h
510 out (40h),A
520 ;call 852bh
530 ld d,a
540 ld e,b
560 srl e
570 srl e
580 srl e
600 ld a ,(790Dh)
605 add a,e
610 and 7
620 or 0b0h
630 out (40h),a
640 ;call 852bh
650 in a,(41h)
660 ;call 852bh
670 in a,(41h)
680 ld e,a
690 ld a,c
700 and 0fh
705 out (40h),A 



710 ld a,d
720 out (40h),A
730 ld a,B

1240 ld d,1
740 and 7
1260 jp z,ends
1270shift: sla d
1280 dec a
1290 jp nz,shift
1300ends: ld a,d
1320 or e
1330 out (41h),A
 1340 ;call 852bh

1350 pop de
1360 ei
1370 ret

 