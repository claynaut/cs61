;=======================================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 7, ex 2
; Lab section: <omitted>
; TA: <omitted>
;=======================================================================
.ORIG x3000
; Instructions ---------------------------------------------------------
REPEAT_TEST_HARNESS
	LEA R0, promptMsg			; Prompt user to input a single character
	PUTS
	
	GETC
	OUT

	ADD R1, R0, #0				; Copy user input into R1 to pass into SUB_PARITY_CHECK
	
	LD R0, newline
	OUT

	LD R6, SUB_PARITY_CHECK
	JSRR R6
	
	LEA R0, onesMsgPt1
	PUTS
	
	ADD R0, R1, #0				; Print original user input
	OUT
	
	LEA R0, onesMsgPt2
	PUTS
	
	LD R0, zero				; Print number of 1's in user input
	ADD R0, R0, R2
	OUT
	
	LD R0, newline
	OUT
	LD R0, newline
	OUT
	
	BR REPEAT_TEST_HARNESS			; Infinitely loops test harness
	
	HALT
	
; Local Data -----------------------------------------------------------
	SUB_PARITY_CHECK	.FILL		x3200
	
	promptMsg		.STRINGZ	"Input a single character: "
	onesMsgPt1		.STRINGZ	"The number of 1's in \""
	onesMsgPt2		.STRINGZ	"\" is: "
	newline			.FILL		x0A
	zero			.FILL		x30

;=======================================================================
; SUBROUTINE: SUB_PARITY_CHECK
; Parameter (R1): character inputted by the user
; Postcondition: The subroutine counts the number of binary 1's are in the
;		 input character and stores the count in the return register (R2)
; Return Value (R2): the hard-coded value
;=======================================================================
.ORIG x3200
; Subroutine Instructions ----------------------------------------------

; Backup 
;	ST R0, R0_BACKUP_3200
	ST R1, R1_BACKUP_3200
;	ST R2, R2_BACKUP_3200
	ST R3, R3_BACKUP_3200
;	ST R4, R4_BACKUP_3200
;	ST R5, R5_BACKUP_3200
;	ST R6, R6_BACKUP_3200
	ST R7, R7_BACKUP_3200

; Subroutine Algorithm
	AND R2, R2, #0
	LD R3, binaryCounter
	
PARITY_CHECK
	ADD R1, R1, #0
	BRzp SKIP_INCREMENT			; Increments return value only if there
						; is a leading 1, meaning the value is negative
	
	ADD R2, R2, #1				
	
SKIP_INCREMENT

	ADD R1, R1, R1				; Left shift binary value
	
	ADD R3, R3, #-1
	BRzp PARITY_CHECK

; Restore Backup
;	LD R0, R0_BACKUP_3200
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
;	R0_BACKUP_3200		.BLKW		#1
	R1_BACKUP_3200		.BLKW		#1
;	R2_BACKUP_3200		.BLKW		#1
	R3_BACKUP_3200		.BLKW		#1
;	R4_BACKUP_3200		.BLKW		#1
;	R5_BACKUP_3200		.BLKW		#1
;	R6_BACKUP_3200		.BLKW		#1
	R7_BACKUP_3200		.BLKW		#1
	
	binaryCounter		.FILL		#16

;=======================================================================
; END SUBROUTINE
;=======================================================================
.END
