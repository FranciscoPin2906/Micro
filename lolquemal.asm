; PIC18F4550 Configuration Bit Settings

; ASM source line config statements

#include "p18F4550.inc"

  CONFIG  FOSC = INTOSC_HS      ; Oscillator Selection bits (Internal oscillator, HS oscillator used by USB (INTHS))
  CONFIG  WDT = OFF             ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
  CONFIG  LVP = OFF             ; Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
;variable 
  CBLOCK    0X0C
  ENDC
;codigo
  org 0x00
  
  incio
    CLRF    TRISB , rb0
    CLRF    LATB  , rb0 
    
  funcionamiento
  BSF PORTB,0
  CALL retardo_200ms
  CALL retardo_200ms
  CALL retardo_200ms
  CALL retardo_200ms
  BCF PORTB,0
  CALL retardo_200ms
  CALL retardo_200ms
  CALL retardo_200ms
  CALL retardo_200ms
  
  GOTO funcionamiento
  
  CBLOCK Contador
         Contador_2
  END
  
  retardo_200ms
   MOVLW d'200'
   GOTO Retardo_ms
  retardo_100ms
   MOVLW d'100'
   GOTO Retardo_ms
   
  Retardo_ms
    MOVWF Contador_2
  Regresa_Cuenta_2
    MOVLW  d'249'
    MOVWF  Contador
  Regresa_Cuenta
    NOP
    DECFSZ Contador,F
    GOTO Regresa_Cuenta
    DECFSZ Contador_2,F
    GOTO Regresa_Cuenta_2
    RETURN
    
    
    END
  


