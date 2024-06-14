 //Romina Pouya
 //Lab6
    .global _start     // Global declaration of _start label
        .equ BUFFER, 21   // Define BUFFER constant as 21
        .equ MAX_LEN, 20  // Define MAX_LEN constant as 20
                     

    .data  
bA:            .byte    155
bFlag:         .byte    1
chInit:        .byte    'j'
u16Hi:         .hword   88
u16Lo:         .hword   45
wAlt:          .word    16, -1, -2
szMsg1:        .asciz   "And Sally and I"
dbBig:         .quad    9223372036854775807
szBuffer:      .skip    BUFFER

chLF:		   .byte 0xa


sz1:            .asciz "bA = "
sz2:            .asciz "bFlag=  "
sz3:            .asciz "chInit=  "
sz4:            .asciz "u16Hi=  "
sz5:            .asciz "u16Lo=  "
sz6:            .asciz "wAlt[0]:  "
sz7:            .asciz "wAlt[1]:  "
sz8:            .asciz "wAlt[2]:  "
sz9:            .asciz "szMsg1=  "
sz10:           .asciz "dbBig=  "
    .text

_start:

   /*---------------------------Outputing bA-------------------------------------- */
    ldr     x0, =sz1   //loading the address of sz1 to x0
    bl      putstring  //display sz1


    ldr     x0, =bA  //loading the address of label bA
    ldrb    w0, [x0] // load a single byte from whatever x0 is pointing to to w register

    ldr     x1, =szBuffer
    bl      int64asc        //convert bA which is a .byte 155


    ldr     x0, =szBuffer  // print szBufefr  which has ascii bA
    bl      putstring      // calling the putstring function

    ldr     x0, =chLF    // new line
    bl      putch


   //--------- Outputing bFlag--------------------------------------
     ldr      x0,=sz2      //loading teh address of sz2 to x0
    bl       putstring    //display the sz2

    ldr       x0, =bFlag    //loading the address of label bFlag 
    ldrb      w0,[x0]     // load a single byte from whatever x0 is pointing to
  
    ldr     x1, =szBuffer  // put the buffer into x1
    bl      int64asc     // convert

    ldr     x0, =szBuffer  // print szBufefr  which has ascii bA
    bl      putstring    

    ldr     x0, =chLF      // newline
    bl      putch

    //---------------------outputing chInit------------------
    ldr      x0,=sz3      //loading the address of sz3 to x0
    bl       putstring    // display sz3

    ldr       x0, =chInit   /// loading teh address of chInit to x0
    bl        putch         // display it

    ldr      x0, =chLF      // new line
    bl       putch


   
  // -----------------------Outputing 16Hi---------------------- 
    ldr     x0, =sz4   //loading the address of sz1 to x0
    bl      putstring  //display sz1


    ldr     x0, = u16Hi //loading the address of label bA
    ldrh    w0, [x0] // load a single byte from x0->

    ldr     x1, =szBuffer
    bl      int64asc


    ldr     x0, =szBuffer  // print szBufefr  which has ascii bA
    bl      putstring

    ldr     x0, =chLF
    bl      putch
    

  //--------------------------outputing u16Low--------------- 

    ldr     x0, =sz5    //laoding the address to x0
    bl      putstring   // output

    ldr     x0, =u16Lo   // loading the address to xo
    ldrh    w0, [x0]    //loading a byte to the register

    ldr     x1, =szBuffer  //load the buffer
    bl      int64asc      //convert it

    ldr     x0, =szBuffer    //load the register with buffer
    bl      putstring        //output it

    ldr     x0, =chLF       //newline
    bl      putch



   //---------------------outputing wAlt[0]-------------------------
    ldr     x0, =sz6     //load the address to x0
    bl      putstring    // output it

    ldr     x0,=wAlt     //wAlt[0]
    ldr     w0, [x0]     //load just  the first 4bytes

    
    ldr     x1,=szBuffer   //having the buffer at wAlt[0]
    bl      int64asc       //convert it

    ldr     x0,=szBuffer    //output it
    bl      putstring

    ldr     x0, =chLF     //new line
    bl      putch



/*--------------------printing the wAlt[1]--------------- */
    ldr     x0,=sz7
    bl      putstring

    ldr     x0, =wAlt   // load the base address
    add     x0,x0, #4   // fgo to the next 4 byte
    ldr     w0, [x0]    //load it

    mov     x2, #0          
    add     x0,x2,x0, SXTW


    ldr      x1, =szBuffer
    bl       int64asc  

    ldr      x0, =szBuffer
    bl       putstring 

    ldr     x0, =chLF
    bl      putch


/*--------------------printing the wAlt[2]--------------- */
    ldr     x0,=sz8
    bl      putstring

    ldr     x0, =wAlt  // Load the address of wAlt 
    add     x0,x0, #8  //into x0 and offset it by 8 to access wAlt[2]
    ldr     w0, [x0]  // Load the value of wAlt[2] into w0

    mov     x2, #0
    add     x0,x2,x0, SXTW


    ldr      x1, =szBuffer   // Convert the value to ASCII and store it in szBuffer
    bl       int64asc  

    ldr      x0, =szBuffer
    bl       putstring 

    ldr     x0, =chLF
    bl      putch


 /*------------------Outputing message 1------------------*/
    ldr     x0,=sz9   // Output string indicating message 1
    bl      putstring

    ldr     x0,=szMsg1  // Output contents of szMsg1
    bl      putstring     
 
    ldr     x0, =chLF
    bl      putch

//---------------outputing the dbBig-----------------
    ldr     x0, =sz10   // Output string indicating dbBig
    bl      putstring   //

    ldr     x0,=dbBig   // Load the value of dbBig into x0
    ldr     x0,[x0]

    ldr     x1,=szBuffer  // Convert the value to ASCII and store it in szBuffer
    bl      int64asc

    ldr     x0, =szBuffer  // Print the contents of szBuffer
    bl      putstring

    ldr     x0, chLF
    bl      putch 





/*--------------END-------------- */
   mov X0, #0
   mov X8, #93
   svc 0
.end
