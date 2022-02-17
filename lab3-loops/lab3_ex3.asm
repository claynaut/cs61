;=================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 3, ex 3
; Lab section: <omitted>
; TA: <omitted>
; 
;=================================================
.ORIG x3000

; Main Instructions ----------------------------------------------------
	LEA R1, ARRAY		; Loads the adress where ARRAY is located
	LD R2, loopCounter	; Loads the counter value into R2

FILL_LOOP
	GETC
	OUT
	
	STR R0, R1, #0		; Stores user input into the address within the array
	
	ADD R1, R1, #1		; Increments the current index of the array
	ADD R2, R2, #-1
	BRp FILL_LOOP		; Loops until the counter value reaches 0
	
	LEA R1, ARRAY		; Reloads the address of ARRAY
	LD R2, loopCounter	; Reloads the counter value
	
	LD R0, newline		; Prints a newline before running the print loop
	OUT
	
PRINT_LOOP
	LDR R0, R1, #0		; Loads the value located at the address stored in R1 (some index within the array)
	OUT					; and prints to console
	
	LD R0, newline		; Prints a newline after each character is printed
	OUT
	
	ADD R1, R1, #1		; Increments the current index of the array
	ADD R2, R2, #-1
	BRp PRINT_LOOP		; Loops until the counter value reaches 0
	
	HALT

; Local Data -----------------------------------------------------------
	ARRAY			.BLKW		#10
	loopCounter		.FILL		#10
	newline			.FILL		x0A

.END
