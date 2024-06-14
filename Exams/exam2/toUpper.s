  //  Romina Pouya
  //  Exam2
  //---------------------------------------------------------
  // String_toUppeer function
  //----------------------------------------------------------
   .global String_toUpperCase
    .text
String_toUpperCase:
    STP LR,X0,[SP,#-16]!    // push input string to stack
    BL  String_length           // get length of string in X0
    ADD X0,X0,#1            // add 1 to string to make room for null terminator
    BL  malloc              // allocate string with same length
    LDP LR,X1,[SP],#16      // pop input string from stack
    STP LR,X0,[SP,#-16]!    // push output string init address to stack

loop_toUpperCase:
    LDRB W5,[X1],#1         // load character and increase ptr
    CMP W5,#'z'             // if letter > 'z'
    B.GT cont_toUpperCase   // skip iteration
    CMP W5,#'a'             // if letter < 'a'
    B.LT cont_toUpperCase   // skip iteration
    // if we are here, letter is lowercase
    SUB W5,W5,#('a'-'A')    // convert lower to upper
cont_toUpperCase:
    STRB W5,[X0],#1         // store character to output str
    CMP W5,#0               // if we did not hit a null character
    B.NE loop_toUpperCase   // continue loop
    
    LDP LR,X0,[SP],#16      // load output string address and link register
    RET                     // return to calling function
    
