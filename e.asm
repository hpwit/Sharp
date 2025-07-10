            ORG    100h 

            LD      hl,65534
            CALL    DivMod10 
            LD      (res),hl 
            LD      (res2),de 
            RET      
DivMod10:            
            LD      bc,0 ; BC will store the quotient
            LD      de,0 ; DE is the remainder
            LD      a,16 ; 16 bits to process
Div10Loop:           
; Shift DE:HL left by 1 bit (double the whole number)
            ADD     hl,hl ; HL <<= 1
            RL      e 
            RL      d 
            PUSH    af 
; After shift, remainder is in DE
; Try to subtract 10 from DE
            LD      a,d 
;cp 0
;jr nz, SkipSub
            LD      a,e 
            CP      10 
            JR      c,SkipSub 

; Subtract 10 from DE
            LD      a,e 
            SUB     10 
            LD      e,a 

; Set current quotient bit
            SLA     c ; shift left C
            RL      b 
            INC     c ; set bit 0
            JR      SkipShift 

SkipSub:             
; Set current quotient bit to 0
            SLA     c ; shift left C
            RL      b 

SkipShift:           
            POP     af 
            DEC     a 
            CP      0 
            JP      nz,Div10Loop 

; Move quotient from BC to HL
            LD      h,b 
            LD      l,c 

            LD      a,e ; remainder in A
            RET      

TT:         DB      65,65,65,65 
res:        DB      0ffh,0ffh 
res2:       DB      0ffh,0ffh,0ffh
TT2:        DB      65,65,65,65 
ff:  ds 123
