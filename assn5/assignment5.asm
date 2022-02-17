;=======================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Assignment name: Assignment 5
; Lab section: <omitted>
; TA: <omitted>
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;=======================================================================
.ORIG x3000			
;Instructions ----------------------------------------------------------
REPEAT_PROGRAM
	LD R6, MENU
	JSRR R6
	LD R0, newline
	OUT

	ADD R0, R1, #-1
	BRz OPTION_ONE
	
	ADD R0, R1, #-2
	BRz OPTION_TWO
	
	ADD R0, R1, #-3
	BRz OPTION_THREE
	
	ADD R0, R1, #-4
	BRz OPTION_FOUR
	
	ADD R0, R1, #-5
	BRz OPTION_FIVE
	
	ADD R0, R1, #-6
	BRz OPTION_SIX
	
	BR OPTION_SEVEN
	
OPTION_ONE
	LD R6, ALL_MACHINES_BUSY
	JSRR R6
	
	ADD R2, R2, #0
	BRz NOT_ALL_BUSY
	
	LEA R0, allbusy
	PUTS
	BR REPEAT_PROGRAM
	
NOT_ALL_BUSY
	LEA R0, allnotbusy
	PUTS
	BR REPEAT_PROGRAM
	
OPTION_TWO
	LD R6, ALL_MACHINES_FREE
	JSRR R6

	ADD R2, R2, #0
	BRz NOT_ALL_FREE
	
	LEA R0, allfree
	PUTS
	BR REPEAT_PROGRAM
	
NOT_ALL_FREE
	LEA R0, allnotfree
	PUTS
	BR REPEAT_PROGRAM
	
OPTION_THREE
	LD R6, NUM_BUSY_MACHINES
	JSRR R6
	
	LEA R0, busyfreemachine1
	PUTS
	LD R6, PRINT_NUM
	JSRR R6
	LEA R0, busymachine2
	PUTS
	BR REPEAT_PROGRAM

OPTION_FOUR
	LD R6, NUM_FREE_MACHINES
	JSRR R6
	
	LEA R0, busyfreemachine1
	PUTS
	LD R6, PRINT_NUM
	JSRR R6
	LEA R0, freemachine2
	PUTS
	BR REPEAT_PROGRAM

OPTION_FIVE
	LD R6, MACHINE_STATUS
	JSRR R6
	
	LEA R0, status1
	PUTS
	LD R6, PRINT_NUM
	JSRR R6
	
	ADD R2, R2, #0
	BRz MACHINE_IS_BUSY
	
	LEA R0, status3
	PUTS
	BR REPEAT_PROGRAM
	
MACHINE_IS_BUSY
	LEA R0, status2
	PUTS
	BR REPEAT_PROGRAM

OPTION_SIX
	LD R6, FIRST_FREE
	JSRR R6
	
	ADD R1, R1, #0
	BRn NO_MACHINES_ARE_FREE
	
	LEA R0, firstfree1
	PUTS
	LD R6, PRINT_NUM
	JSRR R6
	LD R0, newline
	OUT
	BR REPEAT_PROGRAM
	
NO_MACHINES_ARE_FREE
	LEA R0, firstfree2
	PUTS
	BR REPEAT_PROGRAM

OPTION_SEVEN
	LEA R0, goodbye
	PUTS

	HALT
	
; Local Data  ---------------------------------------------------------- 
; Subroutine pointers
	MENU			.FILL		x3200
	ALL_MACHINES_BUSY	.FILL		x3400
	ALL_MACHINES_FREE	.FILL		x3600
	NUM_BUSY_MACHINES	.FILL		x3800
	NUM_FREE_MACHINES	.FILL		x4000
	MACHINE_STATUS		.FILL		x4200
	FIRST_FREE		.FILL		x4400
	PRINT_NUM		.FILL		x4800

; Other data 
	newline 		.FILL		x0A
	zero			.FILL		x30

; Strings for reports from menu subroutines:
	goodbye         	.STRINGZ 	"Goodbye!\n"
	allbusy         	.STRINGZ 	"All machines are busy\n"
	allnotbusy      	.STRINGZ 	"Not all machines are busy\n"
	allfree         	.STRINGZ 	"All machines are free\n"
	allnotfree		.STRINGZ 	"Not all machines are free\n"
	busyfreemachine1	.STRINGZ 	"There are "
	busymachine2    	.STRINGZ 	" busy machines\n"
	freemachine2    	.STRINGZ 	" free machines\n"
	status1         	.STRINGZ 	"Machine "
	status2		    	.STRINGZ 	" is busy\n"
	status3		    	.STRINGZ 	" is free\n"
	firstfree1      	.STRINGZ 	"The first available machine is number "
	firstfree2      	.STRINGZ 	"No machines are free\n"

;=======================================================================
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;=======================================================================
.ORIG x3200
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3200
;	ST R1, R1_BACKUP_3200
	ST R2, R2_BACKUP_3200
	ST R3, R3_BACKUP_3200
;	ST R4, R4_BACKUP_3200
;	ST R5, R5_BACKUP_3200
;	ST R6, R6_BACKUP_3200
	ST R7, R7_BACKUP_3200

; Subroutine Algorithm
	BR PRINT_MENU
	
PRINT_ERROR_3200
	LEA R0, errorMsg1
	PUTS
	
PRINT_MENU
	LD R0, menustringAddr
	PUTS
	
	GETC
	OUT
	
	LD R2, one_3200
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRn PRINT_ERROR_3200
	
	LD R2, seven_3200
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRp PRINT_ERROR_3200
	
	LD R1, zero_3200
	NOT R1, R1
	ADD R1, R1, #1
	
	ADD R1, R1, R0

; Restore Backup
	LD R0, R0_BACKUP_3200
;	LD R1, R1_BACKUP_3200
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
;	R1_BACKUP_3200		.BLKW		#1
	R2_BACKUP_3200		.BLKW		#1
	R3_BACKUP_3200		.BLKW		#1
;	R4_BACKUP_3200		.BLKW		#1
;	R5_BACKUP_3200		.BLKW		#1
;	R6_BACKUP_3200		.BLKW		#1
	R7_BACKUP_3200		.BLKW		#1
	
	menustringAddr  	.FILL 		x6400
	errorMsg1	      	.STRINGZ 	"\nINVALID INPUT\n"
	seven_3200		.FILL		x37
	one_3200		.FILL		x31
	zero_3200		.FILL		x30

;=======================================================================
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;=======================================================================
.ORIG x3400
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3400
	ST R1, R1_BACKUP_3400
;	ST R2, R2_BACKUP_3400
	ST R3, R3_BACKUP_3400
;	ST R4, R4_BACKUP_3400
;	ST R5, R5_BACKUP_3400
;	ST R6, R6_BACKUP_3400
	ST R7, R7_BACKUP_3400

; Subroutine Algorithm
	LDI R0, BUSYNESS_ADDR_ALL_MACHINES_BUSY
	AND R1, R1, #0
	AND R2, R2, #0
	LD R3, bitCounter_3400

CHECK_IF_ALL_MACHINES_BUSY
	ADD R0, R0, #0
	BRn SKIP_INCREMENT_3400
	
	ADD R1, R1, #1
	
SKIP_INCREMENT_3400
	ADD R0, R0, R0
	
	ADD R3, R3, #-1
	BRp CHECK_IF_ALL_MACHINES_BUSY

	LD R3, bitCounter_3400
	NOT R3, R3
	ADD R3, R3, #1
	ADD R3, R3, R1
	BRnp SKIP_TOGGLE_3400
	
	ADD R2, R2, #1
	
SKIP_TOGGLE_3400

; Restore Backup
	LD R0, R0_BACKUP_3400
	LD R1, R1_BACKUP_3400
;	LD R2, R2_BACKUP_3400
	LD R3, R3_BACKUP_3400
;	LD R4, R4_BACKUP_3400
;	LD R5, R5_BACKUP_3400
;	LD R6, R6_BACKUP_3400
	LD R7, R7_BACKUP_3400

; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_3400		.BLKW		#1
	R1_BACKUP_3400		.BLKW		#1
;	R2_BACKUP_3400		.BLKW		#1
	R3_BACKUP_3400		.BLKW		#1
;	R4_BACKUP_3400		.BLKW		#1
;	R5_BACKUP_3400		.BLKW		#1
;	R6_BACKUP_3400		.BLKW		#1
	R7_BACKUP_3400		.BLKW		#1
	
	BUSYNESS_ADDR_ALL_MACHINES_BUSY .FILL xB200
	bitCounter_3400		.FILL		#16

;=======================================================================
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;=======================================================================
.ORIG x3600
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3600
	ST R1, R1_BACKUP_3600
;	ST R2, R2_BACKUP_3600
	ST R3, R3_BACKUP_3600
;	ST R4, R4_BACKUP_3600
;	ST R5, R5_BACKUP_3600
;	ST R6, R6_BACKUP_3600
	ST R7, R7_BACKUP_3600

; Subroutine Algorithm
	LDI R0, BUSYNESS_ADDR_ALL_MACHINES_FREE
	AND R1, R1, #0
	AND R2, R2, #0
	LD R3, bitCounter_3600

CHECK_IF_ALL_MACHINES_FREE
	ADD R0, R0, #0
	BRzp SKIP_INCREMENT_3600
	
	ADD R1, R1, #1
	
SKIP_INCREMENT_3600
	ADD R0, R0, R0
	
	ADD R3, R3, #-1
	BRp CHECK_IF_ALL_MACHINES_FREE

	LD R3, bitCounter_3600
	NOT R3, R3
	ADD R3, R3, #1
	ADD R3, R3, R1
	BRnp SKIP_TOGGLE_3600
	
	ADD R2, R2, #1
	
SKIP_TOGGLE_3600

; Restore Backup
	LD R0, R0_BACKUP_3600
	LD R1, R1_BACKUP_3600
;	LD R2, R2_BACKUP_3600
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
;	R2_BACKUP_3600		.BLKW		#1
	R3_BACKUP_3600		.BLKW		#1
;	R4_BACKUP_3600		.BLKW		#1
;	R5_BACKUP_3600		.BLKW		#1
;	R6_BACKUP_3600		.BLKW		#1
	R7_BACKUP_3600		.BLKW		#1
	
	BUSYNESS_ADDR_ALL_MACHINES_FREE .FILL xB200
	bitCounter_3600		.FILL		#16

;=======================================================================
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy (0)
;=======================================================================
.ORIG x3800
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_3800
;	ST R1, R1_BACKUP_3800
;	ST R2, R2_BACKUP_3800
	ST R3, R3_BACKUP_3800
;	ST R4, R4_BACKUP_3800
;	ST R5, R5_BACKUP_3800
;	ST R6, R6_BACKUP_3800
	ST R7, R7_BACKUP_3800

; Subroutine Algorithm
	LDI R0, BUSYNESS_ADDR_NUM_BUSY_MACHINES
	AND R1, R1, #0
	LD R3, bitCounter_3800

COUNT_NUM_BUSY_MACHINES
	ADD R0, R0, #0
	BRn SKIP_INCREMENT_3800
	
	ADD R1, R1, #1
	
SKIP_INCREMENT_3800
	ADD R0, R0, R0
	
	ADD R3, R3, #-1
	BRp COUNT_NUM_BUSY_MACHINES

; Restore Backup
	LD R0, R0_BACKUP_3800
;	LD R1, R1_BACKUP_3800
;	LD R2, R2_BACKUP_3800
	LD R3, R3_BACKUP_3800
;	LD R4, R4_BACKUP_3800
;	LD R5, R5_BACKUP_3800
;	LD R6, R6_BACKUP_3800
	LD R7, R7_BACKUP_3800

; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_3800		.BLKW		#1
;	R1_BACKUP_3800		.BLKW		#1
;	R2_BACKUP_3800		.BLKW		#1
	R3_BACKUP_3800		.BLKW		#1
;	R4_BACKUP_3800		.BLKW		#1
;	R5_BACKUP_3800		.BLKW		#1
;	R6_BACKUP_3800		.BLKW		#1
	R7_BACKUP_3800		.BLKW		#1
	
	BUSYNESS_ADDR_NUM_BUSY_MACHINES .FILL xB200
	bitCounter_3800		.FILL		#16

;=======================================================================
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free (1)
;=======================================================================
.ORIG x4000
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_4000
;	ST R1, R1_BACKUP_4000
;	ST R2, R2_BACKUP_4000
	ST R3, R3_BACKUP_4000
;	ST R4, R4_BACKUP_4000
;	ST R5, R5_BACKUP_4000
;	ST R6, R6_BACKUP_4000
	ST R7, R7_BACKUP_4000

; Subroutine Algorithm
	LDI R0, BUSYNESS_ADDR_NUM_FREE_MACHINES
	AND R1, R1, #0
	LD R3, bitCounter_4000

COUNT_NUM_FREE_MACHINES
	ADD R0, R0, #0
	BRzp SKIP_INCREMENT_4000
	
	ADD R1, R1, #1
	
SKIP_INCREMENT_4000
	ADD R0, R0, R0
	
	ADD R3, R3, #-1
	BRp COUNT_NUM_FREE_MACHINES

; Restore Backup
	LD R0, R0_BACKUP_4000
;	LD R1, R1_BACKUP_4000
;	LD R2, R2_BACKUP_4000
	LD R3, R3_BACKUP_4000
;	LD R4, R4_BACKUP_4000
;	LD R5, R5_BACKUP_4000
;	LD R6, R6_BACKUP_4000
	LD R7, R7_BACKUP_4000

; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_4000		.BLKW		#1
;	R1_BACKUP_4000		.BLKW		#1
;	R2_BACKUP_4000		.BLKW		#1
	R3_BACKUP_4000		.BLKW		#1
;	R4_BACKUP_4000		.BLKW		#1
;	R5_BACKUP_4000		.BLKW		#1
;	R6_BACKUP_4000		.BLKW		#1
	R7_BACKUP_4000		.BLKW		#1
	
	BUSYNESS_ADDR_NUM_FREE_MACHINES .FILL xB200
	bitCounter_4000		.FILL		#16

;=======================================================================
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;=======================================================================
.ORIG x4200
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_4200
;	ST R1, R1_BACKUP_4200
;	ST R2, R2_BACKUP_4200
	ST R3, R3_BACKUP_4200
;	ST R4, R4_BACKUP_4200
;	ST R5, R5_BACKUP_4200
	ST R6, R6_BACKUP_4200
	ST R7, R7_BACKUP_4200

; Subroutine Algorithm
	LD R6, GET_MACHINE_NUM
	JSRR R6
	
	LDI R0, BUSYNESS_ADDR_MACHINE_STATUS
	AND R2, R2, #0
	LD R3, fifteen_4200
	NOT R3, R3
	ADD R3, R3, #1
	ADD R3, R3, R1 
	
FIND_MACHINE_4200
	ADD R3, R3, #0
	BRz MACHINE_FOUND_4200
	
	ADD R0, R0, R0
	
	ADD R3, R3, #1
	BR FIND_MACHINE_4200
	
MACHINE_FOUND_4200
	ADD R0, R0, #0
	BRzp SKIP_TOGGLE_4200
	
	ADD R2, R2, #1
	
SKIP_TOGGLE_4200

; Restore Backup
	LD R0, R0_BACKUP_4200
;	LD R1, R1_BACKUP_4200
;	LD R2, R2_BACKUP_4200
	LD R3, R3_BACKUP_4200
;	LD R4, R4_BACKUP_4200
;	LD R5, R5_BACKUP_4200
	LD R6, R6_BACKUP_4200
	LD R7, R7_BACKUP_4200

; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_4200		.BLKW		#1
;	R1_BACKUP_4200		.BLKW		#1
;	R2_BACKUP_4200		.BLKW		#1
	R3_BACKUP_4200		.BLKW		#1
;	R4_BACKUP_4200		.BLKW		#1
;	R5_BACKUP_4200		.BLKW		#1
	R6_BACKUP_4200		.BLKW		#1
	R7_BACKUP_4200		.BLKW		#1
	
	GET_MACHINE_NUM		.FILL		x4600
	
	BUSYNESS_ADDR_MACHINE_STATUS	.FILL xB200
	fifteen_4200		.FILL		#15

;=======================================================================
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R1): the number of the free machine
;=======================================================================
.ORIG x4400
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_4400
;	ST R1, R1_BACKUP_4400
	ST R2, R2_BACKUP_4400
	ST R3, R3_BACKUP_4400
;	ST R4, R4_BACKUP_4400
;	ST R5, R5_BACKUP_4400
;	ST R6, R6_BACKUP_4400
	ST R7, R7_BACKUP_4400

; Subroutine Algorithm
	LDI R0, BUSYNESS_ADDR_FIRST_FREE
	AND R1, R1, #0
	ADD R1, R1, #-1
	LD R2, bitCounter_4400
	ADD R2, R2, #-1
	LD R3, bitCounter_4400
	
FIND_MACHINE_4400
	ADD R0, R0, #0
	BRzp MACHINE_IS_BUSY_4400
	
	ADD R1, R2, #0
	
MACHINE_IS_BUSY_4400
	ADD R0, R0, R0
	ADD R2, R2, #-1

	ADD R3, R3, #-1
	BRp FIND_MACHINE_4400
	
; Restore Backup
	LD R0, R0_BACKUP_4400
;	LD R1, R1_BACKUP_4400
	LD R2, R2_BACKUP_4400
	LD R3, R3_BACKUP_4400
;	LD R4, R4_BACKUP_4400
;	LD R5, R5_BACKUP_4400
;	LD R6, R6_BACKUP_4400
	LD R7, R7_BACKUP_4400

; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_4400		.BLKW		#1
;	R1_BACKUP_4400		.BLKW		#1
	R2_BACKUP_4400		.BLKW		#1
	R3_BACKUP_4400		.BLKW		#1
;	R4_BACKUP_4400		.BLKW		#1
;	R5_BACKUP_4400		.BLKW		#1
;	R6_BACKUP_4400		.BLKW		#1
	R7_BACKUP_4400		.BLKW		#1
	
	BUSYNESS_ADDR_FIRST_FREE 		.FILL xB200
	bitCounter_4400		.FILL		#16

;=======================================================================
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;=======================================================================
.ORIG x4600
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_4600
;	ST R1, R1_BACKUP_4600
	ST R2, R2_BACKUP_4600
	ST R3, R3_BACKUP_4600
	ST R4, R4_BACKUP_4600
;	ST R5, R5_BACKUP_4600
;	ST R6, R6_BACKUP_4600
	ST R7, R7_BACKUP_4600

; Subroutine Algorithm
	BR PROMPT_MACHINE_NUM
	
PRINT_ERROR_4600
	LEA R0, errorMsg2
	PUTS
	
PROMPT_MACHINE_NUM
	AND R1, R1, #0
	LEA R0, prompt_4600
	PUTS
	
	GETC
	OUT
	
	; First input cannot be a sentinel character (ENTER)
	LD R2, newline_4600
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRz PRINT_ERROR_4600
	
	BR CONTINUE_INPUT_VALIDATION
	
GET_INPUT_4600
	GETC
	OUT
	
	; Sentinel character check (ENTER)
	LD R2, newline_4600
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRz END_GET_INPUT_4600
	
CONTINUE_INPUT_VALIDATION
	; Input validation (checks if only characters '0' to '9' have been inputted)
	LD R2, zero_4600			
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRn PRINT_ERROR_4600
	
	LD R2, nine_4600
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R3, R0, R2
	BRp PRINT_ERROR_4600
	
	AND R3, R3, #0					; Hardcodes R3 with the value 0 as it will be used to
									; temporarily store a value in the following loop

; Multiply current value in R1 by 10 (using R3 to temporarily store the value)
; before adding another digit
MULTIPLY_BY_TEN
	ADD R3, R3, R1
	
	ADD R4, R4, #-1
	BRp MULTIPLY_BY_TEN
	
	LD R4, multiplier				; Reset counter for multiplier loop
	ADD R1, R3, #0					; Load multiplied value (temporarily stored in R3) into R1
	
	LD R2, zero_4600
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R0, R0, R2					; Convert character input from ASCII to decimal
	ADD R1, R1, R0					; Add decimal value to R1 (register to store final value)

	BR GET_INPUT_4600
	
END_GET_INPUT_4600
	; Additional input validation (checks if input is in the range 0-15)
	LD R2, fifteen_4600
	NOT R2, R2
	ADD R2, R2, #1
	
	ADD R2, R1, R2
	BRp PRINT_ERROR_4600
	
	ADD R1, R1, #0
	BRn PRINT_ERROR_4600	

; Restore Backup
	LD R0, R0_BACKUP_4600
;	LD R1, R1_BACKUP_4600
	LD R2, R2_BACKUP_4600
	LD R3, R3_BACKUP_4600
	LD R4, R4_BACKUP_4600
;	LD R5, R5_BACKUP_4600
;	LD R6, R6_BACKUP_4600
	LD R7, R7_BACKUP_4600

; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_4600		.BLKW		#1
;	R1_BACKUP_4600		.BLKW		#1
	R2_BACKUP_4600		.BLKW		#1
	R3_BACKUP_4600		.BLKW		#1
	R4_BACKUP_4600		.BLKW		#1
;	R5_BACKUP_4600		.BLKW		#1
;	R6_BACKUP_4600		.BLKW		#1
	R7_BACKUP_4600		.BLKW		#1
	
	prompt_4600		.STRINGZ 	"Enter which machine you want the status of (0 - 15), followed by ENTER: "
	errorMsg2	 	.STRINGZ 	"\nERROR INVALID INPUT\n"
	fifteen_4600		.FILL		#15
	nine_4600		.FILL		x39
	zero_4600		.FILL		x30
	newline_4600		.FILL		x0A
	multiplier		.FILL		#10
	
;=======================================================================
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,16}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;=======================================================================
.ORIG x4800
; Subroutine Instructions ----------------------------------------------

; Backup 
	ST R0, R0_BACKUP_4800
	ST R1, R1_BACKUP_4800
	ST R2, R2_BACKUP_4800
;	ST R3, R3_BACKUP_4800
;	ST R4, R4_BACKUP_4800
	ST R5, R5_BACKUP_4800
	ST R6, R6_BACKUP_4800
	ST R7, R7_BACKUP_4800

; Subroutine Algorithm
	AND R6, R6, #0					; Toggle value to check if respective decimal
									; place should be printed (if > 0)	

; TENTHS_PLACE
	LD R2, ten_4800
	NOT R2, R2
	ADD R2, R2, #1
	
	AND R5, R5, #0

COUNT_TEN
	ADD R5, R5, #1
	
	ADD R1, R1, R2
	BRzp COUNT_TEN
	
	ADD R5, R5, #-1					; Subtracts one to account for the loop
									; being run an extra time (runs until MEM[R1] is negative)
	
	LD R2, ten_4800
	ADD R1, R1, R2					; Adds respective value back to decimal place since the
									; loop runs an extra time until MEM[R1] is negative
	
	ADD R5, R5, #0
	BRz SKIP_TENTHS_TOGGLE
	
	ADD R6, R6, #1

SKIP_TENTHS_TOGGLE
	
	ADD R6, R6, #0					; Checks if current decimal place should be printed
	BRz PRINT_ONES_PLACE			; (won't print if preceding decimal places were leading 0's)
	
; PRINT_TENTHS_PLACE	
	LD R0, zero_4800
	ADD R0, R0, R5
	OUT
	
PRINT_ONES_PLACE
	LD R0, zero_4800
	ADD R0, R0, R1
	OUT
	
SKIP_PRINT_ONES_PLACE

; Restore Backup
	LD R0, R0_BACKUP_4800
	LD R1, R1_BACKUP_4800
	LD R2, R2_BACKUP_4800
;	LD R3, R3_BACKUP_4800
;	LD R4, R4_BACKUP_4800
	LD R5, R5_BACKUP_4800
	LD R6, R6_BACKUP_4800
	LD R7, R7_BACKUP_4800

; Return
	RET
	
; Local Data -----------------------------------------------------------
	R0_BACKUP_4800		.BLKW		#1
	R1_BACKUP_4800		.BLKW		#1
	R2_BACKUP_4800		.BLKW		#1
;	R3_BACKUP_4800		.BLKW		#1
;	R4_BACKUP_4800		.BLKW		#1
	R5_BACKUP_4800		.BLKW		#1
	R6_BACKUP_4800		.BLKW		#1
	R7_BACKUP_4800		.BLKW		#1
	
	ten_4800		.FILL		#10
	zero_4800		.FILL		x30
	
; Remote Data ----------------------------------------------------------
	
.ORIG x6400
	MENUSTRING 			.STRINGZ 	"**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xB200									; Remote data
	BUSYNESS 			.FILL 		x0000	; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;=======================================================================
;END of PROGRAM
;=======================================================================
.END
