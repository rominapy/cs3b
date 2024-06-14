  //  Romina Pouya
  //  LAB #5
  
  
  
   .global _start     // Global declaration of _start label
   .equ BUFFER, 21   // Define BUFFER constant as 21
   .equ MAX_LEN, 20  // Define MAX_LEN constant as 20
                     

   .data  
szA:        .skip BUFFER  // Allocate memory for the strings giving from the user
szB:        .skip BUFFER
szC:        .skip BUFFER
szD:        .skip BUFFER



szPrompt1:   .asciz "Enter A: "  
szPrompt2:   .asciz "Enter B: "
szPrompt3:   .asciz "Enter C: "
szPrompt4:   .asciz "Enter D: "
szMinus:     .asciz " - "
szPlus:      .asciz " + "
szEquals:    .asciz " = "
szSum:		.skip BUFFER  

chLF:		.byte 0xa      // Define ASCII code for line feed


dbA:   .quad 0
dbB:   .quad 0
dbC:   .quad 0
dbD:   .quad 0
dbSum: .quad 0

   .text

_start:

   //----prompt the user to enter A------
   ldr   x0, =szPrompt1     // Load address of szPrompt1 into x0
   bl    putstring          // Call putstring function to print prompt 1

   //---preparing to call getstring(x0,x1)
   ldr   x0, =szA      // Load address of szA into x0
   mov   x1,MAX_LEN    // Move MAX_LEN into x1 (length parameter)

   bl   getstring      // Call getstring function to read input for A

   //------prompt the user to enter B---------
   ldr   x0, =szPrompt2   // Load address of szPrompt2 into x0
   bl     putstring        // Call putstring function to print prompt 2


   //---preparing to call getstring(x0,x1)
   ldr   x0, =szB      // Load address of szB into x0
   mov   x1,MAX_LEN    // Move MAX_LEN into x1 (length parameter)

   bl   getstring      // Call getstring function to read input for B


   //------prompt the user to enter C--------
   ldr   x0, =szPrompt3   // Load address of szPrompt3 into x0
   bl     putstring      // Call putstring function to print prompt 3

     //---preparing to call getstring(x0,x1)
   ldr   x0, =szC      // Load address of szC into x0
   mov   x1,MAX_LEN   // Move MAX_LEN into x1 (length parameter)

   bl   getstring      // Call getstring function to read input for C

   //------prompt the user to enter D--------
   ldr   x0, =szPrompt4
   bl     putstring

   //---preparing to call getstring(x0,x1)
   ldr   x0, =szD
   mov   x1,MAX_LEN

   bl   getstring

   //------print the formula------------
   ldr   x0, =szA
   bl    putstring

   ldr   x0, =szMinus
   bl    putstring

   ldr   x0, =szB
   bl    putstring

   ldr   x0, =szPlus
   bl    putstring

   ldr   x0, =szC
   bl    putstring

   ldr   x0, =szMinus
   bl    putstring

   ldr   x0, =szD
   bl    putstring

   ldr   x0,=szEquals
   bl    putstring

   //----------preparing to call ascint64(x0)-------
   ldr   x0, =szA   // Load address of szA into x0
   bl    ascint64   // Call ascint64 function to convert A to int64


   ldr   x1, =dbA  //x1 contains the address of dbA(quad)
   str   x0,[x1]  //*x1 = contents of x1

   // Repeat the above process for B, C, and D


   //----------preparing to call ascint64(x0)-------
   ldr   x0, =szB
   bl    ascint64

   ldr   x1,=dbB
   str   x0,[x1]


   //----------preparing to call ascint64(x0)-------
   ldr   x0, =szC
   bl    ascint64

   ldr   x1,=dbC
   str   x0,[x1]


   //----------preparing to call ascint64(x0)-------
   ldr   x0, =szD
   bl    ascint64

   ldr   x1,=dbD
   str   x0,[x1]


   //-------------to draw the szA out of memory
   ldr   x1, =dbA
   ldr   x1, [x1]        // Load value of dbA into x0

   ldr   x2, =dbB       // Load value of dbB into x2
   ldr   x2, [x2]        

   ldr   x3, =dbC
   ldr   x3,[x3]


   ldr   x4, =dbD
   ldr   x4,[x4]

   sub   x0, x1, x2      // Subtract B from A
   add   x0, x0, x3     // sdd  C to it
   sub   x0, x0,x4      // subtract D from A-B+C

   ldr   x5, =dbSum   // Load address of dbSum into x5
   str   x0, [x5]     // Store result into dbSum

   ldr   x1,=szSum   // Load address of szSum into x1
   bl    int64asc    // Convert result to string

   

   ldr   x0, =szSum
   bl    putstring
  


   ldr   x0,=chLF
   bl    putch

/*****EXIT SEQUENCE*****/

   mov   x0, #0
   mov   x8, #93
   svc   0

   .end
