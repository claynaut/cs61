;=================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 2, ex 4
; Lab section: <omitted>
; TA: <omitted>
; 
;=================================================
.ORIG x3000

; Main Instructions ----------------------------------------------------
	LD R0, HEX_61
	LD R1, HEX_1A
	
	PRINT_LOOP
		OUT
		ADD R0, R0, #1
		
		ADD R1, R1, #-1
		BRp PRINT_LOOP
	
	HALT

; Local Data -----------------------------------------------------------
	HEX_61		.FILL		x61
	HEX_1A		.FILL		x1A

.END
