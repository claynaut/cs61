;=================================================
; Name: Jamella Suzanne Pescasio
; Email: <omitted>
; 
; Lab: lab 1, ex 0
; Lab section: <omitted>
; TA: <omitted>
; 
;=================================================
.ORIG x3000

; Instructions ---------------------------------------------------------
	LEA R0, MSG_TO_PRINT
	PUTS
	
	HALT
	
; Local Data -----------------------------------------------------------
	MSG_TO_PRINT	.STRINGZ	"Hello world!!!\n"

.END
