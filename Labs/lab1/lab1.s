   .global _start

_start: 
   mov	 X0,  #1
   ldr	 X1, =helloworld    //string to print

   mov	 X2,  #13  // length of string
   mov	 X8,  #64 //linux write system
   svc   0 	// call linux to output the string

   mov   X0,  #0 
  
   mov   X8,  #93  
   svc   0

.data  
helloworld:     .ascii   "Romina Pouya\n"
