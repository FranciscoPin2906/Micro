
; PIC18F4550 Configuration Bit Settings

; ASM source line config statements

#include "p18F4550.inc"
#include <htc.h>
#define _XTAL_FREC 4000000

  CONFIG  FOSC = INTOSC_HS      ; Oscillator Selection bits (Internal oscillator, HS oscillator used by USB (INTHS))
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)

 org 0x00
 goto inicio
 inicio
    CLRF    TRISB , rb0
    CLRF    LATB  , rb0 
    BSF     LATB  , RB0
    _delay_ms (1000)
    BCF     LATB  ,rb0
    _delay_ms (1000)
end
 
 
 


