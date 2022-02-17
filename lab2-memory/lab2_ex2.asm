;=================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 2, ex 2
; Lab section: <omitted>
; TA: <omitted>
; 
;=================================================
.ORIG x3000

; Main Instructions ----------------------------------------------------
	LDI R3, DEC_65_PTR
	LDI R4, DEC_41_PTR
	
	ADD R3, R3, #1
	ADD R4, R4, #1
	
	STI R3, DEC_65_PTR
	STI R4, DEC_41_PTR
	
	HALT

; Local Data -----------------------------------------------------------
	DEC_65_PTR		.FILL		x4000
	DEC_41_PTR		.FILL		x4001

.ORIG x4000
; Remote Data ----------------------------------------------------------
	.FILL		#65
	.FILL		x41

.END
