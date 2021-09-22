/*------------------------------------------------------------------------------
* Author:       Jaiden Gann
* Lab Section:  03
* Date:         8/28/21
* File:         Lab1_Q1.c
* Program:      Multiplication by addition
* Input:        None
* Output:       The product of two numbers
* Description:  This C program calculates the mutliplication of two numbers
                by addition using a for loop
*-----------------------------------------------------------------------------*/
#include <"msp430.h">
#include <stdio.h>

int main(void)
{
    WDTCTL = WDTPW + WDTHOLD;   //watchdog timer
    // setup numbers
    int number1 = 32;
    int number2 = 4;
    int counter;          //counter
    int answer = 0;          //answer

    for (counter = 1; counter <= number2; counter++)
    {
        answer = answer + number1;
    }

    printf(" %d times %d is %d\n",number1,number2,answer);

    return 0;
}

