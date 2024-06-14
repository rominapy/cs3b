//Romina Pouya
//Lab 7
	.globl _start

	.equ BUFFER, 21

	.data

bA:	     		.skip 	1
chInit:			.skip 	1
u16Hi:			.hword	0
wAlt:			.word	0,0,0
szMsg1:			.skip	10
dbBig: 			.quad	0


chlF:			.byte	0xa // New line Feed


szBuffer:		.skip BUFFER

sz1:			.asciz "bA= "
sz2:			.asciz "chInit=  "
sz3:			.asciz "u16Hi= "
sz4:			.asciz "wAlt[0]: "
sz5:			.asciz "wAlt[1]: "
sz6:			.asciz "wAlt[2]: "
sz7:			.asciz "szMsg1= "
sz8:			.asciz "dbBig=  "

	.text

_start:

	// -----------------------bA-------------
	ldr	x0, =sz1	// loading the address of s1
	bl 	putstring	// calling the putsring


	ldr	x0, =bA		// loading the address of ba
	mov	x1, #0x9B	// loading 155 decimal or 95 hex to x1 register

	strb	w1, [x0]	// storing  the value of register 1 to ba variable in memory

	ldrb	w0, [x0]	//loading the value of the ba to the x0 register

	ldr 	x1, =szBuffer	// having the buffer in x1
	bl 	int64asc	// caling the int64asc function

	ldr	x0,=szBuffer	// loading the address  of the buffer
	bl 	putstring	// calling the putstring


	ldr	x0,=chlF	// the ned new  line
	bl 	putch		// calling the putch function 





	// -------------chInit--------------------------

	ldr	x0, =sz2	// loading the address of szG
	bl 	putstring	// calling the putstring


	ldr	x0, =chInit	// loading the address of chInt
	mov 	x1, 'j'		// loading  j to  x1

	str	x1, [x0]	// storing that value in memory
	bl 	putch		// calling putch function


	ldr	x0,=chlF	// the ned new  line
	bl 	putch		// calling the putch function 








	// ------------------ u16Hi-------------------------------
	ldr	x0, =sz3	// loading the address of szE
	bl 	putstring	// calling the putstring


	ldr	x0, = u16Hi	// loading the address of  u16Hi
	mov 	x1, 88		// loading 88 to the x1 register

	strh	w1, [x0]	// storing that value to u16Hi

	ldrh	w0, [x0]	// loading the a byte  into the register


	ldr 	x1, =szBuffer	// having the buffer in x1
	bl 	int64asc	// caling the int64asc function

	ldr	x0,=szBuffer	// loading the address  of the buffer
	bl 	putstring	// calling the putstring

	ldr	x0,=chlF	// the ned new  line
	bl 	putch		// calling the putch function 





	//-----------wAlt[0]---------------
	ldr	x0, =sz4
	bl 	putstring


	ldr	x0, = wAlt	// wAlt[0]

	mov 	x1, 16		// loading 16 to x1

	str	x1, [x0]	// store it in wAlt[0]
	ldr	x0, [x0]	// wAlt[1]


	// x0 =  0 + gned extendded byte

	mov 	x2, #0
	add	x0, x2,x0,SXTW


	ldr 	x1, =szBuffer	// having the buffer in x1
	bl 	int64asc	// caling the int64asc function

	ldr	x0,=szBuffer	// loading the address  of the buffer
	bl 	putstring	// calling the putstring

	ldr	x0,=chlF	// the ned new  line
	bl 	putch		// calling the putch function 








	// signed extention needed 
	// ----------------wALt[1]------------------
	ldr	x0, =sz5
	bl 	putstring


	ldr	x0, = wAlt	// wAlt[0]
	add	x0, x0, #4	// wAlt[1]

	mov	x1, -1		// load -1
	str	x1, [x0]	// store -1 in wAlt[1]

	ldrsw	x0, [x0]  //load



	ldr 	x1, =szBuffer	// having the buffer in x1
	bl 	int64asc	// caling the int64asc function

	ldr	x0,=szBuffer	// loading the address  of the buffer
	bl 	putstring	// calling the putstring

	ldr	x0,=chlF	// the ned new  line
	bl 	putch		// calling the putch function 



	// signed extention needed 
	// *********** doing the wALt[2] **********
	ldr	x0, =sz6
	bl 	putstring


	ldr	x0, = wAlt	// wAlt[0]
	add	x0, x0, #8	// wAlt[2]

	mov	x1, -2		// load -2 to x1 register
	str	x1, [x0]	//store it to wAlt[2]

	ldrsw	x0, [x0]	// load it in sign extended bits





	ldr 	x1, =szBuffer	// having the buffer in x1
	bl 	int64asc	// caling the int64asc function

	ldr	x0,=szBuffer	// loading the address  of the buffer
	bl 	putstring	// calling the putstring

	ldr	x0,=chlF	// the ned new  line
	bl 	putch		// calling the putch function 




	// -----------------szMsg1-----------------------------



	ldr	x0, =sz7	// loading the address of szH
	bl 	putstring	// calling the putstring function

	ldr 	x0, =szMsg1	// loadibng the address of szMsg1

	mov 	w1, 'A'
	strb	w1, [x0]

	mov	w1, 'n'
	strb	w1,[x0, 1]

	mov	w1, 'd'
	strb	w1, [x0,2]

	mov	w1, ' '
	strb 	w1, [x0,3]

	mov	w1, 'S'
	strb	w1, [x0,4]

	mov 	w1, 'a'
	strb	w1, [x0, 5]

	mov 	w1, 'l'
	strb	w1, [x0, 6]

	mov 	w1, 'l'
	strb	w1, [x0, 7]

	mov	w1, 'y'
	strb	w1, [x0, 8]

	mov	x1, 0
	strb	w1, [x0, 9] // store "And Sally" to the szMsg1

	bl 	putstring	// calling the putstring function

	ldr	x0,=chlF	// the ned new  line
	bl 	putch		// calling the putch function 




	// ---------------- doing the dbBig -----------------
	ldr	x0, =sz8
	bl 	putstring

	ldr	x0, = dbBig    //loading dbBibg

	mov 	x1, 9223372036854775807	// loading that number to x1
	str	x1, [x0]		// storing it in sbBig variable in memory

	ldr	x0, [x0]	// a quad or double word


	ldr 	x1, =szBuffer	// setting the buffer in x1
	bl 	int64asc	// branch and link the int64asc function

	ldr	x0,=szBuffer	// loading the buffer
	bl 	putstring	// branch and link putstring

	ldr	x0,=chlF	// the ned new  line
	bl 	putch		// calling the putch function 

	//End of the program
	mov x0, #0
	mov x8, #93
	svc 0

.end
