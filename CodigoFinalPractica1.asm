#include "p18f4550.inc"

    CONFIG  FOSC = INTOSC_EC
    CONFIG  PLLDIV = 1
    CONFIG  CPUDIV = OSC1_PLL2 
    CONFIG  WDT = OFF
    CONFIG  LVP = OFF
    CONFIG MCLRE = OFF   

    ORG     0x00          ; Dirección de inicio

R_DELAY EQU 0x20         ; Registro para retardos
M_DELAY EQU 0x21
N_DELAY EQU 0x22

inicio:
    MOVLW   0x72         ; Configurar oscilador a 8 MHz
    MOVWF   OSCCON
    NOP                  ; Pequeño retardo
    BTFSS   OSCCON, 2    ; Esperar a que el oscilador se estabilice
    GOTO    $-1

    MOVLB   0            ; Seleccionar banco de memoria 0
    CLRF    TRISA        ; Configurar PORTA como salida
    CLRF    LATA         ; Apagar todos los pines de PORTA

loopGeneral:
    CLRF    LATA         ; Apagar todos los LEDs
    BSF     LATA, 0      ; Encender RA0
    MOVLW   D'50'        ; Retardo perceptible
    MOVWF   R_DELAY
    CALL    RETARDO

    BCF     LATA, 0
    BSF     LATA, 1      ; Encender RA1
    MOVLW   D'50'
    MOVWF   R_DELAY
    CALL    RETARDO

    BCF     LATA, 1
    BSF     LATA, 2      ; Encender RA2
    MOVLW   D'50'
    MOVWF   R_DELAY
    CALL    RETARDO

    GOTO    loopGeneral  ; Repetir el ciclo

RETARDO:
TRES_LOOP:
    MOVLW   D'255'      ; Aumentar retardo
    MOVWF   M_DELAY
DOS_LOOP:
    MOVLW   D'255'
    MOVWF   N_DELAY
UNO_LOOP:
    NOP
    NOP
    DECFSZ  N_DELAY,1
    GOTO    UNO_LOOP
    DECFSZ  M_DELAY,1
    GOTO    DOS_LOOP
    DECFSZ  R_DELAY,1
    GOTO    TRES_LOOP
    RETURN

    END



