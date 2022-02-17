;=======================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Assignment name: Assignment 2
; Lab section: <omitted>
; TA: <omitted>
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=======================================================================

.ORIG x3000			; Program begins here
;-----------------------------------------------------------------------
;Instructions
;-----------------------------------------------------------------------

;-----------------------------------------------------------------------
;output prompt
;-----------------------------------------------------------------------
	LEA R0, intro		; get starting address of prompt string
	PUTS			; Invokes BIOS routine to output string

;-----------------------------------------------------------------------
;INSERT YOUR CODE here
;-----------------------------------------------------------------------
	; Get first number
	GETC 
	OUT
	
	ADD R1, R0, #0
	
	LD R0, newline
	OUT
	
	; Get second number
	GETC
	OUT
	
	ADD R2, R0, #0
	
	LD R0, newline
	OUT

	; Output equation
	ADD R0, R1, #0
	OUT
	
	LEA R0, subtract
	PUTS
	
	ADD R0, R2, #0
	OUT
	
	LEA R0, equals
	PUTS
	
	; Convert inputs from ASCII to decimal
	LD R0, zero 		; 2's complement for ASCII offset
	NOT R0, R0
	ADD R0, R0, #1
	
	ADD R1, R1, R0 		; Converts first input to decimal
	ADD R2, R2, R0 		; Converts second input to decimal
	
	NOT R2, R2 		; 2's complement for second input
	ADD R2, R2, #1
	
	ADD R1, R1, R2 		; Subtract second input from first input
	
	ADD R1, R1, #0 		; Checks if result is negative
	BRzp SKIP_NEGATIVE 	; Skips to output result

	LD R0, negative
	OUT
	
	NOT R1, R1 		; Converts negative result to positive to print later
	ADD R1, R1, #1

SKIP_NEGATIVE
	LD R0, zero
	ADD R0, R0, R1 		; Converts decimal back to a character to print
	OUT
	
	LD R0, newline
	OUT

	HALT			; Stop execution of program
;-----------------------------------------------------------------------
;Data
;-----------------------------------------------------------------------
; String to prompt user. Note: already includes terminating newline!
	intro 		.STRINGZ		"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
	newline 	.FILL 			'\n'	; newline character - use with LD followed by OUT
	subtract	.STRINGZ		" - "
	negative	.FILL			'-'
	equals		.STRINGZ		" = "
	zero		.FILL			x30


;-----------------------------------------------------------------------	
;END of PROGRAM
;-----------------------------------------------------------------------
.END

