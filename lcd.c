#include <xc.h>
#include "config.h"
#include "lcd.h"

#define LCD_PORT LATD

void LCD_Cmd(unsigned char cmd) {
    RS = 0;
    LCD_PORT = (LCD_PORT & 0x0F) | (cmd & 0xF0);
    EN = 1; __delay_ms(2); EN = 0;
    LCD_PORT = (LCD_PORT & 0x0F) | ((cmd << 4) & 0xF0);
    EN = 1; __delay_ms(2); EN = 0;
}

void LCD_Char(unsigned char data) {
    RS = 1;
    LCD_PORT = (LCD_PORT & 0x0F) | (data & 0xF0);
    EN = 1; __delay_ms(2); EN = 0;
    LCD_PORT = (LCD_PORT & 0x0F) | ((data << 4) & 0xF0);
    EN = 1; __delay_ms(2); EN = 0;
}

void LCD_String(const char *str) {
    while (*str) LCD_Char(*str++);
}

void LCD_Set_Cursor(unsigned char row, unsigned char column) {
    char pos = (row == 1) ? 0x80 + column - 1 : 0xC0 + column - 1;
    LCD_Cmd(pos);
}

void LCD_Init() {
    TRISD = 0x00;
    __delay_ms(20);
    LCD_Cmd(0x02);  // 4-bit mode
    LCD_Cmd(0x28);  // 2 line, 5x7 matrix
    LCD_Cmd(0x0C);  // Display on, cursor off
    LCD_Cmd(0x06);  // Increment cursor
    LCD_Cmd(0x01);  // Clear display
    __delay_ms(2);
}
