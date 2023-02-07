   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  49                     ; 5 void uartInit(void) {
  51                     .text:	section	.text,new
  52  0000               _uartInit:
  56                     ; 6 	UART1_DeInit();
  58  0000 cd0000        	call	_UART1_DeInit
  60                     ; 7 	UART1_Init(	57600,
  60                     ; 8 							UART1_WORDLENGTH_8D,
  60                     ; 9 							UART1_STOPBITS_1,
  60                     ; 10 							UART1_PARITY_NO,
  60                     ; 11 							UART1_SYNCMODE_CLOCK_DISABLE,
  60                     ; 12 							UART1_MODE_TXRX_ENABLE);
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
  74                     ; 13 	UART1_ITConfig(	UART1_IT_RXNE, ENABLE);
  76  001a 4b01          	push	#1
  77  001c ae0255        	ldw	x,#597
  78  001f cd0000        	call	_UART1_ITConfig
  80  0022 84            	pop	a
  81                     ; 14 	UART1_Cmd(ENABLE);
  83  0023 a601          	ld	a,#1
  84  0025 cd0000        	call	_UART1_Cmd
  86                     ; 15 }
  89  0028 81            	ret
 125                     ; 17 void uartTransmit(uint8_t data) {
 126                     .text:	section	.text,new
 127  0000               _uartTransmit:
 129  0000 88            	push	a
 130       00000000      OFST:	set	0
 133  0001               L14:
 134                     ; 18 	while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
 136  0001 ae0080        	ldw	x,#128
 137  0004 cd0000        	call	_UART1_GetFlagStatus
 139  0007 4d            	tnz	a
 140  0008 27f7          	jreq	L14
 141                     ; 19 	UART1_SendData8(data);
 143  000a 7b01          	ld	a,(OFST+1,sp)
 144  000c cd0000        	call	_UART1_SendData8
 146                     ; 20 }
 149  000f 84            	pop	a
 150  0010 81            	ret
 187                     ; 22 void uartSendString(char* str) {
 188                     .text:	section	.text,new
 189  0000               _uartSendString:
 193                     ; 23 	strPtr = str;
 195  0000 bf00          	ldw	_strPtr,x
 196                     ; 24 	UART1_ITConfig(UART1_IT_TXE, ENABLE);
 198  0002 4b01          	push	#1
 199  0004 ae0277        	ldw	x,#631
 200  0007 cd0000        	call	_UART1_ITConfig
 202  000a 84            	pop	a
 203                     ; 25 }
 206  000b 81            	ret
 232                     ; 27 void uartTxComplete(void) {
 233                     .text:	section	.text,new
 234  0000               _uartTxComplete:
 238                     ; 28 	if (*strPtr) {
 240  0000 923d00        	tnz	[_strPtr.w]
 241  0003 2710          	jreq	L37
 242                     ; 29 		UART1_SendData8(*strPtr++);
 244  0005 be00          	ldw	x,_strPtr
 245  0007 1c0001        	addw	x,#1
 246  000a bf00          	ldw	_strPtr,x
 247  000c 1d0001        	subw	x,#1
 248  000f f6            	ld	a,(x)
 249  0010 cd0000        	call	_UART1_SendData8
 252  0013 2009          	jra	L57
 253  0015               L37:
 254                     ; 32 		UART1_ITConfig(UART1_IT_TXE, DISABLE);
 256  0015 4b00          	push	#0
 257  0017 ae0277        	ldw	x,#631
 258  001a cd0000        	call	_UART1_ITConfig
 260  001d 84            	pop	a
 261  001e               L57:
 262                     ; 34 }
 265  001e 81            	ret
 300                     ; 36 void uartReceive8(uint8_t data) {
 301                     .text:	section	.text,new
 302  0000               _uartReceive8:
 306                     ; 37 	uartSendString("Hello World\n");
 308  0000 ae0000        	ldw	x,#L511
 309  0003 cd0000        	call	_uartSendString
 311                     ; 38 }
 314  0006 81            	ret
 339                     	xdef	_uartReceive8
 340                     	xdef	_uartTxComplete
 341                     	xdef	_uartSendString
 342                     	xdef	_uartTransmit
 343                     	xdef	_uartInit
 344                     	switch	.ubsct
 345  0000               _strPtr:
 346  0000 0000          	ds.b	2
 347                     	xdef	_strPtr
 348                     	xref	_UART1_GetFlagStatus
 349                     	xref	_UART1_SendData8
 350                     	xref	_UART1_ITConfig
 351                     	xref	_UART1_Cmd
 352                     	xref	_UART1_Init
 353                     	xref	_UART1_DeInit
 354                     .const:	section	.text
 355  0000               L511:
 356  0000 48656c6c6f20  	dc.b	"Hello World",10,0
 376                     	end
