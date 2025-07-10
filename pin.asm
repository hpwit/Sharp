org 100h
ld a,1
out (60h),a
ld a,0
out (61h),a
loop:
ld a,128
out (62h),a
ld a,0
out (62h),a
jp loop