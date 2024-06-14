//Author: Romina Pouya
//   Lab: #8
// Class: CS 3B
//----------------------------------------------------------------------------------


.global _start  // Declare the global symbol _start, which is where the program begins execution

.data  // Start the data section where variables are declared
szX:     .skip 8  // Reserve 8 bytes for szX
szY:     .skip 8  // Reserve 8 bytes for szY

iX: .quad 0  // Declare a quadword (8 bytes) variable iX and initialize it to 0
iY: .quad 0  // Declare a quadword (8 bytes) variable iY and initialize it to 0

szEnter: .asciz "Enter "  // Declare a null-terminated string szEnter and initialize it to "Enter "
szEq:    .asciz " == "  // Declare a null-terminated string szEq and initialize it to " == "
szGT:    .asciz " > "  // Declare a null-terminated string szGT and initialize it to " > "
szCol:   .asciz ": "  // Declare a null-terminated string szCol and initialize it to ": "
cX:      .ascii "x"  // Declare a character cX and initialize it to 'x'
cY:      .ascii "y"  // Declare a character cY and initialize it to 'y'
cLF:     .ascii "\n"  // Declare a character cLF and initialize it to newline '\n'

.text  // Start the text section where the code is written
_start:  // The entry point of the program

MOV X20, #1  // Initialize the counter register X20 to 1
loop_start:  // Start of the loop
    CMP X20, #0  // Compare the counter register X20 to 0
    B.LE end_program  // If X20 is less than or equal to 0, branch to end_program

    // Output "Enter x: "
    LDR X0,=szEnter  // Load the address of szEnter into X0
    BL putstring  // Call the function putstring to output the string at the address in X0
    LDR X0,=cX  // Load the address of cX into X0
    BL putch  // Call the function putch to output the character at the address in X0
    LDR X0,=szCol  // Load the address of szCol into X0
    BL putstring  // Call the function putstring to output the string at the address in X0

    // Read the input for x
    LDR X0,=szX  // Load the address of szX into X0
    MOV X1, #8  // Move 8 into X1
    BL getstring  // Call the function getstring to read a string of length X1 into the address in X0

    // Output "Enter y: "
    LDR X0,=szEnter  // Load the address of szEnter into X0
    BL putstring  // Call the function putstring to output the string at the address in X0
    LDR X0,=cY  // Load the address of cY into X0
    BL putch  // Call the function putch to output the character at the address in X0
    LDR X0,=szCol  // Load the address of szCol into X0
    BL putstring  // Call the function putstring to output the string at the address in X0

    // Read the input for y
    LDR X0,=szY  // Load the address of szY into X0
    MOV X1, #8  // Move 8 into X1
    BL getstring  // Call the function getstring to read a string of length X1 into the address in X0

    // Convert the ASCII input for x to binary and store it in iX
    LDR X0,=szX  // Load the address of szX into X0
    BL ascint64  // Call the function ascint64 to convert the ASCII string at the address in X0 to binary
    LDR X1,=iX  // Load the address of iX into X1
    STR X0,[X1]  // Store the binary value in X0 into the address in X1

    // Convert the ASCII input for y to binary and store it in iY
    LDR X0,=szY  // Load the address of szY into X0
    BL ascint64  // Call the function ascint64 to convert the ASCII string at the address in X0 to binary
    LDR X1,=iY  // Load the address of iY into X1
    STR X0,[X1]  // Store the binary value in X0 into the address in X1

    // Load the binary values of x and y into X0 and X1 respectively
    LDR X0,=iX  // Load the address of iX into X0
    LDR X0,[X0]  // Load the value at the address in X0 into X0
    LDR X1,=iY  // Load the address of iY into X1
    LDR X1,[X1]  // Load the value at the address in X1 into X1

    // Compare x and y and output the result
    CMP X0, X1  // Compare the values in X0 and X1
    B.LE elseif  // If X0 is less than or equal to X1, branch to elseif

    // If x > y
    LDR X11,=szGT  // Load the address of szGT into X11
    B same  // Branch to same

    elseif:  // Else if y > x
    B.GE else  // If X0 is greater than or equal to X1, branch to else
    LDR X9,=cY  // Load the address of cY into X9
    LDR X10,=cX  // Load the address of cX into X10
    LDR X11,=szGT  // Load the address of szGT into X11
    LDR X12,=szY  // Load the address of szY into X12
    LDR X13,=szX  // Load the address of szX into X13
    B endif  // Branch to endif

    else:  // Else x == y
    LDR X11,=szEq  // Load the address of szEq into X11

    same:  // Shared actions for x > y and x == y
    LDR X9,=cX  // Load the address of cX into X9
    LDR X10,=cY  // Load the address of cY into X10
    LDR X12,=szX  // Load the address of szX into X12
    LDR X13,=szY  // Load the address of szY into X13

    endif: // End of if statement

    // Output the result of the comparison
    MOV X0,X9  // Move the value in X9 into X0
    BL putch  // Call the function putch to output the character at the address in X0
    MOV X0,X11  // Move the value in X11 into X0
    BL putstring  // Call the function putstring to output the string at the address in X0
    MOV X0,X10  // Move the value in X10 into X0
    BL putch  // Call the function putch to output the character at the address in X0
    LDR X0,=szCol  // Load the address of szCol into X0
    BL putstring  // Call the function putstring to output the string at the address in X0
    MOV X0,X12  // Move the value in X12 into X0
    BL putstring  // Call the function putstring to output the string at the address in X0
    MOV X0,X11  // Move the value in X11 into X0
    BL putstring  // Call the function putstring to output the string at the address in X0
    MOV X0,X13  // Move the value in X13 into X0
    BL putstring  // Call the function putstring to output the string at the address in X0

    // Output a newline
    LDR X0,=cLF  // Load the address of cLF into X0
    BL putch  // Call the function putch to output the character at the address in X0

    // Output another newline
    LDR X0,=cLF  // Load the address of cLF into X0
    BL putch  // Call the function putch to output the character at the address in X0

    // Increment the counter
    ADD X20, X20, #1  // Add 1 to X20
    CMP X20, #3  // Compare X20 to 3
    B.LE loop_start  // If X20 is less than or equal to 3, branch to loop_start

end_program:  // End of the program
    MOV X0, 0  // Move 0 into X0
    MOV X8, #93  // Move 93 into X8
    SVC 0  // Call the system call specified by the value in X8 with

