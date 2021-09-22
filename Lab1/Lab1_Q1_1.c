/*------------------------------------------------------------------------------
* Author:       Jaiden Gann
* Lab Section:  03
* Date:         8/26/21
* File:         Lab1_Q1_1.c
* Program:      Multiplication by addition
* Input:        None
* Output:       The product of two numbers
* Description:  This C program calculates the mutliplication of two numbers
                by addition using a recursive function
*-----------------------------------------------------------------------------*/
#include<stdio.h>
#include"msp430.h"

int mult(int a, int b);


int main()
{
    WDTCTL = WDTPW + WDTHOLD;   //watchdog timer
    // setup numbers
    int num1 = 32;
    int num2 = 42;
    int answer;

    answer = mult(num1, num2);
    printf("%d times %d is %d", num1, num2, answer);
    return 0;
}
int mult(int num1, int num2)
{
    int result;

    if (num2 == 1)
    {
        return num1;
    }

    result = num1 + mult(num1, num2 - 1);
    return result;
}
