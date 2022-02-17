;=======================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Assignment name: Assignment 4
; Lab section: <omitted>
; TA: <omitted>
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R1
;=================================================================================
.ORIG x3000		
;Instructions ----------------------------------------------------------
	BR BEGIN_PROGRAM	; Jump to the beginning of the program

; Print a newline and then the error prompt
RESTART
	LD R0, newline
	OUT
	LD R0, errorMessagePtr
	PUTS
	
; Output intro prompt
BEGIN_PROGRAM
	LD R0, introPromptPtr
	PUTS
	
; Set up flags, counters, accumulators as needed
	AND R1, R1, #0		; Where final value will be stored
	LD R4, multiplier	; Used as a counter for a loop to multiply a value by 10
	LD R5, digitCount	; Maximum digit count (5 digits)
	AND R6, R6, #0		; Negative flag (0 for positive, 1 for negative)
	
; Get first character, test for '\n', '+', '-', digit/non-digit: 	
	GETC
	OUT
					
	; Is very first character = '\n'? if so, just quit (no message)!
	LD R2, newline		; 2's complement conversion of '\n'
	NOT R2, R2	
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRz END_PROGRAM		
	
	; Is it = '+'? if so, ignore it, go get digits
	LD R2, plus			; 2's complement conversion of '+'
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRz GET_DIGITS		
	
	; Is it = '-'? if so, set neg flag, go get digits
	LD R2, dash			; 2's complement conversion of '-'
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRz SET_NEGATIVE_FLAG
	
	; Is it < '0'? if so, it is not a digit	- o/p error message, start over
	LD R2, zero			; 2's complement conversion of '0'
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRn RESTART
	
	; Is it > '9'? if so, it is not a digit	- o/p error message, start over
	LD R2, nine			; 2's complement conversion of '9'
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRp RESTART
	
	; If none of the above, first character is first numeric digit - convert it to number & store in target register
	LD R2, zero
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R1, R0, R2		; Add inputted value to R1 (register to store final value)
	
	ADD R5, R5, #-1		; Decrement remaining digits left to store (max 5)
	
	BR GET_DIGITS
	
; Set negative flag if first character was '-'
SET_NEGATIVE_FLAG
	ADD R6, R6, #1
	
; Now get remaining digits (max 5) from user, testing each to see if it is a digit, and build up number in accumulator
GET_DIGITS
	GETC
	OUT
	
	; Sentinel character check (ENTER)
	LD R2, newline
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRz END_PROGRAM
	
	; Input validation (checks if only characters '0' to '9' have been inputted)
	LD R2, zero			
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRn RESTART
	
	LD R2, nine
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRp RESTART
	
	AND R3, R3, #0		; Hardcodes R3 with the value 0 as it will be used to
						; temporarily store a value in the following loop

; Multiply current value in R1 by 10 (using R3 to temporarily store the value)
; before adding another digit
MULTIPLY_BY_TEN
	ADD R3, R3, R1
	
	ADD R4, R4, #-1
	BRp MULTIPLY_BY_TEN
	
	LD R4, multiplier	; Reset counter for multiplier loop
	ADD R1, R3, #0		; Load multiplied value (temporarily stored in R3) into R1
	
	LD R2, zero
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R0, R0, R2		; Convert character input from ASCII to decimal
	ADD R1, R1, R0		; Add decimal value to R1 (register to store final value)
	
	ADD R5, R5, #-1
	BRp GET_DIGITS
	
	LD R0, newline		; End with a newline if newline has not been inputted
	OUT

END_PROGRAM
	ADD R6, R6, #0		
	BRz SKIP_NEGATIVE	; Branch to the end of the program if negative flag has not been set to 1
	
	NOT R1, R1			; 2's complement conversion of value stored in R1
	ADD R1, R1, #1
	
SKIP_NEGATIVE
					
	HALT

; Local Data -----------------------------------------------------------
	introPromptPtr		.FILL 		xA800
	errorMessagePtr		.FILL 		xA900
	newline				.FILL		x0A
	plus				.FILL 		x2B
	dash				.FILL		x2D
	zero				.FILL 		x30
	nine				.FILL 		x39
	digitCount			.FILL 		#5
	multiplier			.FILL		#10

; Remote data ----------------------------------------------------------
.ORIG xA800				; Intro prompt
	.STRINGZ			"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
						
.ORIG xA900				; Error message
	.STRINGZ			"ERROR! invalid input\n"

.END

;-----------------------------------------------------------------------
; PURPOSE OF PROGRAM
;-----------------------------------------------------------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
