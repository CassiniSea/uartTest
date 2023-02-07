   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  48                     ; 5 void init() {
  50                     .text:	section	.text,new
  51  0000               _init:
  55                     ; 6 	clkInit();	
  57  0000 cd0000        	call	_clkInit
  59                     ; 7 	uartInit();
  61  0003 cd0000        	call	_uartInit
  63                     ; 8 	enableInterrupts();
  66  0006 9a            rim
  68                     ; 9 }
  72  0007 81            	ret
  85                     	xdef	_init
  86                     	xref	_uartInit
  87                     	xref	_clkInit
 106                     	end
