
; PIC18F4550 Configuration Bit Settings

; ASM source line config statements

#include "p18F4550.inc"

  CONFIG  FOSC = INTOSC_HS      ; Oscillator Selection bits (Internal oscillator, HS oscillator used by USB (INTHS))
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)

 org 0x00
  
 goto inicio
   
 
 inicio
    CLRF    TRISB ,rb0
    CLRF    LATB  ,rb0
   
    BSF    LATB, RB0
    MOVLW 0x77            
    MOVWF OSCCON 
    
END

