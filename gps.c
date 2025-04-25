#include <xc.h>
#include <string.h>
#include "config.h"
#include "gps.h"
#include "lcd.h"

void UART_Init() {
    TRISC6 = 0; // TX
    TRISC7 = 1; // RX
    TXSTAbits.BRGH = 1;
    BAUDCTLbits.BRG16 = 0;
    SPBRG = 51;                // 9600 @ 8MHz
    TXSTAbits.SYNC = 0;
    RCSTAbits.SPEN = 1;
    TXSTAbits.TXEN = 1;
    RCSTAbits.CREN = 1;
}

char UART_Read() {
    while (!PIR1bits.RCIF); // Espera recepción
    return RCREG;
}

void GPS_Read_Line(char* buffer) {
    char c;
    int i = 0;

    // Esperar '$'
    do {
        c = UART_Read();
    } while (c != '$');

    buffer[i++] = '$';

    // Leer hasta '\n' o hasta 99 caracteres
    do {
        c = UART_Read();
        buffer[i++] = c;
    } while (c != '\n' && i < 99);

    buffer[i] = '\0';
}

void parseGPGGA(char* sentence) {
    if (strstr(sentence, "$GPGGA") != NULL) {
        char *token;
        int field = 0;
        char *latitude = NULL, *lat_dir = NULL, *longitude = NULL, *long_dir = NULL;

        token = strtok(sentence, ",");

        while (token != NULL) {
            switch (field) {
                case 2: latitude = token; break;
                case 3: lat_dir = token; break;
                case 4: longitude = token; break;
                case 5: long_dir = token; break;
            }
            token = strtok(NULL, ",");
            field++;
        }

        if (latitude && longitude && lat_dir && long_dir) {
            LCD_Cmd(0x01); // Clear
            LCD_Set_Cursor(1, 1);
            LCD_String("Lat: ");
            LCD_String(latitude);
            LCD_Char(' ');
            LCD_Char(*lat_dir);

            LCD_Set_Cursor(2, 1);
            LCD_String("Lon: ");
            LCD_String(longitude);
            LCD_Char(' ');
            LCD_Char(*long_dir);
        }
    }
}
