;=======================================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 6, ex 1
; Lab section: <omitted>
; TA: <omitted>
;=======================================================================
.ORIG x3000
; Instructions ---------------------------------------------------------
	LD R1, STRING_ADDR					; Starting address of character array
	
	LD R6, SUB_GET_STRING				; Fill array w/ characters from the user
	JSRR R6
	
	LD R0, STRING_ADDR					; Print character array
	PUTS
	
	HALT

; Local Data -----------------------------------------------------------
	SUB_GET_STRING		.FILL		x3200
	
	STRING_ADDR			.FILL		x4000
	
; Remote Data ----------------------------------------------------------
.ORIG x4000
						.BLKW		#100

;=======================================================================
; SUBROUTINE: SUB_GET_STRING
; Parameter (R1): the starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;			     terminated by the [ENTER] key (the "sentinel"), and has stored
;				 the received characters in an array of characters starting at (R1).
;				 The array is NULL-terminated. The sentinel character is NOT stored.
; Return Value (R5): the number of ​non-sentinel​ characters read from the user
;=======================================================================
.ORIG x3200
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3200
	ST R1, R1_BACKUP_3200
	ST R2, R2_BACKUP_3200
	ST R3, R3_BACKUP_3200
;	ST R4, R4_BACKUP_3200
;	ST R5, R5_BACKUP_3200
;	ST R6, R6_BACKUP_3200
	ST R7, R7_BACKUP_3200

; Subroutine Algorithm
	AND R5, R5, #0
	
	LD R2, newline_3200					; 2's complement of '\n' used to
	NOT R2, R2							; check for sentinel character (ENTER)
	ADD R2, R2, #1
	
GET_USER_INPUT
	GETC
	OUT
	
	ADD R3, R0, R2						; Checks for sentinel character
	BRz STOP_USER_INPUT					; Prevents sentinel character from being stored into the array
	
	STR R0, R1, #0						; Store user input
	
	ADD R1, R1, #1
	ADD R5, R5, #1
	
	BR GET_USER_INPUT
	
STOP_USER_INPUT
	AND R0, R0, #0						; Hard-code zero value into R0
	
	ADD R1, R1, #1
	STR R0, R1, #0						; Terminate array with NULL

; Restore Backup
	LD R0, R0_BACKUP_3200
	LD R1, R1_BACKUP_3200
	LD R2, R2_BACKUP_3200
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
	R2_BACKUP_3200		.BLKW		#1
	R3_BACKUP_3200		.BLKW		#1
;	R4_BACKUP_3200		.BLKW		#1
;	R5_BACKUP_3200		.BLKW		#1
;	R6_BACKUP_3200		.BLKW		#1
	R7_BACKUP_3200		.BLKW		#1
	
	newline_3200		.FILL		x0A

;=======================================================================
; END SUBROUTINE
;=======================================================================
.END
