;-------------------------------------------------------------------------------
; Author:       Jaiden Gann
; Lab Section:  03
; Date:         9/17/21
; File:         Lab4_Q1.c
; Program:      Count Symbols in String
; Input:        Input string specified in myStr
; Output:       Register 5 holds the symbol count
; Description:  This assembly program counts the number of symbols excluding
;				characters and numerals by comparing each character in the string
;				to see if it falls in the range of wanted characters
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file
            
;-------------------------------------------------------------------------------
            .def    RESET                   ; Export program entry-point to
											; make it known to linker.
			.data
symb_count:	.int 0;
myStr:	.string "H! #money$", ''			;expected count 4 (counts space)
;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory.
            .retain                         ; Override ELF conditional linking
                                            ; and retain current section.
            .retainrefs                     ; And retain any sections that have
                                            ; references to current section.
;-------------------------------------------------------------------------------
RESET:       mov.w   #__STACK_END,SP         ; Initialize stackpointer
			 mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
; Main loop here
;-------------------------------------------------------------------------------
main:	mov.w #myStr, R4					;puts string in R4
		mov.w #symb_count, R5				;places counter in R5
		clr.w R5							;register for counter

gnext:	mov.b @R4+, R6						;increment, get character put in R6
		cmp #0, R6							; check for NULL
		jeq lend							; if NULL go to lend subroutine

		;Notes: want everything below 0 and above z
		;want between Z and a and want between 9 and A
		;;everything below 0
		cmp.b #'0', R6						;check if number (low end)
		jl counter_up						;jump to counter_up if less than 0
		;everything above z
		cmp.b #'{', R6						;z is the last/highest character in Hex
											;thus the next character,{, if greater or equal
		jge counter_up						;jump to counter_up if greater or equal to {
		;between Z and a
		cmp.b #'a', R6						;check to see if a
		jl capitalZ_check					;if less than 'a' jump to capital Z check
		;between 9 and A
		cmp.b #':', R6						;check if above range of number
		jge capitalA_check					;if greater than or equal to : jump to A check

capitalZ_check:
		cmp.b #'[', R6						;[ is one up from Z, checking for that
		jge counter_up						;if greater than or equal to [ jump to symb
											;because we tested for anything below a (61h)
		jmp gnext							;else look at next character
capitalA_check:
		cmp.b #'A', R6						;check if a capital A
		jl	counter_up						;if less than jump to symb count
											;because we've already tested that we're above 9
		jmp gnext							;else look at next character
counter_up:
		inc.w R5							;increment the counter
		jmp gnext							;starts process again

lend:
		;mov.w R5,&counter_up			;memory address of counter_up gets contents of R5
		nop

;-------------------------------------------------------------------------------
; Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect   .stack

;-------------------------------------------------------------------------------
; Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
            .end
