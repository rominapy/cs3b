  

	.global display_strings

	.data
chSP:		.byte	32		// " "
chLS:		.byte	60		// "<"
chRS:		.byte	62		// ">"
szIndDS:	.skip	21		// index converted into a string
szErr:		.asciz	"[EMPTY]\n"

	.text


display_strings:

	STR x19, [SP, #-16]!		// Push
	STR x20, [SP, #-16]!		// Push
	STR x30, [SP, #-16]!		// Push LR

	MOV x19, x0			// copy headPtr
	LDR x19, [x19]			// load address first node
	MOV x21, #0			// x21 = index = 0
	CMP	x19, #0			// compare headPtr to 0
	BEQ	display_empty	// Branch to display_empty if empty list


display:
	MOV x0, x21			// x0 = index
	LDR x1,=szIndDS			// point to szIndDS
	BL  int64asc			// convert index value to a string

	LDR x0,=chLS			// point to chLS
	BL  putch			// display to terminal

	LDR x0,=szIndDS			// point to szIndDS
	BL  putstring			// display to terminal

	LDR x0,=chRS			// point to chRS
	BL  putch			// display to terminal

	LDR x0,=chSP			// point to chSP
	BL  putch			// display to terminal

	LDR x0, [x19]			// load address of string
	BL  putstring			// display to terminal

	LDR x20, [x19, #8]		// x20 = next node
	MOV x19, x20			// x19 = next node

	ADD x21, x21, #1		// x21 = index + 1

	CMP x19, #0x00			// compare x19 for null
	BNE display			// Branch back if not found
	B	end_display		// Branch when done


display_empty:
	LDR	x0,=szErr		// *x0 szErr
	BL	putstring		// print szErr


end_display:
	LDR x30, [SP], #16		// POP LR
	LDR x20, [SP], #16		// POP
	LDR x19, [SP], #16		// POP

	RET				// Return
	.end
    