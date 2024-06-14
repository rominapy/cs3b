   .global _start

   .data
szX:		.asciz "10"
szY:		.asciz "15"
szSum:		.skip   21
dbX:		.quad 0
dbY:		.quad 0
dbSum:		.quad 0
chLF:		.byte 0xa     // (NL line feed, new line)
szPlus:		.asciz  "  +  "
szEquals: 	.asciz  "  =  "
   .text

_start:
   // loads, converts, stores szX into dbX
   ldr		x0 ,=szX  //X0-> address of szX
   bl		    ascint64 //branch and link to asscint64(convertc-string to int)
                     //X0 contains the result of ascint64
   ldr		x1,=dbX  // load into X1 address od dbX
   str		x0, [x1]  // save the result into dbs
   
  //************print  X************************
   ldr		x0, =szX
   bl           putstring

  // *************print (+) ***********************

   ldr 	         x0, =szPlus
   bl            putstring

// you figure out how to process szY
//.  loads , converts stores szY into dbY
   ldr     x0, =szY
   bl      ascint64

   ldr    x1, =dbY
   str     x0,[x1]
//.


//*************** print Y*************
   ldr       x0,=szY
   bl        putstring 

//******* dbSum = dbX + dbY*****************
   
   ldr		x1, =dbX  // X! -> address of dbX
   ldr	        x1, [x1]   // X1= dbX
   
   ldr		x2, =dbY  // X2-> address of dbY
   ldr		x2,[x2]   // X2 = dby
 
   add     	x0,x1,x2
   
 //********* store x0 into dbSum ************
   ldr    	    x3, =dbSum    //x3 is the address of dbSum
   str          x0, [x3] // the content of x0 is stored in x3


   ldr          x1, =szSum
   bl		       int64asc     //x0 contains the sum , x1 a pointer to where to save

//print (=) ***************************

   ldr 		 x0,=szEquals
   bl  		 putstring

   ldr 		 x0, =szSum
   bl 		 putstring
//  print new line  
   ldr 	        x0, =chLF
   bl           putch

//set up the parameteres to exit the program 



   mov X0, #0
   mov X8, #93
   svc 0
   .end

