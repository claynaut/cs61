;=================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 3, ex 4
; Lab section: <omitted>
; TA: <omitted>
; 
;=================================================
.ORIG x3000

; Main Instructions ----------------------------------------------------
	LD R1, ARRAY_ADDR	; Loads the remote address of an array (x4000)
	
	LD R2, newline		; Loads the newline character into R2
	NOT R2, R2			; and performs 2's complement conversion
	ADD R2, R2, #1		; which will be used to check for the sentinel character (ENTER)
	
FILL_LOOP
	GETC
	OUT

	ADD R3, R0, R2		; R3 is used to store a temporary value (used to check for equality)
	BRz END_STRING		; Sotres user input until it matches the sentinel character (ENTER)
	
	STR R0, R1, #0		; Stores user input into the address within the array, only if it's not the sentinel char
	
	ADD R1, R1, #1		; Increments the current index of the array
	
	BR FILL_LOOP
	
END_STRING
	AND R0, R0, #0		; Forces the value in R0 to be a 0
	STR R0, R1, #0		; Terminates the array with a 0
	
	LD R1, ARRAY_ADDR	; Reloads the address of the array
	
PRINT_LOOP
	LDR R0, R1, #0		; Loads the value located at the address stored in R1 (some index within the array)
	
	ADD R1, R1, #1		; Increments the current index of the array
	
	ADD R0, R0, #0		; Checks if sentinel character has been reached (0)
	BRz END_PRINT		; Loops until the character in the array matches the sentinel character (0)
	
	OUT			; Prints to console the value stored in R0, only if it's not the sentinel char
	
	BR PRINT_LOOP
	
END_PRINT

	HALT

; Local Data -----------------------------------------------------------
	ARRAY_ADDR	.FILL	x4000
	newline		.FILL	x0A

.END
