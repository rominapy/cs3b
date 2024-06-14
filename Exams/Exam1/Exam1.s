   .global _start  
     /*****************************
       NAME : Romina Pouya
       Class: CS3b
         LAB: EXAM1
      ***********************************/
    .data
// helper strings for output
szHeader:   .asciz " Name: Romina Pouya \nClass: CS 3B \n   Lab: Exam1\n"  // header
szPrompt:   .asciz "Enter "     //  prompt for input
szCol:      .asciz ": "         // colon for input
szMult:     .asciz " * "        // for output equation
szPlus:     .asciz " + "        //  plus sign for output equation
szEq:       .asciz " = "        //  equals sign for output equation

// helper chars for output
chLF:		   .byte 0xa //  newline for output
cLF:    .ascii "\n"     // char newline for output
cTwo:   .ascii "2"      //  for output equation
cOP:    .ascii "("      // ( for output equation
cCP:    .ascii ")"      //  ) for output equation

// x, y, and ans in char, int, and string
cX:     .ascii "x"      // char x for input
cY:     .ascii "y"      // char y for input
dbX:     .quad 0         // int x to store input
dbY:     .quad 0         // int y to store input
iAns:   .quad 0         // int ans to store calculation result
szX:    .skip 8         // string x for output equation
szY:    .skip 8         // string y for output equation
szAns:  .skip 8         // string answer for output answer

    
    .text
_start:
    // OUTPUTING NAME 
    LDR X0,=szHeader  // load header address to register 
    BL putstring      // branch and link to string output function

    // PROMPT AND READ THE INPUT for x
    
        
    LDR X0,=szPrompt    // load prompt address for putstring function
    bl putstring        // branch and link to string output function
    LDR X0,=cX       // load address of character
    bl putch            // branch and link to char output funciton
    LDR X0,=szCol        // load address of :
    BL putstring            // branch and link to string output funciton

    // collect input 
    LDR X0,=szX       // load string address for string input function
    MOV X1, #16         // load string length for string input function
    BL getstring        // call string input function

    // convert input to integer
    LDR X0,=szX      // load string address for conversion
    BL ascint64         // call conversion function
    LDR X1,=dbX       // load address to hold integer value of input
    STR X0,[X1]         // store integer value of input

//------------PROMPT AMD READ THE INPUT FOR Y   
    LDR X0,=szPrompt    // load prompt address for putstring function
    bl putstring        // branch and link to string output function
    LDR X0,=cY       // load address of character
    bl putch            // branch and link to char output funciton
    LDR X0,=szCol        // load address of :
    BL putstring            // branch and link to string output funciton

    
    LDR X0,=szY      // load string address for string input function
    MOV X1, #16         // load string length for string input function
    BL getstring        // call string input function

    // convert to integer
    LDR X0,=szY      // load string address for conversion
    BL ascint64         // call conversion function
    LDR X1,=dbY       // load address to hold integer value of input
    STR X0,[X1]         // store integer value of input






    // output equation 2 * (X + 2 * Y) = 
    LDR X0,=cLF     // load address of \n
    bl putch        // branch and link to char output function
    LDR X0,=cTwo    // load address of 2
    bl putch        // branch and link to char output function
    LDR X0,=szMult  // load address of *
    bl putstring    // branch and link to string output function
    LDR X0,=cOP     // load address of (
    bl putch        // branch and link to char output funciton
    LDR X0,=szX     // load address of x
    bl putstring    // branch and link to string output function
    LDR X0,=szPlus  // load address of +
    bl putstring    // branch and link to string output funciton
    LDR X0,=cTwo    // load address of 2
    bl putch        // branch and link to char output function
    LDR X0,=szMult  // load address of *
    bl putstring    // branch and link to string output function
    LDR X0,=szY     // load address of Y
    BL putstring    // branch and link to string output function
    LDR X0,=cCP     // load address of )
    bl putch        // branch and link to char output function
    LDR X0,=szEq    // load address of =
    bl putstring    // branch and link to char output function

    // load answers into registers for calculation 2 * (X + 2 * Y) = ans
    LDR X2,=dbX      // load integer register for X
    LDR X2,[X2]     // move X value into X2
    LDR X3,=dbY      // load integer register for Y
    LDR X3,[X3]     // move Y value into X3

    // calculate ans (X0)
    ADD X0,X3,X3    // ans = y + y or ans = 2y
    ADD X0,X2,X0    // ans = x + ans or ans = x + 2y
    ADD X0,X0,X0    // ans = ans + ans or ans *= 2 or ans = 2 * (x + 2y)

    // store answer (not necessary, but nice if code is expanded)
    LDR X1,=iAns    // load address to store answer
    STR X0,[X1]     // store answer (X0) into address of X1 (iAns)

    // convert answer to string
    LDR X1,=szAns   // load address to save string answer
    bl int64asc     // convert int ans to string, using John's function

    // print the answer
    LDR X0,=szAns   // load the address for string answer
    bl putstring    // branch and link to string output function

    // print newline
    LDR X0,=chLF     // load address of newline
    bl putch        // branch and link to char output function

    // end program
    MOV X0, 0       // move 0 to X0, program finished correctly
    MOV X8, #93     // have linux call 93 to terminate program
    SVC 0           // call to linux to terminate program
    .end   


