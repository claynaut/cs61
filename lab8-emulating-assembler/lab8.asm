;=======================================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 8, ex 1 & 2
; Lab section: <omitted>
; TA: <omitted>
;=======================================================================
.ORIG x3000
; Instructions ---------------------------------------------------------
	LD R6, SUB_PRINT_OPCODE_TABLE
	JSRR R6
	
	LD R6, SUB_FIND_OPCODE
	JSRR R6
	
	HALT
	
; Local Data -----------------------------------------------------------
	SUB_PRINT_OPCODE_TABLE	.FILL		x3200
	SUB_FIND_OPCODE		.FILL		x3600

;=======================================================================
; Subroutine: SUB_PRINT_OPCODE_TABLE
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;		 and corresponding opcode in the following format:
;		 	ADD = 0001
;			AND = 0101
;			BR = 0000
;			...
; Return Value: None
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
	ST R6, R6_BACKUP_3200
	ST R7, R7_BACKUP_3200

; Subroutine Algorithm
	LD R1, opcodes_po_ptr
	LD R3, instructions_po_ptr
	
PRINT_LOOP_3200
	LDR R2, R1, #0
	LDR R0, R3, #0
	BRn END_PRINT
	
	ADD R0, R3, #0					
	PUTS					; Print instruction name
	LEA R0, equals_3200
	PUTS					; Print " = "
	LD R6, SUB_PRINT_OPCODE_1
	JSRR R6					; Print opcode
	LD R0, newline_3200
	OUT					; End with a newline

	ADD R1, R1, #1				; Increment address pointing to arrary of opcodes
	
GET_NEXT_INSTRUCTION_3200			; Increment address to the null terminating the string
	ADD R3, R3, #1
	LDR R0, R3, #0
	BRnp GET_NEXT_INSTRUCTION_3200
	
	ADD R3, R3, #1				; Increment to the starting address of the next string
	BR PRINT_LOOP_3200
	
END_PRINT

; Restore Backup
	LD R0, R0_BACKUP_3200
	LD R1, R1_BACKUP_3200
	LD R2, R2_BACKUP_3200
	LD R3, R3_BACKUP_3200
;	LD R4, R4_BACKUP_3200
;	LD R5, R5_BACKUP_3200
	LD R6, R6_BACKUP_3200
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
	R6_BACKUP_3200		.BLKW		#1
	R7_BACKUP_3200		.BLKW		#1
	
	SUB_PRINT_OPCODE_1	.FILL		x3400
	
	opcodes_po_ptr		.FILL 		x4000	; local pointer to remote table of opcodes
	instructions_po_ptr	.FILL 		x4100	; local pointer to remote table of instructions
	
	equals_3200		.STRINGZ	" = "
	newline_3200		.FILL		x0A

;=======================================================================

;=======================================================================
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;=======================================================================
.ORIG x3400
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3400
	ST R1, R1_BACKUP_3400
	ST R2, R2_BACKUP_3400
;	ST R3, R3_BACKUP_3400
;	ST R4, R4_BACKUP_3400
;	ST R5, R5_BACKUP_3400
;	ST R6, R6_BACKUP_3400
	ST R7, R7_BACKUP_3400

; Subroutine Algorithm
	LD R1, shiftCounter			; Counter to shift last 4 bits to the "front"
	
SHIFT_LOOP
	ADD R2, R2, R2
	ADD R1, R1, #-1
	BRp SHIFT_LOOP
	
	LD R1, bitCounter			; Counter to print 4 bits
	
PRINT_LOOP_3400
	ADD R0, R2, #0
	BRn PRINT_ONE				; Skip to load the character '1' to print if the bit is a 1
	
; PRINT_ZERO
	LD R0, zero_3400			; Load the character '0' to print
	BR OUTPUT				; Skip loading the character '1' to print
	
PRINT_ONE
	LD R0, one_3400				; Load the character '1' to print
	
OUTPUT
	OUT									
	ADD R2, R2, R2				; Shift the bits to the left to print the next bit
	ADD R1, R1, #-1
	BRp PRINT_LOOP_3400			; Check if it's necessary to keep printing the bit string

; Restore Backup
	LD R0, R0_BACKUP_3400
	LD R1, R1_BACKUP_3400
	LD R2, R2_BACKUP_3400
;	LD R3, R3_BACKUP_3400
;	LD R4, R4_BACKUP_3400
;	LD R5, R5_BACKUP_3400
;	LD R6, R6_BACKUP_3400
	LD R7, R7_BACKUP_3400

; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_3400		.BLKW		#1
	R1_BACKUP_3400		.BLKW		#1
	R2_BACKUP_3400		.BLKW		#1
;	R3_BACKUP_3400		.BLKW		#1
;	R4_BACKUP_3400		.BLKW		#1
;	R5_BACKUP_3400		.BLKW		#1
;	R6_BACKUP_3400		.BLKW		#1
	R7_BACKUP_3400		.BLKW		#1
	
	zero_3400		.FILL		x30
	one_3400		.FILL		x31
	bitCounter		.FILL		#4
	shiftCounter		.FILL		#12

;=======================================================================

;=======================================================================
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 		 as local data; it has searched the AL instruction list for that string, and reported
;		 either the instruction/opcode pair, OR "Invalid instruction"; it loops until
;		 "-1" has been inputted
; Return Value: None
;=======================================================================
.ORIG x3600
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3600
	ST R1, R1_BACKUP_3600
	ST R2, R2_BACKUP_3600
	ST R3, R3_BACKUP_3600
	ST R4, R4_BACKUP_3600
	ST R5, R5_BACKUP_3600
	ST R6, R6_BACKUP_3600
	ST R7, R7_BACKUP_3600

; Subroutine Algorithm
SUB_LOOP
	LD R2, string_addr
	
	LD R6, SUB_GET_STRING			; Get string to search if it exists within the instruction array
	JSRR R6
	
; Check if "-1" has been inputted (signal to stop infinite looping of the subroutine)
	LDR R0, R2, #0
	LD R1, dash_3600
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R1, R0
	BRnp CONTINUE_SUB
	
	ADD R2, R2, #1
	LDR R0, R2, #0
	LD R1, one_3600
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R1, R0
	BRnp CONTINUE_SUB
	
	ADD R2, R2, #1
	LDR R0, R2, #0
	BRz END_SUB
	
CONTINUE_SUB	
	LD R1, opcodes_fo_ptr
	LD R3, instructions_fo_ptr
	LD R6, string_addr
	
SEARCH_LOOP
	LDR R5, R6, #0
	LDR R2, R1, #0
	LDR R0, R3, #0
	BRn NO_MATCH_FOUND			; End of opcode array has been reached (no match has been found)
	
	ADD R4, R3, #0
	
COMPARE_INSTRUCTION
	ADD R0, R0, #0				
	BRnp SKIP_CHECK_MATCH		
	
	ADD R5, R5, #0
	BRz MATCH_FOUND				; Check if the end of both strings have been reached (match has been found)
	
SKIP_CHECK_MATCH
	NOT R0, R0
	ADD R0, R0, #1
	ADD R0, R0, R5
	BRnp CONTINUE_SEARCH			; Stop comparing strings if a difference has been found
	
	ADD R4, R4, #1
	ADD R6, R6, #1
	LDR R0, R4, #0
	LDR R5, R6, #0
	BR COMPARE_INSTRUCTION

MATCH_FOUND
	ADD R0, R3, #0					
	PUTS					; Print instruction name
	LEA R0, equals_3600
	PUTS					; Print " = "
	LD R6, SUB_PRINT_OPCODE_2
	JSRR R6					; Print opcode
	LD R0, newline_3600
	OUT					; End with a newline
	BR END_SEARCH

CONTINUE_SEARCH
	ADD R1, R1, #1				; Increment address pointing to arrary of opcodes
	LD R6, string_addr			; Reload starting address of string
	
GET_NEXT_INSTRUCTION_3600			; Increment address to the null terminating the string
	ADD R3, R3, #1
	LDR R0, R3, #0
	BRnp GET_NEXT_INSTRUCTION_3600
	
	ADD R3, R3, #1				; Increment to the starting address of the next string
	BR SEARCH_LOOP
	
NO_MATCH_FOUND
	LEA R0, invalid_msg
	PUTS
	
END_SEARCH
	BR SUB_LOOP
	
END_SUB

; Restore Backup
	LD R0, R0_BACKUP_3600
	LD R1, R1_BACKUP_3600
	LD R2, R2_BACKUP_3600
	LD R3, R3_BACKUP_3600
	LD R4, R4_BACKUP_3600
	LD R5, R5_BACKUP_3600
	LD R6, R6_BACKUP_3600
	LD R7, R7_BACKUP_3600

; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_3600		.BLKW		#1
	R1_BACKUP_3600		.BLKW		#1
	R2_BACKUP_3600		.BLKW		#1
	R3_BACKUP_3600		.BLKW		#1
	R4_BACKUP_3600		.BLKW		#1
	R5_BACKUP_3600		.BLKW		#1
	R6_BACKUP_3600		.BLKW		#1
	R7_BACKUP_3600		.BLKW		#1
	
	SUB_PRINT_OPCODE_2	.FILL		x3400
	SUB_GET_STRING		.FILL		x3800
	
	opcodes_fo_ptr		.FILL 		x4000
	instructions_fo_ptr	.FILL 		x4100
	string_addr		.FILL		x3700
	
	invalid_msg		.STRINGZ	"Invalid instruction\n"
	equals_3600		.STRINGZ	" = "
	newline_3600		.FILL		x0A
	dash_3600		.FILL		x2D
	one_3600		.FILL		x31

;=======================================================================

;=======================================================================
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 		 by [ENTER]. That string has been stored as a null-terminated character array 
; 		 at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;=======================================================================
.ORIG x3800
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3800
	ST R1, R1_BACKUP_3800
	ST R2, R2_BACKUP_3800
;	ST R3, R3_BACKUP_3800
;	ST R4, R4_BACKUP_3800
;	ST R5, R5_BACKUP_3800
;	ST R6, R6_BACKUP_3800
	ST R7, R7_BACKUP_3800

; Subroutine Algorithm
	LEA R0, prompt				; Prompt user to input a short string
	PUTS
	

GET_INPUT
	GETC
	OUT
	
	LD R1, newline_3800				
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R1, R0
	BRz END_INPUT				; Check for sentinel character (ENTER)
	
	STR R0, R2, #0
	ADD R2, R2, #1
	BR GET_INPUT
	
END_INPUT
	AND R0, R0, #0
	STR R0, R2, #0				; Terminate character array with null

; Restore Backup
	LD R0, R0_BACKUP_3800
	LD R1, R1_BACKUP_3800
	LD R2, R2_BACKUP_3800
;	LD R3, R3_BACKUP_3800
;	LD R4, R4_BACKUP_3800
;	LD R5, R5_BACKUP_3800
;	LD R6, R6_BACKUP_3800
	LD R7, R7_BACKUP_3800

; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_3800		.BLKW		#1
	R1_BACKUP_3800		.BLKW		#1
	R2_BACKUP_3800		.BLKW		#1
;	R3_BACKUP_3800		.BLKW		#1
;	R4_BACKUP_3800		.BLKW		#1
;	R5_BACKUP_3800		.BLKW		#1
;	R6_BACKUP_3800		.BLKW		#1
	R7_BACKUP_3800		.BLKW		#1
	
	prompt			.STRINGZ	"Enter a short string (-1 to EXIT): "
	newline_3800		.FILL		x0A

;=======================================================================

;Remote Data -----------------------------------------------------------
.ORIG x4000		; list opcodes as numbers from #0 through #15, e.g. .FILL #12 or .FILL xC
; OPCODES
	.FILL 		x1
	.FILL		x1
	.FILL		x5
	.FILL		x5
	.FILL		x0
	.FILL		xC
	.FILL		x4
	.FILL		x4
	.FILL		x2
	.FILL		xA
	.FILL		x6
	.FILL		xE
	.FILL		x9
	.FILL		xC
	.FILL		x8
	.FILL		x3
	.FILL		xB
	.FILL		x7
	.FILL		xF

.ORIG x4100		; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
; INSTRUCTIONS		; - be sure to follow same order in opcode & instruction arrays!
	.STRINGZ	"ADD"
	.STRINGZ	"ADD"
	.STRINGZ	"AND"
	.STRINGZ	"AND"
	.STRINGZ	"BR"
	.STRINGZ	"JMP"
	.STRINGZ	"JSR"
	.STRINGZ	"JSRR"
	.STRINGZ	"LD"
	.STRINGZ	"LDI"
	.STRINGZ	"LDR"
	.STRINGZ	"LEA"
	.STRINGZ	"NOT"
	.STRINGZ	"RET"
	.STRINGZ	"RTI"
	.STRINGZ	"ST"
	.STRINGZ	"STI"
	.STRINGZ	"STR"
	.STRINGZ	"TRAP"
	.FILL		#-1

;=======================================================================
.END
