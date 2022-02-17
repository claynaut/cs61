;=================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 2, ex 3
; Lab section: <omitted>
; TA: <omitted>
; 
;=================================================
.ORIG x3000

; Main Instructions ----------------------------------------------------
	LD R5, DEC_65_PTR
	LD R6, DEC_41_PTR 

	LDR R3, R5, #0
	LDR R4, R6, #0
	
	ADD R3, R3, #1
	ADD R4, R4, #1
	
	STR R3, R5, #0
	STR R4, R6, #0
	
	HALT

; Local Data -----------------------------------------------------------
	DEC_65_PTR	.FILL	x4000
	DEC_41_PTR	.FILL	x4001

.ORIG x4000
; Remote Data ----------------------------------------------------------
	.FILL		#65
	.FILL		x41

.END
