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
380 push bc
390 ld a,c
400 and 0fh
410 out (40h),A
420 push AF
430 ld a,c
440 ;call 852bh  
450 srl A
460 srl a
470 srl a
480 srl a
490 or 10h
500 push af
510 out (40h),A
520 ;call 852bh
530 ld a,B
540 and 7
550 ld d,a
560 srl b
570 srl b
580 srl b
590 ld a,(790dh)
600 add a,b
610 and 7
620 or 0b0h
630 out (40h),a
640 ;call 852bh
650 in a,(41h)
660 ;call 852bh
670 in a,(41h)
680 ld e,a
690 pop af
700 out (40h),A
710 pop af
720 out (40h),A
730 pop bc

1230 ld a,d
1240 ld d,1
1250shift:cp 0
1260 jp z,ends
1270 sla d
1280 dec a
1290 jp shift
1300ends: ld a,d
1320 or e
1330 out (41h),A
1340 ;call 852bh
1350 pop de
1360 ei
1370 ret

 