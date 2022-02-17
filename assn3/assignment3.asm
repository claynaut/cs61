;=======================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Assignment name: Assignment 3
; Lab section: <omitted>
; TA: <omitted>
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=======================================================================

.ORIG x3000						; Program begins here
;-----------------------------------------------------------------------
;Instructions
;-----------------------------------------------------------------------
	LD R6, Value_ptr				; R6 <-- pointer to value to be displayed as binary
	LDR R1, R6, #0					; R1 <-- value to be displayed as binary 
	
;-----------------------------------------------------------------------
;INSERT CODE STARTING FROM HERE
;-----------------------------------------------------------------------
	LD R2, bitCounter				; Counter to group up bits (4 bits)
	LD R3, printCounter				; Counter for how many bits to print (16 bits in total)
	
PRINT_LOOP
	ADD R0, R1, #0
	BRn PRINT_ONE					; Skips to load the character '1' to print if the bit is a 1
	
; PRINT_ZERO
	LD R0, zero					; Loads the character '0' to print
	BR OUTPUT					; Skips loading the character '1' to print
	
PRINT_ONE
	LD R0, one					; Loads the character '1' to print
	
OUTPUT
	OUT
	
	ADD R1, R1, R1					; Shifts the bits to the left to print the next bit

	ADD R3, R3, #-1
	BRnz SKIP_PRINT_SPACE				; Skip printing a space if it's the end of bit string
	
	ADD R2, R2, #-1
	BRnp SKIP_PRINT_SPACE				; Skip printing a space if it's not the end of 4 bits
	
; PRINT_SPACE
	LD R0, space					; Prints a space to console
	OUT						; (after 4 bits but not at the end of the bit string)
	
	LD R2, bitCounter				; Resets the bit counter (4 bits)
	
SKIP_PRINT_SPACE
	ADD R3, R3, #0	
	BRp PRINT_LOOP					; Checks if it's necessary to keep printing the bit string
	
	LD R0, newline					; Prints a newline to console after the bit string has been printed
	OUT

	HALT
;-----------------------------------------------------------------------
;Data
;-----------------------------------------------------------------------
	Value_ptr		.FILL 		xB270	; The address where value to be displayed is stored
	space			.FILL		x20
	newline			.FILL		x0A
	zero			.FILL		x30
	one			.FILL		x31
	bitCounter		.FILL		#4
	printCounter		.FILL		#16

.ORIG xB270								; Remote data
	Value 			.FILL		xABCD	; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
	
;-----------------------------------------------------------------------
;END of PROGRAM
;-----------------------------------------------------------------------
.END
