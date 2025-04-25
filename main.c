#include <xc.h>
#include "config.h"
#include "lcd.h"
#include "gps.h"

void main() {
    char gps_line[100];

    UART_Init();
    LCD_Init();

    LCD_Set_Cursor(1, 1);
    LCD_String("Esperando GPS...");

    while (1) {
        GPS_Read_Line(gps_line);
        parseGPGGA(gps_line);
        __delay_ms(1000); // Evita parpadeo excesivo
    }
}
