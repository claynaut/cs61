;=======================================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 6, ex 3
; Lab section: <omitted>
; TA: <omitted>
;=======================================================================
.ORIG x3000
; Instructions ---------------------------------------------------------
	LD R1, STRING_ADDR			; Starting address of character array
	
	LD R6, SUB_GET_STRING			; Fill array w/ characters from the user
	JSRR R6
	
	LD R6, SUB_IS_PALINDROME
	JSRR R6
	
	LD R0, STRING_ADDR			; Print character array
	PUTS
	
	ADD R4, R4, #0
	BRz NOT_A_PALINDROME			; Branch to print message if not a palindrome
	
	LEA R0, palindromeTrueMsg
	PUTS
	
	BR END_MESSAGE

NOT_A_PALINDROME
	LEA R0, palindromeFalseMsg
	PUTS

END_MESSAGE
	
	HALT

; Local Data -----------------------------------------------------------
	SUB_GET_STRING		.FILL		x3200
	SUB_IS_PALINDROME	.FILL		x3400
	
	STRING_ADDR		.FILL		x4000
	palindromeTrueMsg	.STRINGZ	" is a palindrome!\n"
	palindromeFalseMsg	.STRINGZ	" is NOT a palindrome!\n"
	
; Remote Data ----------------------------------------------------------
.ORIG x4000
	.BLKW		#100

;=======================================================================
; SUBROUTINE: SUB_GET_STRING
; Parameter (R1): the starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;		 terminated by the [ENTER] key (the "sentinel"), and has stored
;		 the received characters in an array of characters starting at (R1).
;		 The array is NULL-terminated. The sentinel character is NOT stored.
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
	
	LD R2, newline_3200			; 2's complement of '\n' used to
	NOT R2, R2				; check for sentinel character (ENTER)
	ADD R2, R2, #1
	
GET_USER_INPUT
	GETC
	OUT
	
	ADD R3, R0, R2				; Checks for sentinel character
	BRz STOP_USER_INPUT			; Prevents sentinel character from being stored into the array
	
	STR R0, R1, #0				; Store user input
	
	ADD R1, R1, #1
	ADD R5, R5, #1
	
	BR GET_USER_INPUT
	
STOP_USER_INPUT
	AND R0, R0, #0				; Hard-code zero value into R0
	
	ADD R1, R1, #1
	STR R0, R1, #0				; Terminate array with NULL

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

;=======================================================================
; SUBROUTINE: SUB_IS_PALINDROME
; Parameter (R1): the starting address of a null-terminated string
; Parameter (R5): the number of characters in the array
; Postcondition: The subroutine has determined whether the string at (R1) is
;		 a palindrome or not, and returned a flag to that effect.
; Return Value (R4): 1 if the string is a palindrome, 0 otherwise
;=======================================================================
.ORIG x3400
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3400
	ST R1, R1_BACKUP_3400
	ST R2, R2_BACKUP_3400
	ST R3, R3_BACKUP_3400
;	ST R4, R4_BACKUP_3400
	ST R5, R5_BACKUP_3400
	ST R6, R6_BACKUP_3400
	ST R7, R7_BACKUP_3400

; Subroutine Algorithm
	LD R6, SUB_TO_UPPER
	JSRR R6
	
	AND R4, R4, #0
	
	ADD R0, R1, R5						
	ADD R0, R0, #-1				; Ending address of character array
	
CHECK_IF_PALINDROME
	ADD R6, R0, #0				; Use R6 as a temporary register to store starting address
	NOT R6, R6				; and perform 2's complement
	ADD R6, R6, #1
	
	ADD R6, R6, R1				; Check if starting and ending addresses match, and if so,
	BRz IS_A_PALINDROME			; the character array is a palindrome
	
	ADD R6, R6, #1				; Check if middle had been reached for an even-sized array
	BRz IS_A_PALINDROME	

	LDR R2, R1, #0				; Load first character (starting from beginning to middle of array)
	
	LDR R3, R0, #0				; Load second character (starting from end to middle of array)
	NOT R3, R3				; Perform 2's complement to compare characters
	ADD R3, R3, #1
	
	ADD R6, R2, R3				; Check if first and second character are the same,
	BRnp NOT_A_PALINDROME_3400		; otherwise character array is not a palindrome
	
	ADD R1, R1, #1				; Increment towards middle address of character array
	ADD R0, R0, #-1
	
	BR CHECK_IF_PALINDROME
	
IS_A_PALINDROME
	ADD R4, R4, #1
	
NOT_A_PALINDROME_3400

; Restore Backup
	LD R0, R0_BACKUP_3400
	LD R1, R1_BACKUP_3400
	LD R2, R2_BACKUP_3400
	LD R3, R3_BACKUP_3400
;	LD R4, R4_BACKUP_3400
	LD R5, R5_BACKUP_3400
	LD R6, R6_BACKUP_3400
	LD R7, R7_BACKUP_3400

; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_3400		.BLKW		#1
	R1_BACKUP_3400		.BLKW		#1
	R2_BACKUP_3400		.BLKW		#1
	R3_BACKUP_3400		.BLKW		#1
;	R4_BACKUP_3400		.BLKW		#1
	R5_BACKUP_3400		.BLKW		#1
	R6_BACKUP_3400		.BLKW		#1
	R7_BACKUP_3400		.BLKW		#1
	
	SUB_TO_UPPER		.FILL		x3600

;=======================================================================
; END SUBROUTINE
;=======================================================================

;=======================================================================
; SUBROUTINE: SUB_TO_UPPER
; Parameter (R1): starting address of a null-terminated string
; Postcondition: The subroutine has converted the string to upper-case ​in-place
;		 (i.e. the upper-case string has replaced the original string).
; Return Value: none
;=======================================================================
.ORIG x3600
; Subroutine Instructions ----------------------------------------------

; Backup 
;	ST R0, R0_BACKUP_3600
	ST R1, R1_BACKUP_3600
	ST R2, R2_BACKUP_3600
	ST R3, R3_BACKUP_3600
;	ST R4, R4_BACKUP_3600
;	ST R5, R5_BACKUP_3600
;	ST R6, R6_BACKUP_3600
	ST R7, R7_BACKUP_3600

; Subroutine Algorithm
	LD R3, uppercaseMask			; Bit mask used to force uppercase (AND x5F)
	
TO_UPPER
	LDR R2, R1, #0
	AND R2, R2, R3
	STR R2, R1, #0
	
	ADD R1, R1, #1
	
	ADD R2, R2, #0
	BRnp TO_UPPER

; Restore Backup
;	LD R0, R0_BACKUP_3600
	LD R1, R1_BACKUP_3600
	LD R2, R2_BACKUP_3600
	LD R3, R3_BACKUP_3600
;	LD R4, R4_BACKUP_3600
;	LD R5, R5_BACKUP_3600
;	LD R6, R6_BACKUP_3600
	LD R7, R7_BACKUP_3600

; Return
	RET
	
; Local Data -----------------------------------------------------------
;	R0_BACKUP_3600		.BLKW		#1
	R1_BACKUP_3600		.BLKW		#1
	R2_BACKUP_3600		.BLKW		#1
	R3_BACKUP_3600		.BLKW		#1
;	R4_BACKUP_3600		.BLKW		#1
	R5_BACKUP_3600		.BLKW		#1
	R6_BACKUP_3600		.BLKW		#1
	R7_BACKUP_3600		.BLKW		#1
	
	uppercaseMask		.FILL		x5F

;=======================================================================
; END SUBROUTINE
;=======================================================================
.END
