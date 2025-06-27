10 org 100h
20 di
30 call init
40 call shship
50mainl:
60 ld a,(scro)
70 add a,40h
80 out (40h),a
90 call puwall
100 call keyb
110 call shshi2
120 call displ3
130 ld a,(scpos)
140 cp 143
150 jp nz,smain
160 ld a,00h
170 ld (scpos),a
180 jp keytes
190smain:
200 ld hl,scpos
210 inc (hl)
220keytes:
230 in a,(1Fh)
240 rlca
250 ret C
260 ld hl,(score)
270 inc hl
280 ld (score),hl
290 ld a,(score)
300 cp 100
310 jp nz,kl
320 ld (activ),a
330kl:
340 ld a,(toup)
350 cp 0
360 jp z,mainl
370 ret
380init:
390 ld c,0
400 ld hl,screen
410lcls:
420 ld a,0
430 ld b,144
440lcls1:
450 ld (hl),a
460 inc hl
470 djnz lcls1
480 inc c
490 ld a,c
500 cp 16
510 jp nz,lcls
520 ld a,22
530 ld (twall),a
540 ld b,0
550 ld c,0
560 ld (score),bc
570 ld a,25
580 ld (posx),a
590 ld a,8
600 ld (scro),a
610 ld a,0
620 ld (toup),a
630 ld a,0
640 ld (activ),a
650 ret
660puwall:
670 ld a,(activ)
680 cp 0
690 jp z,spw
700 call PRNG
710 jp spw2
720spw:
730 ld a,22
740spw2:
750 call mask
760 ld ix,screen
770 ld iy,screen
780 push bc
790 ld b,0
800 ld a,(scpos)
810 cp 0
820 jp z,START
830 sub 1
840 ld c,a
850 add ix,bc
860 add iy,bc
870 ld b,0
880 ld c,144
890 add iy,bc
900 pop bc
910 ld (ix),B
920 ld (iy),b
930 ld a,C
940 ld b,1
950 ld c,1fh
960 add ix,bc
970 add iy,bc
980 ld (ix),A
990 ld (iy),A
1000 add ix,bc
1010 add iy,bc
1020 ld (ix),d
1030 ld (iy),d
1040 add ix,bc
1050 add iy,bc
1060 ld (ix),e
1070 ld (iy),e
1080 add ix,bc
1090 add iy,bc
1100 ld (ix),h
1110 ld (iy),h
1120 add ix,bc
1130 add iy,bc
1140 ld (ix),l
1150 ld (iy),l
1160 ld hl,shift1
1170 add ix,bc
1180 add iy,bc
1190 ld a,(hl)
1200 ld (ix),A
1210 ld (iy),A
1220 inc hl
1230 add ix,bc
1240 add iy,bc
1250 ld a,(hl)
1260 ld (ix),A
1270 ld (iy),A
1280 ret
1290start:
1300 ld a,143
1310 ld c,a
1320 add ix,bc
1330 pop bc
1340 ld (ix),B
1350 ld a,C
1360 ld b,1
1370 ld c,1fh
1380 add ix,bc
1390 ld (ix),A
1400 add ix,bc
1410 ld (ix),d
1420 add ix,bc
1430 ld (ix),e
1440 add ix,bc
1450 ld (ix),h
1460 add ix,bc
1470 ld (ix),l
1480 ld hl,shift1
1490 add ix,bc
1500 ld a,(hl)
1510 ld (ix),A
1520 inc hl
1530 add ix,bc
1540 ld a,(hl)
1550 ld (ix),A
1560 ret
1570PRNG:
1580 LD DE,(RVAL16)
1590 LD H,E
1600 LD L,1
1610 ADD HL,DE
1620 ADD HL,DE
1630 ADD HL,DE
1640 ADD HL,DE
1650 ADD HL,DE
1660 LD A,H
1670 LD (RVAL16),HL
1680 LD A,(RVAL88)
1690sub3:
1700 cp 3
1710 jp c,esub3
1720 sub 3
1730 jp sub3
1740esub3:
1750 dec a
1760 ld HL,TWALL
1770 add A,(HL)
1780 bit 7,a
1790 jp nz,inf
1800 cp 40
1810 jp c, store
1820 ld a,40
1830 jp store
1840inf:
1850 ld a,0
1860store:
1870 ld (HL),a
1880 RET 
1890mask:
1900 push af
1910 ld a,0ffh
1920 ld (shift1),A
1930 ld (shift2),a
1940 pop af
1950 ld ix,shift1
1960 ld iy ,shift2
1970 ld b,0
1980 ld c,0h
1990 ld d,0h
2000 ld e,0ffh
2010 ld h,0ffh
2020 ld l,0ffh
2030lmask:
2040 cp 0
2050 jp z,elmask
2060 scf
2070 rl B
2080 rl C
2090 rl d
2100 rl e
2110 rl h
2120 rl l
2130 rl (ix)
2140 rl (iy)
2150 dec A
2160 jp lmask
2170elmask:
2180 ret
2190shship:
2200 ld iy, ship
2210 ld ix,shmap
2220 ld a,0
2230l33:
2240 push af
2250 ld b,(iy)
2260 inc iy
2270 ld c,(iy)
2280 ld d,0
2290 ld h,0
2300 ld l,0
2310 ld a,0
2320 ld (shift1),A
2330 ld (shift2),a
2340 ld a,(posx)
2350 ld e,0
2360l32:
2370 cp 0
2380 jp z,el32
2390 sla B
2400 rl c
2410 rl d
2420 rl e
2430 rl H
2440 rl l
2450 push hl
2460 ld hl,shift1
2470 rl (hl)
2480 ld hl,shift2
2490 rl (hl)
2500 pop hl
2510 dec a
2520 jp l32
2530el32:
2540 ld (ix),b
2550 ld (ix+14),c
2560 ld (ix+28),d
2570 ld (ix+42),E
2580 ld (ix+56),h
2590 ld (ix+70),l
2600 ld a,(shift1)
2610 ld (ix+84),a
2620 ld a,(shift2)
2630 ld (ix+98),a
2640 inc iy
2650 inc ix
2660 pop af
2670 inc A
2680 cp 14
2690 jp nz,l33
2700 ret
2710shshi2:
2720 ld a,(deltap)
2730 cp 0
2740 jp nz, sda
2750 ret
2760sda:
2770 ld iy, shmap
2780 ld ix,shmap
2790 ld a,0
2800l332:
2810 push af
2820 ld b,(ix)
2830 ld c,(ix+14)
2840 ld d,(ix+28)
2850 ld e,(ix+42)
2860 ld h,(ix+56)
2870 ld l,(ix+70)
2880 ld a,(deltap)
2890 bit 7,A
2900 jp nz,onde
2910 sla B
2920 rl c
2930 rl d
2940 rl e
2950 rl H
2960 rl l
2970 rl (ix+84)
2980 rl (ix+98)
2990 jp ste
3000onde:
3010 srl (ix+98)
3020 rr (ix+84)
3030 rr l
3040 rr H
3050 rr E
3060 rr d
3070 rr c
3080 rr B
3090ste:
3100 ld (ix),b
3110 ld (ix+14),c
3120 ld (ix+28),d
3130 ld (ix+42),E
3140 ld (ix+56),h
3150 ld (ix+70),l
3160 inc ix
3170 pop af
3180 inc A
3190 cp 14
3200 jp nz,l332
3210 ret
3220keyb:
3230 ld a,1
3240 out (11h),A
3250 in a,(10h)
3260 and 4
3270 jp nz,kw
3280 ld a,2
3290 out (11h),A
3300 in a,(10h)
3310 and 2
3320 jp nz,ks
3330 ld a,0
3340 ld (deltap),a
3350 ret
3360kw:
3370 ld hl,posx
3380 ld a,(hl)
3390 dec A
3400 bit 7,A
3410 jp z,decr
3420 ld a,0
3430 ld (deltap),a
3440 ret
3450decr:
3460 dec (HL)
3470 ld a,0ffh
3480 ld (deltap),a
3490 ld a,(hl)
3500 ld hl,scro
3510 sub (hl)
3520 cp 8
3530 jp nz,exi
3540 ld a,(scro)
3550 cp 0
3560 jp z,exi
3570 dec (hl)
3580exi:
3590 ret
3600ks:
3610 ld hl,posx
3620 ld a,(hl)
3630 inc A
3640 cp 50
3650 jp c,incr
3660 ld a,0
3670 ld (deltap),a
3680 ret
3690incr:
3700 inc (HL)
3710 ld a,1
3720 ld (deltap),a
3730 ld a,(hl)
3740 ld hl,scro
3750 sub (hl)
3760 cp 26
3770 jp nz,exi2
3780 ld a,(scro)
3790 cp 10h
3800 jp z,exi2
3810 inc (hl)
3820exi2:
3830 ret
3840displ3:
3850 ld d,0
3860 ld e,143
3870 ld hl,screen
3880 ld ix,shmap
3890 ld a,(scpos)
3900 ld b,0
3910 ld c,a
3920 add hl,bc
3930 ld c,0
3940mdisp3:
3950 ld a,0
3960 out (40h),A
3970 ld a,10h
3980 out (40h),a
3990 ld a,c
4000 or 0b0h
4010 out (40h),A
4020 ld b,144
4030k13:
4040 ld a,(hl)
4050 out (41h),A
4060 inc hl
4070 djnz k13
4080 push de
4090 push hl
4100 push bc
4110 ld a,0
4120 out (40h),A
4130 ld a,12h
4140 out (40h),a
4150 ld a,c
4160 or 0b0h
4170 out (40h),A
4180 ld b,14
4190 and a
4200 ld d,0
4210 ld e,112
4220 and A
4230 sbc hl,de
4240diss:
4250 ld a,(ix)
4260 ld d,(hl)
4270 and d
4280 jp z,sdf
4290 ld a,0
4300 ld (toup),a
4310sdf:
4320 ld a,(ix)
4330 ld d,(hl)
4340 or d
4350 out (41h),a
4360 inc ix
4370 inc hl
4380 djnz diss
4390 pop bc
4400 pop hl
4410 pop de
4420 add hl,de
4430 inc c
4440 ld a,C
4450 cp 8
4460 jp nz,mdisp3
4470 ret
4480TWIDTH: DB 14H
4490TWALL:  DB 22
4500RVAL16: DB 30H
4510RVAL88: DB 81H
4520deltap: db 0
4530ship: db 0,0,32,0,113,4,249,6,255,7,255,7,255,7,249,4,249,4,248,0,112,0,80,0,112,0,32,0
4540toup:db 0
4550shift1:db 00H
4560shift2:db 00h
4570scpos:db 00h
4580spos:db 00h
4590scrod: db 41h,41h ,41h,41h,41h,41h
4600scro:db 0fh
4610posx:DB 24
4620scro2:db 0
4630score:db 0,0
4640activ:db 0
4650screen: ds 2304
4660shmap: ds 120
