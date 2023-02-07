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
 186                     ; 22 void uartSendString(char* str) {
 187                     .text:	section	.text,new
 188  0000               _uartSendString:
 190  0000 89            	pushw	x
 191       00000000      OFST:	set	0
 194  0001 200e          	jra	L56
 195  0003               L36:
 196                     ; 24 		uartTransmit(*str++);
 198  0003 1e01          	ldw	x,(OFST+1,sp)
 199  0005 1c0001        	addw	x,#1
 200  0008 1f01          	ldw	(OFST+1,sp),x
 201  000a 1d0001        	subw	x,#1
 202  000d f6            	ld	a,(x)
 203  000e cd0000        	call	_uartTransmit
 205  0011               L56:
 206                     ; 23 	while(*str) {
 208  0011 1e01          	ldw	x,(OFST+1,sp)
 209  0013 7d            	tnz	(x)
 210  0014 26ed          	jrne	L36
 211                     ; 26 }
 214  0016 85            	popw	x
 215  0017 81            	ret
 253                     ; 28 void uartSendStringAsync(char* str) {
 254                     .text:	section	.text,new
 255  0000               _uartSendStringAsync:
 259                     ; 29 	strPtr = str;
 261  0000 bf00          	ldw	_strPtr,x
 262                     ; 30 	UART1_ITConfig(UART1_IT_TXE, ENABLE);
 264  0002 4b01          	push	#1
 265  0004 ae0277        	ldw	x,#631
 266  0007 cd0000        	call	_UART1_ITConfig
 268  000a 84            	pop	a
 269                     ; 31 }
 272  000b 81            	ret
 298                     ; 33 void uartTxComplete(void) {
 299                     .text:	section	.text,new
 300  0000               _uartTxComplete:
 304                     ; 34 	if (*strPtr) {
 306  0000 923d00        	tnz	[_strPtr.w]
 307  0003 2710          	jreq	L711
 308                     ; 35 		UART1_SendData8(*strPtr++);
 310  0005 be00          	ldw	x,_strPtr
 311  0007 1c0001        	addw	x,#1
 312  000a bf00          	ldw	_strPtr,x
 313  000c 1d0001        	subw	x,#1
 314  000f f6            	ld	a,(x)
 315  0010 cd0000        	call	_UART1_SendData8
 318  0013 2009          	jra	L121
 319  0015               L711:
 320                     ; 38 		UART1_ITConfig(UART1_IT_TXE, DISABLE);
 322  0015 4b00          	push	#0
 323  0017 ae0277        	ldw	x,#631
 324  001a cd0000        	call	_UART1_ITConfig
 326  001d 84            	pop	a
 327  001e               L121:
 328                     ; 40 }
 331  001e 81            	ret
 366                     ; 42 void uartReceive8(uint8_t data) {
 367                     .text:	section	.text,new
 368  0000               _uartReceive8:
 372                     ; 43 	uartSendString("Hello World\n");
 374  0000 ae0000        	ldw	x,#L141
 375  0003 cd0000        	call	_uartSendString
 377                     ; 44 }
 380  0006 81            	ret
 405                     	xdef	_uartReceive8
 406                     	xdef	_uartTxComplete
 407                     	xdef	_uartSendStringAsync
 408                     	xdef	_uartSendString
 409                     	xdef	_uartTransmit
 410                     	xdef	_uartInit
 411                     	switch	.ubsct
 412  0000               _strPtr:
 413  0000 0000          	ds.b	2
 414                     	xdef	_strPtr
 415                     	xref	_UART1_GetFlagStatus
 416                     	xref	_UART1_SendData8
 417                     	xref	_UART1_ITConfig
 418                     	xref	_UART1_Cmd
 419                     	xref	_UART1_Init
 420                     	xref	_UART1_DeInit
 421                     .const:	section	.text
 422  0000               L141:
 423  0000 48656c6c6f20  	dc.b	"Hello World",10,0
 443                     	end
