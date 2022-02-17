;=======================================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 7, ex 1
; Lab section: <omitted>
; TA: <omitted>
;=======================================================================
.ORIG x3000
; Instructions ---------------------------------------------------------
	LD R6, SUB_HARD_CODE
	JSRR R6
	
	ADD R1, R1, #1					; Increment value to pass into SUB_PRINT_DECIMAL for printing
	
	LD R6, SUB_PRINT_DECIMAL
	JSRR R6
	
	LD R0, newline
	OUT
	LD R0, newline
	OUT
	
	HALT
	
; Local Data -----------------------------------------------------------
	SUB_HARD_CODE		.FILL		x3200
	SUB_PRINT_DECIMAL	.FILL		x3400
	
	newline				.FILL		x0A

;=======================================================================
; SUBROUTINE: SUB_HARD_CODE
; Parameter: none
; Postcondition: The subroutine loads a hard-coded value into the designated
;				 register, the return value (R1).
; Return Value (R1): the hard-coded value
;=======================================================================
.ORIG x3200
; Subroutine Instructions ----------------------------------------------

; Backup 
;	ST R0, R0_BACKUP_3200
;	ST R1, R1_BACKUP_3200
;	ST R2, R2_BACKUP_3200
;	ST R3, R3_BACKUP_3200
;	ST R4, R4_BACKUP_3200
;	ST R5, R5_BACKUP_3200
;	ST R6, R6_BACKUP_3200
	ST R7, R7_BACKUP_3200

; Subroutine Algorithm
	LD R1, value

; Restore Backup
;	LD R0, R0_BACKUP_3200
;	LD R1, R1_BACKUP_3200
;	LD R2, R2_BACKUP_3200
;	LD R3, R3_BACKUP_3200
;	LD R4, R4_BACKUP_3200
;	LD R5, R5_BACKUP_3200
;	LD R6, R6_BACKUP_3200
	LD R7, R7_BACKUP_3200

; Return
	RET
	
; Local Data -----------------------------------------------------------
;	R0_BACKUP_3200		.BLKW		#1
;	R1_BACKUP_3200		.BLKW		#1
;	R2_BACKUP_3200		.BLKW		#1
;	R3_BACKUP_3200		.BLKW		#1
;	R4_BACKUP_3200		.BLKW		#1
;	R5_BACKUP_3200		.BLKW		#1
;	R6_BACKUP_3200		.BLKW		#1
	R7_BACKUP_3200		.BLKW		#1
	
	value				.FILL		#10101

;=======================================================================
; END SUBROUTINE
;=======================================================================

;=======================================================================
; SUBROUTINE: SUB_PRINT_DECIMAL
; Parameter (R1): the hard-coded value to print
; Postcondition: The subroutine prints the decimal representation of MEM[R1].
; Return Value: none
;=======================================================================
.ORIG x3400
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3400
	ST R1, R1_BACKUP_3400
	ST R2, R2_BACKUP_3400
;	ST R3, R3_BACKUP_3400
;	ST R4, R4_BACKUP_3400
	ST R5, R5_BACKUP_3400
	ST R6, R6_BACKUP_3400
	ST R7, R7_BACKUP_3400

; Subroutine Algorithm
	AND R6, R6, #0					; Toggle value to check if respective decimal
									; place should be printed (if > 0)
	
	ADD R1, R1, #0
	BRzp NOT_NEGATIVE

	LD R0, negativeSign				; Print negative sign
	OUT
	
	NOT R1, R1						; 2's complement of MEM[R1]
	ADD R1, R1, #1
	
NOT_NEGATIVE	

; TEN_THOUSANDTHS_PLACE
	LD R2, tenThousand
	NOT R2, R2
	ADD R2, R2, #1
	
	AND R5, R5, #0

COUNT_TEN_THOUSAND
	ADD R5, R5, #1
	
	ADD R1, R1, R2
	BRzp COUNT_TEN_THOUSAND
	
	ADD R5, R5, #-1					; Subtracts one to account for the loop
									; being run an extra time (runs until MEM[R1] is negative)
	
	LD R2, tenThousand				
	ADD R1, R1, R2					; Adds respective value back to decimal place since the
									; loop runs an extra time until MEM[R1] is negative
									
	ADD R5, R5, #0				
	BRz SKIP_TEN_THOUSANDTHS_TOGGLE
	
	ADD R6, R6, #1

SKIP_TEN_THOUSANDTHS_TOGGLE
	
	ADD R6, R6, #0					; Checks if current decimal place should be printed
	BRz THOUSANDTHS_PLACE			; (won't print if preceding decimal places were leading 0's)
	
; PRINT_TEN_THOUSANDTHS_PLACE	
	LD R0, zero
	ADD R0, R0, R5
	OUT

THOUSANDTHS_PLACE
	LD R2, thousand
	NOT R2, R2
	ADD R2, R2, #1
	
	AND R5, R5, #0

COUNT_THOUSAND
	ADD R5, R5, #1
	
	ADD R1, R1, R2
	BRzp COUNT_THOUSAND
	
	ADD R5, R5, #-1
	
	LD R2, thousand
	ADD R1, R1, R2
	
	ADD R5, R5, #0
	BRz SKIP_THOUSANDTHS_TOGGLE
	
	ADD R6, R6, #1

SKIP_THOUSANDTHS_TOGGLE
	
	ADD R6, R6, #0
	BRz HUNDREDTHS_PLACE
	
; PRINT_THOUSANDTHS_PLACE	
	LD R0, zero
	ADD R0, R0, R5
	OUT

HUNDREDTHS_PLACE
	LD R2, hundred
	NOT R2, R2
	ADD R2, R2, #1
	
	AND R5, R5, #0

COUNT_HUNDRED
	ADD R5, R5, #1
	
	ADD R1, R1, R2
	BRzp COUNT_HUNDRED
	
	ADD R5, R5, #-1
	
	LD R2, hundred
	ADD R1, R1, R2
	
	ADD R5, R5, #0
	BRz SKIP_HUNDREDTHS_TOGGLE
	
	ADD R6, R6, #1

SKIP_HUNDREDTHS_TOGGLE
	
	ADD R6, R6, #0
	BRz TENTHS_PLACE
	
; PRINT_HUNDREDTHS_PLACE	
	LD R0, zero
	ADD R0, R0, R5
	OUT

TENTHS_PLACE
	LD R2, ten
	NOT R2, R2
	ADD R2, R2, #1
	
	AND R5, R5, #0

COUNT_TEN
	ADD R5, R5, #1
	
	ADD R1, R1, R2
	BRzp COUNT_TEN
	
	ADD R5, R5, #-1
	
	LD R2, ten
	ADD R1, R1, R2
	
	ADD R5, R5, #0
	BRz SKIP_TENTHS_TOGGLE
	
	ADD R6, R6, #1

SKIP_TENTHS_TOGGLE
	
	ADD R6, R6, #0
	BRz PRINT_ONES_PLACE
	
; PRINT_TENTHS_PLACE	
	LD R0, zero
	ADD R0, R0, R5
	OUT
	
PRINT_ONES_PLACE
	LD R0, zero
	ADD R0, R0, R1
	OUT
	
SKIP_PRINT_ONES_PLACE

; Restore Backup
	LD R0, R0_BACKUP_3400
	LD R1, R1_BACKUP_3400
	LD R2, R2_BACKUP_3400
;	LD R3, R3_BACKUP_3400
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
;	R3_BACKUP_3400		.BLKW		#1
;	R4_BACKUP_3400		.BLKW		#1
	R5_BACKUP_3400		.BLKW		#1
	R6_BACKUP_3400		.BLKW		#1
	R7_BACKUP_3400		.BLKW		#1
	
	tenThousand			.FILL		#10000
	thousand			.FILL		#1000
	hundred				.FILL		#100
	ten					.FILL		#10
	negativeSign		.FILL		x2D
	zero				.FILL		x30

;=======================================================================
; END SUBROUTINE
;=======================================================================
.END
