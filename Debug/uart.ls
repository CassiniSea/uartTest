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
 186                     ; 20 void uartSendString(char* str) {
 187                     .text:	section	.text,new
 188  0000               _uartSendString:
 190  0000 89            	pushw	x
 191       00000000      OFST:	set	0
 194  0001 200e          	jra	L56
 195  0003               L36:
 196                     ; 22 		uartTransmit(*str++);
 198  0003 1e01          	ldw	x,(OFST+1,sp)
 199  0005 1c0001        	addw	x,#1
 200  0008 1f01          	ldw	(OFST+1,sp),x
 201  000a 1d0001        	subw	x,#1
 202  000d f6            	ld	a,(x)
 203  000e cd0000        	call	_uartTransmit
 205  0011               L56:
 206                     ; 21 	while (*str) {
 208  0011 1e01          	ldw	x,(OFST+1,sp)
 209  0013 7d            	tnz	(x)
 210  0014 26ed          	jrne	L36
 211                     ; 24 }
 214  0016 85            	popw	x
 215  0017 81            	ret
 250                     ; 26 void uartReceive8(uint8_t data) {
 251                     .text:	section	.text,new
 252  0000               _uartReceive8:
 256                     ; 27 	uartSendString("Hello World\n");
 258  0000 ae0000        	ldw	x,#L701
 259  0003 cd0000        	call	_uartSendString
 261                     ; 28 }
 264  0006 81            	ret
 277                     	xdef	_uartReceive8
 278                     	xdef	_uartSendString
 279                     	xdef	_uartTransmit
 280                     	xdef	_uartInit
 281                     	xref	_UART1_GetFlagStatus
 282                     	xref	_UART1_SendData8
 283                     	xref	_UART1_ITConfig
 284                     	xref	_UART1_Cmd
 285                     	xref	_UART1_Init
 286                     	xref	_UART1_DeInit
 287                     .const:	section	.text
 288  0000               L701:
 289  0000 48656c6c6f20  	dc.b	"Hello World",10,0
 309                     	end
