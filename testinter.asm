;--------------------------------------------
; Constants
;VECTOR_TABLE   EQU 1000h        ; Vector table address in RAM
;ISR_ADDR       EQU 0300h        ; Interrupt service routine address
;STATUS_ADDR    EQU 00100h        ; RAM location toggled by ISR
;VECTOR_BYTE    EQU 000h          ; Simulated vector byte from hardware
;--------------------------------------------

        ORG 0x500              ; Program start address (adjust as needed)
di
; --- Setup Vector Table Entry for VECTOR_BYTE ---
ld a,1
out (60h),a
ld a,0
out (61h),a
    LD A, 0x7F              ; Enable interrupt, timer settings
        OUT (0x16), A           ; Control port on G850V
ld b,255
        LD HL, 1000h
        kp:
        LD DE, ISR
        LD (HL), E             ; Low byte of ISR address
        INC HL
        LD (HL), D             ; High byte of ISR address
        inc hl
        djnz kp
        LD DE, ISR
        LD (HL), E             ; Low byte of ISR address
        INC HL
        LD (HL), D 
; --- Initialize STATUS_ADDR to zero ---
        LD HL, 300h
        LD (HL), 0

; --- Load I register with high byte of vector table ---
        LD A, 10h
        LD I, A

; --- Set IM 2 and enable interrupts ---
        IM 2
        EI

; --- Main loop: just wait ---
MAIN_LOOP:
        HALT                   ; Wait for interrupt
        JP MAIN_LOOP

;--------------------------------------------
; ISR routine at ISR_ADDR
       
ISR:
        PUSH AF
        PUSH BC
        PUSH DE
        PUSH HL
        di
        di
ld a,128
out (62h),a
ld a,0
out (62h),a
;ld a,07fh
;out (16h),a
        ei
        POP HL
        POP DE
        POP BC
        POP AF
        RETI
