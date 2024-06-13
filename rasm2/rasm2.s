  //--------------------------------------------------------------------------------
  //     NAME:  Romina Pouya
  //  PROGRAM:  RASM2
  //    CLASS:  CS3B
  //     DATE:  3/14/2024
  //--------------------------------------------------------------------------------
	.global _start // Provide program starting address

	.data
		szName:			.asciz	"    NAME:    Romina Pouya\n" //declare a string with a name
		szProgram:		.asciz	"    PROGRAM: RASM2\n"        // declare a string with a program name
		szClass:		.asciz	"    CLASS:   CS3B\n"         //declare a string with a class name
		szDate:			.asciz	"    DATE:    3/14/2024\n"    //declare a string with a date
		szPmtA:			.asciz	"Enter your first number:   "         //declare a string for prompting the first num
		szPmtB:			.asciz	"Enter your second number:  "         //declare a string for prompting the second num
		szPmtSum:		.asciz	"The sum is "                     //declare a string to  show the sum
		szPmtDiff:		.asciz	"The difference is "         	 //declare a string to otput the difference
		szPmtProd:		.asciz	"The product is "			     // declare a string to output the product 
		szPmtQuot:		.asciz	"The quotient is "			     //declare a string to output the quotiont 
		szPmtRem:		.asciz	"The remainder is "				//declare a string to output th remainder
		szDivByZero:	.asciz	"You cannot divide by 0. Thus, there is no quotient or remainder\n" //for error
		szOverflowAdd:	.asciz	"OVERFLOW occured when ADDING\n"		//for overfllow when adding 
		szOverflowSub:	.asciz	"OVERFLOW occured when SUBTRACTING\n" //for overflow when subtracting
		
		szErrorMul:			.asciz	"RESULT OUTSIDE ALLOWABLE 64 BIT SIGNED INTEGERE RANGE WHEN MULTIPLYING\n"
		szInvalidString:	.asciz	"INVALID NUMERIC STRING. RE-ENTER VALUE\n"
		szInvalidInteger:	.asciz	"NUMBER OUTSIDE ALLOWABLE 64 BIT SIGNED INTEGER RE-ENTER VALUE:\n"
		szGoodbye:			.asciz	"Thanks for using my program!! Good day!"

// Declare storage locations
		iLimitNum:	.word	21 // Declare a word indicating the limit for input strings
		dbA:	.quad	0 		// Declare a quadword for storing input A
		dbB:	.quad	0 		// Declare a quadword for storing input B
		dbSum:	.quad	0 		// Declare a quadword for storing sum
		dbDiff:	.quad	0		// Declare a quadword for storing difference
		dbProd:	.quad	0		 // Declare a quadword for storing product
		dbQuotient:	.quad	0 	// Declare a quadword for storing quotient
		dbRem:	.quad	0 		// Declare a quadword for storing remainder
		szA:	.skip	21 		// Declare space for string A
		szB:	.skip	21 		// Declare space for string B
		szSum:	.skip	21 		// Declare space for string sum
		szDiff:	.skip	21 		// Declare space for string difference
		szProd:	.skip	21 		// Declare space for string product
		szQuot:	.skip	21		 // Declare space for string quotient
		szRem:	.skip	21		 // Declare space for string remainder
		chCr:	.byte	10		 // Declare a byte for carriage return
		
	.text

_start:
	


_start: // Entry point of the program

	// Print information about the program
	ldr		x0,	=szName		// Load address of szName into x0
	bl		putstring		// Call putstring function to print szName
	ldr		x0,	=szProgram	// Load address of szProgram into x0
	bl		putstring		// Call putstring function to print szProgram
	ldr		x0,	=szClass	// Load address of szClass into x0
	bl		putstring		// Call putstring function to print szClass
	ldr		x0,	=szDate		// Load address of szDate into x0
	bl		putstring		// Call putstring function to print szDate
	ldr		x0,	=chCr		// Load address of chCr into x0
	bl		putch			// Call putch function to print carriage return
	ldr		x0,	=chCr		// Load address of chCr into x0
	bl		putch			// Call putch function to print carriage retur


promptA: // Label for prompt A

	ldr		x0,	=szPmtA		// Load address of szPmtA into x0
	bl		putstring		// Call putstring function to print prompt for A
	ldr		x0,	=szA		// Load address of A
	bl		getstring		// Call getstring function to get input string for A
	ldr		x0,	=szA		// Load address of A
	ldrb	w0,	[x0]		// Load the first byte of szA into w0
	cmp		w0,	#0			// Compare w0 with 0
	b.eq	end				// Branch to end if w0 is equal to 0 (end of input)
	bl		stringACheck	// Call stringACheck function to check if the string is valid to convert
	ldr		x0,	=szA		// Load address of A
	bl		ascint64		// Call ascint64 function to convert the value to quad
	ldr		x1,	=dbA		// Load address of A quad
	str		x0,	[x1]	// Store the quad in dbA
	b.vs	inputAOverflow	// Branch to inputAOverflow if overflow occurs
	b		promptB		// Branch to promptB to ask for input B



stringACheck:
	ldr		x1,	=szA				// Load the address of string A into x1
	mov		x0,	#0					// Initialize the counter i to 0
	ldrb	w3,	[x1,	#20]		// Load the last character of the string into w3
	cmp		w3,	#0					// Compare the last character with 0
	b.ne	aLengthError			// If not equal, branch to aLengthError (buffer is too long)
	ldrb	w2,	[x1,	x0]			// Load the first byte of the string into w2
	cmp		w2,	#'-'				// Compare w2 with the ASCII value of hyphen
	b.eq	hyphenCheckA			// If equal, branch to hyphenCheckA (to check for negative sign)
	stringACheckLoop:
		ldrb	w2,	[x1,	x0]		// Load the character at index x0 of the string into w2
		cmp		w2,	#0				// Check if the character is null (end of string)
		b.eq	checkADone			// If equal, branch to checkADone (end of string)
		cmp	w2,		#'0'			// Compare the character with the ASCII value of '0'
		b.lo	stringAError		// If less than zero, branch to stringAError (invalid character)
		cmp		w2,	#'9'			// Compare the character with the ASCII value of '9'
		b.hi	stringAError		// If greater than nine, branch to stringAError (invalid character)
		add	x0,	x0,	#1				// Increment counter i by 1
		b.ne	stringACheckLoop	// Branch to stringACheckLoop if not end of string
hyphenCheckA:
	add	x0,	x0,	#1				// Increment x0 to avoid the first index
	b	stringACheckLoop		// Branch back to stringACheckLoop

stringAError:
	ldr	x0,	=szInvalidString	// Load the address of the invalid string message into x0
	bl	putstring				// Call putstring to print the invalid string message
	b	promptA					// Branch to promptA to prompt the user again

inputAOverflow:
	ldr	x0,	=szInvalidInteger		// Load the address of the invalid integer message into x0
	bl	putstring					// Call putstring to print the invalid integer message
	b	promptA					// Branch to promptA to prompt the user again

aLengthError:
	ldr	x0,	=szInvalidInteger	// Load the address of the invalid integer message into x0
	bl	putstring			// Call putstring to print the invalid integer message
	b	promptA				// Branch to promptA to prompt the user again

checkADone:

	ret	// Return from the function
	
promptB:
	ldr		x0,	=szPmtB	// Load address of szPmtB into x0 (prompt for B)
	bl		putstring	// Call putstring to print prompt for B
	ldr		x0,	=szB	// Load address of B
	bl		getstring	// Call getstring to get input string for B
	ldr		x0,	=szB	// Load address of B
	ldrb	w0,	[x0]	// Load the first byte of szB into w0
	cmp		w0,	#0		// Compare w0 with 0
	b.eq	end				// If equal, branch to end (user inputs CR, end the program)
	bl		stringBCheck	// Call stringBCheck to check if the string is valid to convert
	ldr		x0,	=szB	// Load address of B
	bl		ascint64	// Call ascint64 to convert the value to quad
	ldr		x1,	=dbB	// Load address of B quad
	str		x0,	[x1]	// Store the quad in dbB
	b.vs	inputBOverflow	// If overflow, branch to inputBOverflow
	b		sum			// Otherwise, branch to sum


stringBCheck:
	ldr	x1,	=szB		// Load adress of string B
	mov	x0,	#0			// i = 0
	ldrb	w3,	[x1,	#20]	// Check last character
	cmp	w3,	#0			// Check if 0
	b.ne	bLengthError		// Buffer is too long
	ldrb	w2,	[x1,	x0]	// Check for hyphen for negative
	cmp	w2,	#'-'		// If it is a hyphen...
	b.eq	hyphenCheckB		// Go to hyphenCheckA

	stringBCheckLoop:
		ldrb	w2,	[x1,	x0]	// Loads first byte into w3
		// Now need to check if 48 <= x <= 57
		cmp	w2,	#0		// Check if reached end of string
		b.eq	checkBDone		// Goes back to promptB
		cmp	w2,	#'0'		// Check if less than 0
		b.lo	stringBError		// Jump to string error
		cmp	w2,	#'9'		// Compare with 57
		b.hi	stringBError		// Jump to string error
		add	x0,	x0,	#1	// Add 1 to x0
		b.ne	stringBCheckLoop	// Loop until completed

hyphenCheckB:
	add		x0,	x0,	#1			// Increment x0 to avoid the first index
	b		stringBCheckLoop	// Branch back to stringBCheckLoop

stringBError:
	ldr		x0,	=szInvalidString	// Load the address of the invalid string message into x0
	bl		putstring			// Call putstring to print the invalid string message
	b		promptB				// Branch to promptB to prompt the user again

inputBOverflow:
	ldr		x0,	=szInvalidInteger	// Load the address of the invalid integer message into x0
	bl		putstring			// Call putstring to print the invalid integer message
	b		promptB				// Branch to promptB to prompt the user again

bLengthError:
	ldr		x0,	=szInvalidInteger	// Load the address of the invalid integer message into x0
	bl		putstring			// Call putstring to print the invalid integer message
	b		promptB				// Branch to promptB to prompt the user again


checkBDone:
	ret

sum:
	ldr	x0,	=dbA			// Load A integer
	ldr	x0,	[x0]			// Dereference
	ldr	x1,	=dbB			// Load B integer
	ldr	x1,	[x1]			// Dereference
	adds	x0,	x0,	x1		// Add both values and store in x0
	b.vs	sumOverflow			// Check for sum overflow
	ldr	x2,	=dbSum			// Load Sum integer
	str	x0,	[x2]			// Store integer into dbSum
	ldr	x1,	=szSum			// Load Sum string
	bl 	int64asc			// Convert sum to string
	ldr	x0,	=szPmtSum		// Load sum prompt
	bl	putstring			// Print sum prompt
	ldr	x0,	=szSum			// Load sum string
	bl	putstring			// Print sum string
	ldr	x0,	=chCr			// Load chCr
	bl	putch				// Print CR
	b	difference			// Move onto difference calc

sumOverflow:
	ldr	x0,	=szOverflowAdd		// Add error message
	bl	putstring			// print error message
	b	difference			// Move onto difference calc

difference:
	ldr	x0,	=dbA			// Load A integer
	ldr	x0,	[x0]			// Dereference
	ldr	x1,	=dbB			// Load B integer
	ldr	x1,	[x1]			// Dereference
	subs	x0,	x0,	x1		// Subtract both values and store in x0
	b.vs	diffOverflow			// If overflow go to handling
	ldr	x2,	=dbDiff			// Load Diff integer
	str	x0,	[x2]			// Store integer into dbDiff
	ldr	x1,	=szDiff			// Load Diff string
	bl 	int64asc			// Convert sum to string
	ldr	x0,	=szPmtDiff		// Load sum prompt
	bl	putstring			// Print sum prompt
	ldr	x0,	=szDiff			// Load sum string
	bl	putstring			// Print sum string
	ldr	x0,	=chCr			// Load chCr
	bl	putch				// Print CR
	b	product				// Move onto product calc

diffOverflow:
	ldr	x0,	=szOverflowSub		// Add error message
	bl	putstring			// Print error message
	b	product				// Move onto product calculator

product:
	ldr	x0,	#0			// Index for loop
	ldr	x1,	=dbA			// Load A integer
	ldr	x1,	[x1]			// Dereference
	ldr	x2,	=dbB			// Load B integer
	ldr	x2,	[x2]			// Dereference
	ldr	x3,	#0			// Instantiate product
	smulh	x3,	x1,	x2		// Check for overflow
	cmp	x3,	#0			// Check CMP
	b.gt	productOverflow			// Check if product is overflowed
	mul	x3,	x1,	x2		// Multiply
	ldr	x4,	=dbProd			// Load dbProd address
	str	x3,	[x4]			// Store value into dbProd
	mov	x0,	x3			// Move value into x0 register
	ldr	x1,	=szProd			// Load product string
	bl	int64asc			// Convert to ascii
	ldr	x0,	=szPmtProd		// Load product prompt
	bl	putstring			// Print product prompt
	ldr	x0,	=szProd			// Load product string
	bl	putstring			// Print product string
	ldr	x0,	=chCr			// Load CR
	bl	putch				// Print CR
	b	quotient			// Go to quotient

productOverflow:
	ldr	x0,	=szErrorMul		// Print multiply error
	bl	putstring			// Print multiply error
	b	quotient			// Move onto quotient

quotient:
	ldr	x0,	#0			// Index for loop
	ldr	x1,	=dbA			// Load A integer
	ldr	x1,	[x1]			// Dereference
	ldr	x2,	=dbB			// Load B integer
	ldr	x2,	[x2]			// Dereference
	cmp	x2,	#0			// Find if divisor is 0
	b.eq	divideByZero			// Handle divide by zero
	ldr	x3,	#0			// Initialize quotient
	ldr	x4,	#0			// Initialize product to find remainder
	ldr	x5,	#0			// Initialize remainder
	sdiv	x3,	x1,	x2		// Find quotient
	mul	x4,	x3,	x2		// Find multiplied by quotient
	sub	x5,	x1,	x4		// Find remainder
	ldr	x0,	=dbQuotient			// Load quotient
	str	x3,	[x0]			// Store into quotient
	ldr	x0,	=dbRem			// Load remainder
	str	x5,	[x0]			// Store into remainder
	ldr	x0,	=dbQuotient		// Load quotient
	ldr	x0,	[x0]			// Dereference
	ldr	x1,	=szQuot			// Load quotient string address
	bl	int64asc			// Convert to string
	ldr	x0,	=dbRem			// Load remainder
	ldr	x0,	[x0]			// Dereference
	ldr	x1,	=szRem			// Load remainder string address
	bl	int64asc			// Convert to string
	ldr	x0,	=szPmtQuot		// Load quotient prompt
	bl	putstring			// Print string
	ldr	x0,	=szQuot			// Load quotient address
	bl	putstring			// Print quotient
	ldr	x0,	=chCr			// Load CR
	bl	putch				// Print CR
	ldr	x0,	=szPmtRem		// Load remainder prompt
	bl	putstring			// Print prompt
	ldr	x0,	=szRem			// Load remainder string
	bl	putstring			// Print prompt
	ldr	x0,	=chCr			// Load CR
	bl	putch				// Print CR
	ldr	x0,	=chCr			// Load CR
	bl	putch				// Print CR
	b	promptA				// Go to end
	
divideByZero:
	ldr	x0,	=szDivByZero		// Divide by Zero Error String
	bl	putstring			// Print string
	ldr	x0,	=chCr			// Load CR
	bl	putch				// Print CR
	b	promptA				// Go to end

end:
	ldr	x0,	=chCr			// Load CR
	bl	putch				// Print CR
	ldr	x0,	=szGoodbye		// Print goodbye string
	bl	putstring			// Print string
	ldr	x0,	=chCr			// Load CR
	bl	putch				// Print CR
	ldr	x0,	=chCr			// Load CR
	bl	putch				// Print CR
	
  // Setup the parameters to exit the program and then call Linux to do it.
	mov	x0,	#0	// Sets return code to 0
	mov	x8,	#93	// Service command code 93 terminates
	svc	0	// Call linux to terminate the program
	.end


