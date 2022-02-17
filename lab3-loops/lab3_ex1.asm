;=================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 3, ex 1
; Lab section: <omitted>
; TA: <omitted>
; 
;=================================================
.ORIG x3000

; Main Instructions ----------------------------------------------------
	LD R5, DATA_PTR

	LDR R3, R5, #0
	ADD R3, R3, #1		; Increments the value that was stored at x4000
	STR R3, R5, #0		; Stores the updated value back into x4000
	
	ADD R5, R5, #1		; Increments the address stored in R5 (x4000 --> x4001)
	
	LDR R4, R5, #0
	ADD R4, R4, #1		; Increments the value that was stored at x4001
	STR R4, R5, #0		; Stores the updated value back into x4001
	
	HALT

; Local Data -----------------------------------------------------------
	DATA_PTR	.FILL	x4000

.ORIG x4000
; Remote Data ----------------------------------------------------------
	.FILL		#65
	.FILL		x41

.END
