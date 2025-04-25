/*
 * File:   gps.h
 * Author: yuliana
 *
 * Created on 24 de abril de 2025, 04:13 PM
 */

#ifndef GPS_H
#define GPS_H

void UART_Init(void);
char UART_Read(void);
void GPS_Read_Line(char* buffer);
void parseGPGGA(char* sentence);

#endif
