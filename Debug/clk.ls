   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  46                     ; 3 void clkInit(void) {
  48                     .text:	section	.text,new
  49  0000               _clkInit:
  53                     ; 4 	CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1|CLK_PRESCALER_CPUDIV1);
  55  0000 a680          	ld	a,#128
  56  0002 cd0000        	call	_CLK_HSIPrescalerConfig
  58                     ; 5 }
  61  0005 81            	ret
  74                     	xdef	_clkInit
  75                     	xref	_CLK_HSIPrescalerConfig
  94                     	end
