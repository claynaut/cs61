;=================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 3, ex 2
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
	
	HALT

; Local Data -----------------------------------------------------------
	ARRAY			.BLKW		#10
	loopCounter		.FILL		#10

.END
