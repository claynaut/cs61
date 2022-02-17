;=======================================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 4, ex 1
; Lab section: <omitted>
; TA: <omitted>
;=======================================================================
.ORIG x3000
; Instructions ---------------------------------------------------------
	LD R1, ARRAY_ADDR	; Load the starting address of the array
	
	AND R3, R3, #0		; Beginning value (0) to store into the array
	LD R4, fillCount	
	
FILL_LOOP
	STR R3, R1, #0		; Store hardcoded value into array
	ADD R1, R1, #1		; Increment address within array
	ADD R3, R3, #1		; Increment hardcoded value to store
	
	ADD R4, R4, #-1
	BRp FILL_LOOP
	
	LD R1, ARRAY_ADDR	; Reload the starting address of the array
	
	LDR R2, R1, #6		; Obtain the seventh value in the array and store in R2

	HALT
	
; Local Data -----------------------------------------------------------
	ARRAY_ADDR		.FILL		x4000
	fillCount		.FILL		#10
	
; Remote Data ----------------------------------------------------------
.ORIG x4000
	.BLKW		#10
	
.END
