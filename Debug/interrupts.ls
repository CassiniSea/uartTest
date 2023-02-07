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
  98                     	xdef	f_uartReceive8Interrupt
  99                     	xref	_uartReceive8
 100                     	xref	_UART1_ClearITPendingBit
 101                     	xref	_UART1_ReceiveData8
 102                     	xref.b	c_x
 103                     	xref.b	c_y
 122                     	end
