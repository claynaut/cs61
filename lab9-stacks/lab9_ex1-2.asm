;=======================================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 9, ex 1 & 2
; Lab section: <omitted>
; TA: <omitted>
;=======================================================================
.ORIG x3000
; Instructions ---------------------------------------------------------
	LD R2, pushCounter				; Counter for how many times to push a value
	LD R3, popCounter				; Counter for how many times to pop a value
	LD R4, BASE						; xA000
	LD R5, MAX						; xA005
	LD R6, TOS						; xA000
	
	LEA R0, divider					; Divider printed to separate text printed to console
	PUTS
	
PUSH_LOOP							; Push a value a certain number of times
	LEA R0, push_msg
	PUTS
	
	GETC
	OUT
	LD R1, SUB_STACK_PUSH
	JSRR R1
	
	LD R0, newline
	OUT
	
	ADD R2, R2, #-1
	BRp PUSH_LOOP
	
POP_LOOP							; Pop a certain number of times
	LEA R0, pop_msg
	PUTS
	
	LD R1, SUB_STACK_POP
	JSRR R1
	OUT
	
	ADD R3, R3, #-1
	BRp POP_LOOP
	
	HALT
	
; Local Data -----------------------------------------------------------
	SUB_STACK_PUSH		.FILL		x3200
	SUB_STACK_POP		.FILL		x3400
	
	BASE				.FILL		xA000
	MAX					.FILL		xA005
	TOS					.FILL		xA000
	
	divider				.STRINGZ 	"\n --\n"
	push_msg			.STRINGZ	"Input a value to push to stack: "
	pop_msg				.STRINGZ	"\nValue popped: "
	newline				.FILL		x0A
	pushCounter			.FILL		#7
	popCounter			.FILL		#6

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
	
	ADD R6, R6, #1					; Update TOS (+1)
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
;	R4_BACKUP_3200		.BLKW		#1
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
.END
