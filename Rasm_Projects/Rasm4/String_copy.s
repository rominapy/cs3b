   
	.global String_copy

	.text
String_copy:
	STR x19, [SP, #-16]!	// Push
	STR x20, [SP, #-16]!	// Push
	STR x21, [SP, #-16]!	// Push
	STR x22, [SP, #-16]!	// Push
	STR x23, [SP, #-16]!	// Push
	STR x24, [SP, #-16]!	// Push
	STR x30, [SP, #-16]!	// Push LR

	MOV x23, #0		// x23 intialize to zero (prevent invalid data)

	MOV x19, x0		// x19 = Original String
	BL String_length	// calculates string_length

	MOV x24, x0
	SUB x24, x24, #1
	LDRB w22, [x19, x24]	// load byte at the end.
	CMP  w22, #0xa		// check for a \n at the end
	BEQ  skip		// branch to skip

	ADD x24, x24, #1	// increment x24
	ADD x0, x0, #1		// increase length by 1
	MOV x23, #1		// x23 = flag to add NewLine

skip:
	ADD x0,x0,#1		// add 1 to length to account for null
	BL malloc		// creates pointer to allocated memory in heap

	MOV x21, x0		// x21 = ptr to memory in heap
copy:
	LDRB w20, [x19], #1	// w20 = char str[i]
	STRB w20, [x0], #1	// store str[i] in new string

	CMP w20, #0x00		// check for null character
	B.NE copy		// loop back if not found

	CMP w23, #1		// check for \n flag
	B.NE end_copy		// branch to end copy if not found

	MOV w20, #0xa		// load \n into x20
	STRB w20, [x21, x24]	// store \n into copied string

	MOV x20, #0x0		// load a null terminator
	STRB w20, [x0], #1	// store at end of input string

end_copy:
	MOV x0, x21		// x0 = ptr to new string

	LDR x30, [SP], #16	// POP LR
	LDR x24, [SP], #16	// POP
	LDR x23, [SP], #16	// POP
	LDR x22, [SP], #16	// POP
	LDR x21, [SP], #16	// POP
	LDR x20, [SP], #16	// POP
	LDR x19, [SP], #16	// POP
	RET LR			// Return

	.end
    
