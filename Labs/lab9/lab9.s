
// Author: Romina Pouya
// Lab: 9


    .data
iArr:   .word 0,0,0,0,0,0,0,0,0,0   // Array of integers
szNum:  .skip 21                    // String buffer for number input
szMsg:  .asciz "Enter a number (int): " // Prompt for user input
cSpace: .ascii " "                  // Space for output between numbers
szEq:   .asciz " = "                 // Output equals
cLF:    .ascii "\n"                 // Newline for output

    .global _start
    .text
_start:
    // Getting the input from the user
    LDR X11,=iArr   // X11 holds pointer to int array
    MOV X12,#0      // X12 is our Loop Control Variable (LCV), initialize to 0   
    MOV X13,#0      // X13 is our sum, initialize to 0

    loop:  // for LCV in range(10)
        // Output prompt
        LDR X0,=szMsg  // Load string message to X0 for output
        BL putstring   // Call putstring function to output string

        // Collect input from user
        LDR X0,=szNum   // Load address to write input to
        MOV X1,#21      // Load size of input
        BL getstring    // Call function to collect user input
        
        // Load element [i] in iArr
        LDR X0,=szNum   // Point X0 to temporary cstring
        BL  ascint64    // Convert ascii to int
        ADD X13,X13,X0  // Add new int to sum
        STR X0,[X11]    // Store new int to iArr 
        ADD X11,X11,#4  // Increment &iArr by 4 bytes or sizeof(word)

    // End for
    ADD X12,X12,#1  // LCV += 1
    CMP X12,#10     // Compare LCV to 10
    B.LT loop       // Loop while LCV < 10

    // Printing the input from the user in the loop
    LDR X11,=iArr  // X11 holds pointer to string array
    MOV X12,#0     // X12 is our LCV, initialize to 0   

    print_loop:  // for x in iArr
        LDR W0,[X11],#4// Load iArr[i] to W0 (4 bytes) and increment to next
        LDR X1,=szNum   // Load string to store converted number 
        BL int64asc     // Convert int to ascii
        LDR X0,=szNum   // Load string number for output
        BL putstring    // Call function to output string number
        LDR X0,=cSpace  // Load " " for output
        BL putch        // Call char output function

    // End for
    ADD X12,X12,#1      // LCV += 1
    CMP X12,#10         // Compare LCV to 10
    B.LT print_loop     // Loop while LCV < 10

    // Printing sum
    LDR X0,=szEq    // Load string equals for output
    BL putstring    // Call string output function
    MOV X0,X13      // Move sum to X0 for function call
    LDR X1,=szNum   // Load sum string to X1 for function call
    BL int64asc     // Call int to ascii conversion function
    LDR X0,=szNum   // Load address of sum string for output
    BL putstring    // Call string output function
    LDR X0,=cLF     // Load newline for output
    BL putch        // Call char output function

    // End program
    MOV X0, 0       // Move 0 to X0, program finished correctly
    MOV X8, #93     // Have Linux call 93 to terminate program
    SVC 0           // Call to Linux to terminate program
    .end  
 
