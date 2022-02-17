;=======================================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 9, ex 3
; Lab section: <omitted>
; TA: <omitted>
;=======================================================================
.ORIG x3000
; Instructions ---------------------------------------------------------
	LD R4, BASE						; xA000
	LD R5, MAX						; xA005
	LD R6, TOS						; xA000
	
	LEA R0, first_operand_msg		; Prompt for first operand
	PUTS
	GETC
	OUT
	LD R2, SUB_GET_NUM				; Convert into a decimal number
	JSRR R2
	LD R2, SUB_STACK_PUSH			; Push first operand onto stack
	JSRR R2 
	
	LEA R0, second_operand_msg		; Prompt for second operand
	PUTS
	GETC
	OUT
	LD R2, SUB_GET_NUM				; Convert into a decimal number
	JSRR R2
	LD R2, SUB_STACK_PUSH			; Push second operand onto stack
	JSRR R2
	
	LEA R0, operator_msg
	PUTS
	GETC
	OUT
	
	LEA R0, result_msg
	PUTS
	LD R2, SUB_RPN_MULTIPLY			; Multiply both operands
	JSRR R2
	LD R2, SUB_STACK_POP			; Pop result off of stack to print
	JSRR R2
	
	ADD R1, R0, #0					; MEM[R0] is copied into R1 to print
	LD R2, SUB_PRINT_DECIMAL		; using a subroutine
	JSRR R2
	
	HALT
	
; Local Data -----------------------------------------------------------
	SUB_STACK_PUSH		.FILL		x3200
	SUB_STACK_POP		.FILL		x3400
	SUB_RPN_MULTIPLY	.FILL		x3600
	SUB_GET_NUM			.FILL		x4000
	SUB_PRINT_DECIMAL	.FILL		x4200
	
	BASE				.FILL		xA000
	MAX					.FILL		xA005
	TOS					.FILL		xA000
	
	first_operand_msg	.STRINGZ	"\n --\nFirst operand: "
	second_operand_msg	.STRINGZ	"\nSecond operand: "
	operator_msg		.STRINGZ	"\nOperator: "
	result_msg			.STRINGZ	"\nResult: "

;=======================================================================
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    	 If the stack was already full (TOS = MAX), the subroutine has printed an
;		    	 overflow error message and terminated.
; Return Value: R6 ← updated TOS
;=======================================================================
.ORIG x3200
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3200
	ST R1, R1_BACKUP_3200
;	ST R2, R2_BACKUP_3200
;	ST R3, R3_BACKUP_3200
;	ST R4, R4_BACKUP_3200
;	ST R5, R5_BACKUP_3200
;	ST R6, R6_BACKUP_3200
	ST R7, R7_BACKUP_3200

; Subroutine Algorithm
	ADD R1, R6, #0
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R1, R5
	BRz OVERFLOW_ERROR				; Check if TOS == MAX
	
	ADD R6, R6, #1					; Update TOS (-1)
	STR R0, R6, #0					; "Push" value onto stack 
	
	BR END_PUSH_SUB
	
OVERFLOW_ERROR
	LEA R0, overflow_msg
	PUTS
	
END_PUSH_SUB

; Restore Backup
	LD R0, R0_BACKUP_3200
	LD R1, R1_BACKUP_3200
;	LD R2, R2_BACKUP_3200
;	LD R3, R3_BACKUP_3200
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
;	R3_BACKUP_3200		.BLKW		#1
	R4_BACKUP_3200		.BLKW		#1
;	R5_BACKUP_3200		.BLKW		#1
;	R6_BACKUP_3200		.BLKW		#1
	R7_BACKUP_3200		.BLKW		#1
	
	overflow_msg		.STRINGZ	"\nOVERFLOW!"
	
;=======================================================================

;=======================================================================
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    	 If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;=======================================================================
.ORIG x3400
; Subroutine Instructions ----------------------------------------------

; Backup 
;	ST R0, R0_BACKUP_3400
;	ST R1, R1_BACKUP_3400
;	ST R2, R2_BACKUP_3400
;	ST R3, R3_BACKUP_3400
	ST R4, R4_BACKUP_3400
;	ST R5, R5_BACKUP_3400
;	ST R6, R6_BACKUP_3400
	ST R7, R7_BACKUP_3400

; Subroutine Algorithm
	ADD R1, R6, #0
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R1, R4
	BRz UNDERFLOW_ERROR				; Check if TOS == BASE
	
	LDR R0, R6, #0					; R0 <-- MEM[TOS]
	ADD R6, R6, #-1					; "Pop" value off of stack by updating TOS
	
	BR END_POP_SUB

UNDERFLOW_ERROR
	LEA R0, underflow_msg
	PUTS
	
END_POP_SUB

; Restore Backup
;	LD R0, R0_BACKUP_3400
;	LD R1, R1_BACKUP_3400
;	LD R2, R2_BACKUP_3400
;	LD R3, R3_BACKUP_3400
	LD R4, R4_BACKUP_3400
;	LD R5, R5_BACKUP_3400
;	LD R6, R6_BACKUP_3400
	LD R7, R7_BACKUP_3400

; Return
	RET
	
; Local Data -----------------------------------------------------------
;	R0_BACKUP_3400		.BLKW		#1
;	R1_BACKUP_3400		.BLKW		#1
;	R2_BACKUP_3400		.BLKW		#1
;	R3_BACKUP_3400		.BLKW		#1
	R4_BACKUP_3400		.BLKW		#1
	R5_BACKUP_3400		.BLKW		#1
;	R6_BACKUP_3400		.BLKW		#1
	R7_BACKUP_3400		.BLKW		#1
	
	underflow_msg		.STRINGZ	"UNDERFLOW!\n"

;=======================================================================

;=======================================================================
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    	 multiplied them together, and pushed the resulting value back
;		    	 onto the stack.
; Return Value: R6 ← updated TOS address
;=======================================================================
.ORIG x3600
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3600
	ST R1, R1_BACKUP_3600
	ST R2, R2_BACKUP_3600
	ST R3, R3_BACKUP_3600
;	ST R4, R4_BACKUP_3600
;	ST R5, R5_BACKUP_3600
;	ST R6, R6_BACKUP_3600
	ST R7, R7_BACKUP_3600

; Subroutine Algorithm
	LD R1, SUB_STACK_POP_2			; Pop second operand off of the stack
	JSRR R1
	ADD R3, R0, #0
	LD R1, SUB_STACK_POP_2			; Pop first operand off of the stack
	JSRR R1
	ADD R2, R0, #0
	
	LD R1, SUB_MULTIPLY				; Multiply both operands
	JSRR R1
	
	LD R1, SUB_STACK_PUSH_2			; Push product onto the stack
	JSRR R1

; Restore Backup
	LD R0, R0_BACKUP_3600
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
	R0_BACKUP_3600		.BLKW		#1
	R1_BACKUP_3600		.BLKW		#1
	R2_BACKUP_3600		.BLKW		#1
	R3_BACKUP_3600		.BLKW		#1
;	R4_BACKUP_3600		.BLKW		#1
;	R5_BACKUP_3600		.BLKW		#1
;	R6_BACKUP_3600		.BLKW		#1
	R7_BACKUP_3600		.BLKW		#1
	
	SUB_STACK_PUSH_2	.FILL		x3200
	SUB_STACK_POP_2		.FILL		x3400
	SUB_MULTIPLY		.FILL		x3800
	
;=======================================================================

;=======================================================================
; SUBROUTINE: SUB_MULTIPLY		
; Parameter (R2): first operand to multiply
; Parameter (R3): second operand to multiply
; Postcondition: The subroutine multiplies two operands, MEM[R2] and MEM[R3]
;				 and stores the result in R0.
; Return Value (R0): product of MEM[R2] and MEM[R3]
;=======================================================================
.ORIG x3800
; Subroutine Instructions ----------------------------------------------

; Backup 
;	ST R0, R0_BACKUP_3800
;	ST R1, R1_BACKUP_3800
	ST R2, R2_BACKUP_3800
	ST R3, R3_BACKUP_3800
;	ST R4, R4_BACKUP_3800
;	ST R5, R5_BACKUP_3800
;	ST R6, R6_BACKUP_3800
	ST R7, R7_BACKUP_3800

; Subroutine Algorithm
	AND R0, R0, #0
	
	ADD R2, R2, #0					; Check if either operands are 0, and
	BRz SKIP_MULTIPLY_LOOP			; if so, skip loop used to "multiply"
	ADD R3, R3, #0
	BRz SKIP_MULTIPLY_LOOP
	
MULTIPLY_LOOP
	ADD R0, R0, R2
	ADD R3, R3, #-1
	BRp MULTIPLY_LOOP
	
SKIP_MULTIPLY_LOOP

; Restore Backup
;	LD R0, R0_BACKUP_3800
;	LD R1, R1_BACKUP_3800
	LD R2, R2_BACKUP_3800
	LD R3, R3_BACKUP_3800
;	LD R4, R4_BACKUP_3800
;	LD R5, R5_BACKUP_3800
;	LD R6, R6_BACKUP_3800
	LD R7, R7_BACKUP_3800

; Return
	RET
	
; Local Data -----------------------------------------------------------
;	R0_BACKUP_3800		.BLKW		#1
;	R1_BACKUP_3800		.BLKW		#1
	R2_BACKUP_3800		.BLKW		#1
	R3_BACKUP_3800		.BLKW		#1
;	R4_BACKUP_3800		.BLKW		#1
;	R5_BACKUP_3800		.BLKW		#1
;	R6_BACKUP_3800		.BLKW		#1
	R7_BACKUP_3800		.BLKW		#1
	
;=======================================================================

;=======================================================================
; SUBROUTINE: SUB_GET_NUM		
; Parameter (R0): character to convert into a decimal number
; Postcondition: The subroutine converts the character representing a number
;			     into a decimal number.
; Return Value (R0): decimal number converted from MEM[R0]
;=======================================================================
.ORIG x4000
; Subroutine Instructions ----------------------------------------------

; Backup 
;	ST R0, R0_BACKUP_4000
	ST R1, R1_BACKUP_4000
;	ST R2, R2_BACKUP_4000
;	ST R3, R3_BACKUP_4000
;	ST R4, R4_BACKUP_4000
;	ST R5, R5_BACKUP_4000
;	ST R6, R6_BACKUP_4000
	ST R7, R7_BACKUP_4000

; Subroutine Algorithm
	LD R1, zero_4000
	NOT R1, R1
	ADD R1, R1, #1
	ADD R0, R0, R1					

; Restore Backup
;	LD R0, R0_BACKUP_4000
	LD R1, R1_BACKUP_4000
;	LD R2, R2_BACKUP_4000
;	LD R3, R3_BACKUP_4000
;	LD R4, R4_BACKUP_4000
;	LD R5, R5_BACKUP_4000
;	LD R6, R6_BACKUP_4000
	LD R7, R7_BACKUP_4000

; Return
	RET
	
; Local Data -----------------------------------------------------------
;	R0_BACKUP_4000		.BLKW		#1
	R1_BACKUP_4000		.BLKW		#1
;	R2_BACKUP_4000		.BLKW		#1
;	R3_BACKUP_4000		.BLKW		#1
;	R4_BACKUP_4000		.BLKW		#1
;	R5_BACKUP_4000		.BLKW		#1
;	R6_BACKUP_4000		.BLKW		#1
	R7_BACKUP_4000		.BLKW		#1
	
	zero_4000			.FILL		x30

;=======================================================================

;=======================================================================
; SUBROUTINE: SUB_PRINT_DECIMAL
; Parameter (R1): the hard-coded value to print
; Postcondition: The subroutine prints the decimal representation of MEM[R0].
; Return Value: none
;=======================================================================
.ORIG x4200
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_4200
	ST R1, R1_BACKUP_4200
	ST R2, R2_BACKUP_4200
;	ST R3, R3_BACKUP_4200
;	ST R4, R4_BACKUP_4200
	ST R5, R5_BACKUP_4200
	ST R6, R6_BACKUP_4200
	ST R7, R7_BACKUP_4200

; Subroutine Algorithm
	AND R6, R6, #0					; Toggle value to check if respective decimal
									; place should be printed (if > 0)

;TENTHS_PLACE
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
	LD R0, zero_4200
	ADD R0, R0, R5
	OUT
	
PRINT_ONES_PLACE
	LD R0, zero_4200
	ADD R0, R0, R1
	OUT
	
SKIP_PRINT_ONES_PLACE

; Restore Backup
	LD R0, R0_BACKUP_4200
	LD R1, R1_BACKUP_4200
	LD R2, R2_BACKUP_4200
;	LD R3, R3_BACKUP_4200
;	LD R4, R4_BACKUP_4200
	LD R5, R5_BACKUP_4200
	LD R6, R6_BACKUP_4200
	LD R7, R7_BACKUP_4200

; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_4200		.BLKW		#1
	R1_BACKUP_4200		.BLKW		#1
	R2_BACKUP_4200		.BLKW		#1
;	R3_BACKUP_4200		.BLKW		#1
;	R4_BACKUP_4200		.BLKW		#1
	R5_BACKUP_4200		.BLKW		#1
	R6_BACKUP_4200		.BLKW		#1
	R7_BACKUP_4200		.BLKW		#1
	
	ten					.FILL		#10
	zero_4200			.FILL		x30

;=======================================================================
