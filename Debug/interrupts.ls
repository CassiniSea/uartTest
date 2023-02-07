   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  49                     ; 4 INTERRUPT void uartReceive8Interrupt(void)	{
  50                     .text:	section	.text,new
  51  0000               f_uartReceive8Interrupt:
  53  0000 8a            	push	cc
  54  0001 84            	pop	a
  55  0002 a4bf          	and	a,#191
  56  0004 88            	push	a
  57  0005 86            	pop	cc
  58  0006 3b0002        	push	c_x+2
  59  0009 be00          	ldw	x,c_x
  60  000b 89            	pushw	x
  61  000c 3b0002        	push	c_y+2
  62  000f be00          	ldw	x,c_y
  63  0011 89            	pushw	x
  66                     ; 5 	UART1_ClearITPendingBit(UART1_IT_RXNE);
  68  0012 ae0255        	ldw	x,#597
  69  0015 cd0000        	call	_UART1_ClearITPendingBit
  71                     ; 6 	uartReceive8(UART1_ReceiveData8());
  73  0018 cd0000        	call	_UART1_ReceiveData8
  75  001b cd0000        	call	_uartReceive8
  77                     ; 7 }
  80  001e 85            	popw	x
  81  001f bf00          	ldw	c_y,x
  82  0021 320002        	pop	c_y+2
  83  0024 85            	popw	x
  84  0025 bf00          	ldw	c_x,x
  85  0027 320002        	pop	c_x+2
  86  002a 80            	iret
 111                     ; 9 INTERRUPT void uartTxCompleteInterrupt(void) {
 112                     .text:	section	.text,new
 113  0000               f_uartTxCompleteInterrupt:
 115  0000 8a            	push	cc
 116  0001 84            	pop	a
 117  0002 a4bf          	and	a,#191
 118  0004 88            	push	a
 119  0005 86            	pop	cc
 120  0006 3b0002        	push	c_x+2
 121  0009 be00          	ldw	x,c_x
 122  000b 89            	pushw	x
 123  000c 3b0002        	push	c_y+2
 124  000f be00          	ldw	x,c_y
 125  0011 89            	pushw	x
 128                     ; 10 	UART1_ClearITPendingBit(UART1_IT_TC);
 130  0012 ae0266        	ldw	x,#614
 131  0015 cd0000        	call	_UART1_ClearITPendingBit
 133                     ; 11 	uartTxComplete();	
 135  0018 cd0000        	call	_uartTxComplete
 137                     ; 12 }
 140  001b 85            	popw	x
 141  001c bf00          	ldw	c_y,x
 142  001e 320002        	pop	c_y+2
 143  0021 85            	popw	x
 144  0022 bf00          	ldw	c_x,x
 145  0024 320002        	pop	c_x+2
 146  0027 80            	iret
 158                     	xdef	f_uartTxCompleteInterrupt
 159                     	xdef	f_uartReceive8Interrupt
 160                     	xref	_uartReceive8
 161                     	xref	_uartTxComplete
 162                     	xref	_UART1_ClearITPendingBit
 163                     	xref	_UART1_ReceiveData8
 164                     	xref.b	c_x
 165                     	xref.b	c_y
 184                     	end
