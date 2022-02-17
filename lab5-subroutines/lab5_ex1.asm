;=======================================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 5, ex 1
; Lab section: <omitted>
; TA: <omitted>
;=======================================================================
.ORIG x3000
; Instructions ---------------------------------------------------------
	LD R1, ARRAY_ADDR					; Load the starting address of the array
	
	AND R3, R3, #0		
	ADD R3, R3, #1						; Beginning value (1) to store into the array
	LD R4, fillCount	
	
FILL_LOOP
	STR R3, R1, #0						; Store hardcoded value into array
	ADD R1, R1, #1						; Increment address within array
	ADD R3, R3, R3						; Double hardcoded value to store, simulating 2^n
	
	ADD R4, R4, #-1
	BRp FILL_LOOP

	LD R1, ARRAY_ADDR					; Reload the starting address of the array
	LD R4, fillCount
	
OUTPUT_LOOP
	LDR R2, R1, #0
	
	LD R6, SUB_PRINT_BINARY				; Subroutine to print MEM[R2]
	JSRR R6								
	
	ADD R1, R1, #1
	
	ADD R4, R4, #-1
	BRp OUTPUT_LOOP

	HALT
	
; Local Data -----------------------------------------------------------
	SUB_PRINT_BINARY	.FILL		x3200
	
	ARRAY_ADDR			.FILL		x4000
	fillCount			.FILL		#10
	
; Remote Data ----------------------------------------------------------
.ORIG x4000
	.BLKW		#10
	
;=======================================================================
; SUBROUTINE: SUB_PRINT_BINARY
; Parameter (R2): the value to print to console in binary format
; Postcondition: the subroutine has printed MEM[R2] to console as a
;                string of ASCII 0's and 1's
; Return Value: none
;=======================================================================
.ORIG x3200
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3200
;	ST R1, R1_BACKUP_3200
	ST R2, R2_BACKUP_3200
	ST R3, R3_BACKUP_3200
	ST R4, R4_BACKUP_3200
;	ST R5, R5_BACKUP_3200
;	ST R6, R6_BACKUP_3200
	ST R7, R7_BACKUP_3200

; Subroutine Algorithm
	LD R3, bitCounter					; Counter to group up bits (4 bits)
	LD R4, printCounter					; Counter for how many bits to print (16 bits in total)
	
PRINT_LOOP
	ADD R0, R2, #0
	BRn PRINT_ONE						; Skips to load the character '1' to print if the bit is a 1
	
; PRINT_ZERO
	LD R0, zero							; Loads the character '0' to print
	BR OUTPUT							; Skips loading the character '1' to print
	
PRINT_ONE
	LD R0, one							; Loads the character '1' to print
	
OUTPUT
	OUT
	
	ADD R2, R2, R2						; Shifts the bits to the left to print the next bit
	
	ADD R4, R4, #-1
	BRnz SKIP_PRINT_SPACE				; Skip printing a space if it's the end of bit string
	
	ADD R3, R3, #-1
	BRnp SKIP_PRINT_SPACE				; Skip printing a space if it's not the end of 4 bits
	
; PRINT_SPACE
	LD R0, space						; Prints a space to console
	OUT									; (after 4 bits but not at the end of the bit string)
	
	LD R3, bitCounter					; Resets the bit counter (4 bits)
	
SKIP_PRINT_SPACE
	ADD R4, R4, #0	
	BRp PRINT_LOOP						; Checks if it's necessary to keep printing the bit string
	
	LD R0, newline						; Prints a newline to console after the bit string has been printed
	OUT

; Restore backup
	LD R0, R0_BACKUP_3200
;	LD R1, R1_BACKUP_3200
	LD R2, R2_BACKUP_3200
	LD R3, R3_BACKUP_3200
	LD R4, R4_BACKUP_3200
;	LD R5, R5_BACKUP_3200
;	LD R6, R6_BACKUP_3200
	LD R7, R7_BACKUP_3200
	
; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_3200		.BLKW		#1
;	R1_BACKUP_3200		.BLKW		#1
	R2_BACKUP_3200		.BLKW		#1
	R3_BACKUP_3200		.BLKW		#1
	R4_BACKUP_3200		.BLKW		#1
;	R5_BACKUP_3200		.BLKW		#1
;	R6_BACKUP_3200		.BLKW		#1
	R7_BACKUP_3200		.BLKW		#1
	
	space				.FILL		x20
	newline				.FILL		x0A
	zero				.FILL		x30
	one					.FILL		x31
	bitCounter			.FILL		#4
	printCounter		.FILL		#16
	
;=======================================================================
; END SUBROUTINE
;=======================================================================
.END
