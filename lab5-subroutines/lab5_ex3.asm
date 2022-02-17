;=======================================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 5, ex 3
; Lab section: <omitted>
; TA: <omitted>
;=======================================================================
.ORIG x3000
; Instructions ---------------------------------------------------------
	LD R6, SUB_READ_BINARY
	JSRR R6

	LD R0, newline				; Newline separates user input/print
	OUT
	
	LD R6, SUB_PRINT_BINARY			; Subroutine to print MEM[R2]
	JSRR R6	

	HALT
	
; Local Data -----------------------------------------------------------
	SUB_READ_BINARY		.FILL		x3200
	SUB_PRINT_BINARY	.FILL		x3400
	
	newline			.FILL		x0A
	
;=======================================================================
; SUBROUTINE: SUB_READ_BINARY
; Parameter: none
; Postcondition: the subroutine translates the string of ASCII 0's and
;		 1's inputted by the user into a single 16-bit value 
;		 which is stores into R2
; Return Value (R2): the single 16-bit value translated from a string of
;		     ASCII 0's and 1's
;=======================================================================
.ORIG x3200
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3200
	ST R1, R1_BACKUP_3200
;	ST R2, R2_BACKUP_3200
	ST R3, R3_BACKUP_3200
;	ST R4, R4_BACKUP_3200
;	ST R5, R5_BACKUP_3200
;	ST R6, R6_BACKUP_3200
	ST R7, R7_BACKUP_3200

; Subroutine Algorithm
	AND R2, R2, #0				; Register to store the 16-bit value from the user
	LD R3, bitCounter_3200			; Counter for the loop to get the remaining 16 characters
	
	BR GET_INITIAL_CHAR
	
INITIAL_CHAR_ERROR				; Branch to to print error message when initial character
	LEA R0, initialErrorMsg			; isn't 'b'
	PUTS

GET_INITIAL_CHAR
	GETC					; Get the initial 'b' from the user
	OUT
	
	LD R1, initialChar			; 2's complement of the character 'b'
	NOT R1, R1
	ADD R1, R1, #1
	
	ADD R1, R1, R0
	BRnp INITIAL_CHAR_ERROR			; Checks if the initial input was 'b', otherwise
						; jumps to print the error message and 
						; re-prompts the user until 'b' is inputted
	
GET_BINARY					; Get the remaining 16 characters from the user
	ADD R2, R2, R2				; Left shifts MEM[R2]
	
	BR GET_INPUT
	
INVALID_INPUT_ERROR				; Branch to print error message for invalid input
	LEA R0, inputErrorMsg				
	PUTS
	
GET_INPUT					; Branch to get input without left shifting MEM[R2]
	GETC
	OUT
	
	LD R1, space_3200			; 2's complement of ASCII space
	NOT R1, R1
	ADD R1, R1, #1
	
	ADD R1, R1, R0						
	BRz SPACE				; Checks if user inputted ' ' and jumps to that case
	
	LD R1, zero_3200			; 2's complement of ASCII 0
	NOT R1, R1
	ADD R1, R1, #1
	
	ADD R1, R1, R0						
	BRz BINARY_ZERO				; Checks if user inputted '0' and jumps to that case
	
	LD R1, one_3200				; 2's complement of ASCII 1
	NOT R1, R1
	ADD R1, R1, #1
	
	ADD R1, R1, R0						
	BRz BINARY_ONE				; Checks if user inputted '1' and jumps to that case
	
	BR INVALID_INPUT_ERROR
	
SPACE						; If user inputted ' ', get another input from the user
	BR GET_INPUT				; without changing MEM[R2]

BINARY_ONE					; If user inputted '1', add 1 to MEM[R2]
	ADD R2, R2, #1						

BINARY_ZERO					; If user inputted '0', nothing is added to MEM[R2]
	ADD R3, R3, #-1
	BRp GET_BINARY

; Restore backup
	LD R0, R0_BACKUP_3200
	LD R1, R1_BACKUP_3200
;	LD R2, R2_BACKUP_3200
	LD R3, R3_BACKUP_3200
;	LD R4, R4_BACKUP_3200
;	LD R5, R5_BACKUP_3200
;	LD R6, R6_BACKUP_3200
	LD R7, R7_BACKUP_3200
	
; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_3200		.BLKW		#1
	R1_BACKUP_3200		.BLKW		#1
;	R2_BACKUP_3200		.BLKW		#1
	R3_BACKUP_3200		.BLKW		#1
;	R4_BACKUP_3200		.BLKW		#1
;	R5_BACKUP_3200		.BLKW		#1
;	R6_BACKUP_3200		.BLKW		#1
	R7_BACKUP_3200		.BLKW		#1
	
	initialErrorMsg		.STRINGZ	"\nERROR: Initial character should be 'b'!\n"
	inputErrorMsg		.STRINGZ	"\nERROR: Input a valid character ('0' or '1' or SPACE)!\n"
	bitCounter_3200		.FILL		#16
	initialChar		.FILL		x62
	space_3200		.FILL		x20
	zero_3200		.FILL		x30
	one_3200		.FILL		x31
	
;=======================================================================
; END SUBROUTINE
;=======================================================================

;=======================================================================
; SUBROUTINE: SUB_PRINT_BINARY
; Parameter (R2): the value to print to console in binary format
; Postcondition: the subroutine has printed MEM[R2] to console as a
;                string of ASCII 0's and 1's
; Return Value: none
;=======================================================================
.ORIG x3400
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3400
;	ST R1, R1_BACKUP_3400
	ST R2, R2_BACKUP_3400
	ST R3, R3_BACKUP_3400
	ST R4, R4_BACKUP_3400
;	ST R5, R5_BACKUP_3400
;	ST R6, R6_BACKUP_3400
	ST R7, R7_BACKUP_3400

; Subroutine Algorithm
	LD R3, bitCounter_3400			; Counter to group up bits (4 bits)
	LD R4, printCounter_3400		; Counter for how many bits to print (16 bits in total)
	
PRINT_LOOP
	ADD R0, R2, #0
	BRn PRINT_ONE				; Skips to load the character '1' to print if the bit is a 1

; PRINT_ZERO
	LD R0, zero_3400			; Loads the character '0' to print
	BR OUTPUT				; Skips loading the character '1' to print
	
PRINT_ONE
	LD R0, one_3400				; Loads the character '1' to print
	
OUTPUT
	OUT
	
	ADD R2, R2, R2				; Shifts the bits to the left to print the next bit
	
	ADD R4, R4, #-1
	BRnz SKIP_PRINT_SPACE			; Skip printing a space if it's the end of bit string
	
	ADD R3, R3, #-1
	BRnp SKIP_PRINT_SPACE			; Skip printing a space if it's not the end of 4 bits
	
; PRINT_SPACE
	LD R0, space_3400			; Prints a space to console
	OUT					; (after 4 bits but not at the end of the bit string)
	
	LD R3, bitCounter_3400			; Resets the bit counter (4 bits)
	
SKIP_PRINT_SPACE
	ADD R4, R4, #0	
	BRp PRINT_LOOP				; Checks if it's necessary to keep printing the bit string
	
	LD R0, newline_3400			; Prints a newline to console after the bit string has been printed
	OUT

; Restore backup
	LD R0, R0_BACKUP_3400
;	LD R1, R1_BACKUP_3400
	LD R2, R2_BACKUP_3400
	LD R3, R3_BACKUP_3400
	LD R4, R4_BACKUP_3400
;	LD R5, R5_BACKUP_3400
;	LD R6, R6_BACKUP_3400
	LD R7, R7_BACKUP_3400
	
; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_3400		.BLKW		#1
;	R1_BACKUP_3400		.BLKW		#1
	R2_BACKUP_3400		.BLKW		#1
	R3_BACKUP_3400		.BLKW		#1
	R4_BACKUP_3400		.BLKW		#1
;	R5_BACKUP_3400		.BLKW		#1
;	R6_BACKUP_3400		.BLKW		#1
	R7_BACKUP_3400		.BLKW		#1
	
	space_3400		.FILL		x20
	newline_3400		.FILL		x0A
	zero_3400		.FILL		x30
	one_3400		.FILL		x31
	bitCounter_3400		.FILL		#4
	printCounter_3400	.FILL		#16
	
;=======================================================================
; END SUBROUTINE
;=======================================================================
.END
