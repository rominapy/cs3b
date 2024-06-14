  //-----------------------------------------
  // Romina Pouya
  // Lab 15
  //-----------------------------------------

	//file modes
	.equ 	R,  00 		//read only
	.equ 	W,  01       //write only
	.equ 	RW, 02		//read write
	.equ    TR, 01002  // truncate read and write
	.equ    CW, 02002   // create file if there is not created 


	// file permissions
	 // Owner Group Other
	 // RWE   RWE   RWE
    .equ RW_RW____ ,0644 
    .equ RW_______,0600
    .equ AT_FDCWD,-100


	.data
	iArr:		.quad 0,0,0,0,0  //initialize int array with size 5
	fileBuf:	.skip 512     //buffer for file input
	szFile:     .asciz "input.txt" //file 
	szNL:		.asciz "\n"  //new line char

	.global _start
	.text

_start:
		//open file
		MOV 	X0 , #AT_FDCWD
		MOV 	X8, #56
		LDR 	X1, =szFile
		MOV 	X2, #R
		MOV 	X3, #RW_______
		SVC		0


		//X0 now contains file descriptot(fd)
		MOV    X19,X0

		MOV    X25, #0
		LDR    X27, =iArr   //loading t he array

loop:
	//collect current line from file

	MOV    X0,X19   //load fd
	LDR    X1, =fileBuf
	BL     getline   // get the input from file


	 // output current line
    LDR X0,=fileBuf     // load buffer holding file contents
    BL  putstring       // output file contents
    LDR X0,=szNL        // load newline string
    BL  putstring       // output newline

    // now that we have output the character, time to convert and save
    LDR X0,=fileBuf     // load buffer with input
    BL  ascint64        // convert ascii to integer
    STRB W0,[X27],#1    // store integer
    BL  buf_clear       // clear buffer for next input
    
    // loop while index < 5
    ADD  X25,X25,#1      // i = i + 1
    CMP  X25,#5          // if index < 5
    B.LT loop            // continue to loop

loop_end:

    // Close file
    MOV X0,X19          // load saved fd
    MOV X8,#57          // close file
    SVC 0               // service call

end:
    MOV X0,#0           // load 0, program exited correctly
    MOV X8,#93          // load code to terminate program
    SVC 0               // call to linux to terminate


buf_clear:
    LDR X0,=fileBuf     // load buffer to clear
    MOV X2,#0           // load null character to fill buffer with
clear_loop:
    LDRB W1,[X0]        // load current byte from buffer
    STRB W2,[X0],#1     // store null character to current byte and move to next
    CMP  W1,#0          // if we find the null terminator
    B.EQ return         // buffer has been flushed

return:
    RET                 // return to calling function

 