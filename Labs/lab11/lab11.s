 /*------------------------------------
 Romina Pouya
 Lab11
 
 -------------------------------------- */   

    .global _start 


         .data
     szX:        .asciz "Cat"
     szY:        .asciz "in the hat."
     ptrString:   .quad 0

        .text
    
_start:
    mov     x0, #18  //needed bytes to store the string
    bl      malloc   //creating memory allocation

    ldr     x1,=ptrString  // put the pointer string
    str     x0, [x1]       //put the pointer string
    ldr     x1, =szX  //setting the pointer

	ldr	    x1,	[x1]	// Dereference
	str	    x1,	[x0], #3	// Store cat in x0

	mov	    w1,	#' '	// Store 20 immediate value for " "
	strb	w1,	[x0], #1	// Store space after cat

	ldr	    x1,	=szY	// Load in the hat
	ldr 	x2,	[x1], #8	// Load first 32 bits

	ldr 	x3,	[x1]	// Dereference hat
	stp 	x2,	x3,	[x0]	// Store in pointer

	ldr	    x0,	=ptrString	// Get string pointer
	ldr	    x0,	[x0]		// Get value for pointer

	mov	    x1,	#0		// Clear x1
	bl	    putstring	// Print the string

    LDR     X0,=ptrString
    LDR     X0,[X0]
    BL      free


    // Setup the parameters to exit the program and then call Linux to do it.
	mov	    x0,	#0	// Sets return code to 0
	mov 	x8,	#93	// Service command code 93 terminates
	svc	    0	// Call linux to terminate the program
	.end
