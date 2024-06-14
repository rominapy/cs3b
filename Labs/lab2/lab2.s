   .global _start

   .data 

szMsg1:  .asciz   "The sun did not shine."
szMsg2:  .asciz   "It was tooo wet to play."
chLF:    .byte    0xa
chCR:    .byte    0xd

   .text
_start:

   ldr   x0 , =szMsg1
   bl    putstring



   .end
