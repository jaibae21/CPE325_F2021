/*------------------------------------------------------------------------------
* Author:       Jaiden Gann
* Lab Section:  03
* Date:         8/26/21
* File:         Lab1_Q2.c
* Program:      Lower Case to Upper Case
* Input:        None
* Output:       Upper case string
* Description:  This C program changes the lower case letters of a sentence
*               to upper case
*-----------------------------------------------------------------------------*/
#include <msp430.h>
#include <stdio.h>


int main()
{
    WDTCTL = WDTPW + WDTHOLD;   //watchdog timer
    // setup array
    char msg[100] = "ThiS cAuse mE heAdacHes.";
    int pos;          //position
    pos = 0;

    while (msg[pos] != '\0')    //checks for null character
    {
        if (msg[pos] >= 'a' && msg[pos] <= 'z')
          {
              msg[pos] = msg[pos] - 32; //adds necessary value to make upper case
          }
        pos++;  //increase counter
    }
    printf("%s\n", msg);

    return 0;
}
