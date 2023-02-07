   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  46                     ; 9 main()
  46                     ; 10 {
  48                     .text:	section	.text,new
  49  0000               _main:
  53                     ; 11 	init();
  55  0000 cd0000        	call	_init
  57  0003               L12:
  58                     ; 13 	while (1);
  60  0003 20fe          	jra	L12
  73                     	xdef	_main
  74                     	xref	_init
  93                     	end
