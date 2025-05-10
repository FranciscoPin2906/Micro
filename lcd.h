/*
 * File:   lcd.h
 * Author: yuliana
 *
 * Created on 24 de abril de 2025, 01:55 PM
 */

#ifndef LCD_H
#define	LCD_H

#ifdef	__cplusplus
extern "C" {
#endif

#include <xc.h>
#include "config.h"

// Definición de pines
#define RS LATD0
#define EN LATD1
#define ldata LATD
#define LCD_Port TRISD

#define CMD_CLEAR_LCD 0x01

void LCD_Init(void);
void LCD_Cmd(unsigned char);  // o LCD_Command si prefieres
void LCD_Char(unsigned char);
void LCD_String(const char *);
void LCD_String_xy(char, char, const char *);
void LCD_Clear(void);
void LCD_Set_Cursor(unsigned char row, unsigned char column);

#ifdef	__cplusplus
}
#endif

#endif	/* LCD_H */
