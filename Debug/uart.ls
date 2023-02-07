   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  49                     ; 3 void uartInit(void) {
  51                     .text:	section	.text,new
  52  0000               _uartInit:
  56                     ; 4 	UART1_DeInit();
  58  0000 cd0000        	call	_UART1_DeInit
  60                     ; 5 	UART1_Init(	57600,
  60                     ; 6 							UART1_WORDLENGTH_8D,
  60                     ; 7 							UART1_STOPBITS_1,
  60                     ; 8 							UART1_PARITY_NO,
  60                     ; 9 							UART1_SYNCMODE_CLOCK_DISABLE,
  60                     ; 10 							UART1_MODE_TXRX_ENABLE);
  62  0003 4b0c          	push	#12
  63  0005 4b80          	push	#128
  64  0007 4b00          	push	#0
  65  0009 4b00          	push	#0
  66  000b 4b00          	push	#0
  67  000d aee100        	ldw	x,#57600
  68  0010 89            	pushw	x
  69  0011 ae0000        	ldw	x,#0
  70  0014 89            	pushw	x
  71  0015 cd0000        	call	_UART1_Init
  73  0018 5b09          	addw	sp,#9
  74                     ; 11 	UART1_ITConfig(	UART1_IT_RXNE, ENABLE);
  76  001a 4b01          	push	#1
  77  001c ae0255        	ldw	x,#597
  78  001f cd0000        	call	_UART1_ITConfig
  80  0022 84            	pop	a
  81                     ; 12 	UART1_Cmd(ENABLE);
  83  0023 a601          	ld	a,#1
  84  0025 cd0000        	call	_UART1_Cmd
  86                     ; 13 }
  89  0028 81            	ret
 125                     ; 15 void uartTransmit(uint8_t data) {
 126                     .text:	section	.text,new
 127  0000               _uartTransmit:
 129  0000 88            	push	a
 130       00000000      OFST:	set	0
 133  0001               L14:
 134                     ; 16 	while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
 136  0001 ae0080        	ldw	x,#128
 137  0004 cd0000        	call	_UART1_GetFlagStatus
 139  0007 4d            	tnz	a
 140  0008 27f7          	jreq	L14
 141                     ; 17 	UART1_SendData8(data);
 143  000a 7b01          	ld	a,(OFST+1,sp)
 144  000c cd0000        	call	_UART1_SendData8
 146                     ; 18 }
 149  000f 84            	pop	a
 150  0010 81            	ret
 185                     ; 20 void uartReceive8(uint8_t data) {
 186                     .text:	section	.text,new
 187  0000               _uartReceive8:
 191                     ; 21 	uartTransmit(data);
 193  0000 cd0000        	call	_uartTransmit
 195                     ; 22 }
 198  0003 81            	ret
 211                     	xdef	_uartReceive8
 212                     	xdef	_uartTransmit
 213                     	xdef	_uartInit
 214                     	xref	_UART1_GetFlagStatus
 215                     	xref	_UART1_SendData8
 216                     	xref	_UART1_ITConfig
 217                     	xref	_UART1_Cmd
 218                     	xref	_UART1_Init
 219                     	xref	_UART1_DeInit
 238                     	end
