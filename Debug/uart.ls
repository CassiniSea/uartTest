   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  17                     	bsct
  18  0000               ___uartBufferIndex:
  19  0000 00            	dc.b	0
  52                     ; 9 void uartInit(void) {
  54                     .text:	section	.text,new
  55  0000               _uartInit:
  59                     ; 10 	UART1_DeInit();
  61  0000 cd0000        	call	_UART1_DeInit
  63                     ; 11 	UART1_Init(	57600,
  63                     ; 12 							UART1_WORDLENGTH_8D,
  63                     ; 13 							UART1_STOPBITS_1,
  63                     ; 14 							UART1_PARITY_NO,
  63                     ; 15 							UART1_SYNCMODE_CLOCK_DISABLE,
  63                     ; 16 							UART1_MODE_TXRX_ENABLE);
  65  0003 4b0c          	push	#12
  66  0005 4b80          	push	#128
  67  0007 4b00          	push	#0
  68  0009 4b00          	push	#0
  69  000b 4b00          	push	#0
  70  000d aee100        	ldw	x,#57600
  71  0010 89            	pushw	x
  72  0011 ae0000        	ldw	x,#0
  73  0014 89            	pushw	x
  74  0015 cd0000        	call	_UART1_Init
  76  0018 5b09          	addw	sp,#9
  77                     ; 17 	UART1_ITConfig(	UART1_IT_RXNE, ENABLE);
  79  001a 4b01          	push	#1
  80  001c ae0255        	ldw	x,#597
  81  001f cd0000        	call	_UART1_ITConfig
  83  0022 84            	pop	a
  84                     ; 18 	UART1_Cmd(ENABLE);
  86  0023 a601          	ld	a,#1
  87  0025 cd0000        	call	_UART1_Cmd
  89                     ; 19 }
  92  0028 81            	ret
 128                     ; 21 void uartTransmit(uint8_t data) {
 129                     .text:	section	.text,new
 130  0000               _uartTransmit:
 132  0000 88            	push	a
 133       00000000      OFST:	set	0
 136  0001               L14:
 137                     ; 22 	while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
 139  0001 ae0080        	ldw	x,#128
 140  0004 cd0000        	call	_UART1_GetFlagStatus
 142  0007 4d            	tnz	a
 143  0008 27f7          	jreq	L14
 144                     ; 23 	UART1_SendData8(data);
 146  000a 7b01          	ld	a,(OFST+1,sp)
 147  000c cd0000        	call	_UART1_SendData8
 149                     ; 24 }
 152  000f 84            	pop	a
 153  0010 81            	ret
 189                     ; 26 void uartSendString(char* str) {
 190                     .text:	section	.text,new
 191  0000               _uartSendString:
 193  0000 89            	pushw	x
 194       00000000      OFST:	set	0
 197  0001 200e          	jra	L56
 198  0003               L36:
 199                     ; 28 		uartTransmit(*str++);
 201  0003 1e01          	ldw	x,(OFST+1,sp)
 202  0005 1c0001        	addw	x,#1
 203  0008 1f01          	ldw	(OFST+1,sp),x
 204  000a 1d0001        	subw	x,#1
 205  000d f6            	ld	a,(x)
 206  000e cd0000        	call	_uartTransmit
 208  0011               L56:
 209                     ; 27 	while(*str) {
 211  0011 1e01          	ldw	x,(OFST+1,sp)
 212  0013 7d            	tnz	(x)
 213  0014 26ed          	jrne	L36
 214                     ; 30 }
 217  0016 85            	popw	x
 218  0017 81            	ret
 256                     ; 32 void uartSendStringAsync(char* str) {
 257                     .text:	section	.text,new
 258  0000               _uartSendStringAsync:
 262                     ; 33 	__strPtr = str;
 264  0000 bf20          	ldw	___strPtr,x
 265                     ; 34 	UART1_ITConfig(UART1_IT_TXE, ENABLE);
 267  0002 4b01          	push	#1
 268  0004 ae0277        	ldw	x,#631
 269  0007 cd0000        	call	_UART1_ITConfig
 271  000a 84            	pop	a
 272                     ; 35 }
 275  000b 81            	ret
 301                     ; 37 void uartTxComplete(void) {
 302                     .text:	section	.text,new
 303  0000               _uartTxComplete:
 307                     ; 38 	if (*__strPtr) {
 309  0000 923d20        	tnz	[___strPtr.w]
 310  0003 2710          	jreq	L711
 311                     ; 39 		UART1_SendData8(*__strPtr++);
 313  0005 be20          	ldw	x,___strPtr
 314  0007 1c0001        	addw	x,#1
 315  000a bf20          	ldw	___strPtr,x
 316  000c 1d0001        	subw	x,#1
 317  000f f6            	ld	a,(x)
 318  0010 cd0000        	call	_UART1_SendData8
 321  0013 2009          	jra	L121
 322  0015               L711:
 323                     ; 42 		UART1_ITConfig(UART1_IT_TXE, DISABLE);
 325  0015 4b00          	push	#0
 326  0017 ae0277        	ldw	x,#631
 327  001a cd0000        	call	_UART1_ITConfig
 329  001d 84            	pop	a
 330  001e               L121:
 331                     ; 44 }
 334  001e 81            	ret
 370                     ; 46 void uartStringReceived(char* str) {
 371                     .text:	section	.text,new
 372  0000               _uartStringReceived:
 376                     ; 47 	uartSendString(str);
 378  0000 cd0000        	call	_uartSendString
 380                     ; 48 }
 383  0003 81            	ret
 420                     ; 50 void uartReceive8(uint8_t c) {
 421                     .text:	section	.text,new
 422  0000               _uartReceive8:
 424  0000 88            	push	a
 425       00000000      OFST:	set	0
 428                     ; 51 	if(c == '\r' || __uartBufferIndex >= __UART_MAX_STRING_LENGTH) {
 430  0001 a10d          	cp	a,#13
 431  0003 2706          	jreq	L161
 433  0005 b600          	ld	a,___uartBufferIndex
 434  0007 a120          	cp	a,#32
 435  0009 250a          	jrult	L751
 436  000b               L161:
 437                     ; 52 		uartStringReceived(__uartBuffer);
 439  000b ae0000        	ldw	x,#___uartBuffer
 440  000e cd0000        	call	_uartStringReceived
 442                     ; 53 		__uartBufferIndex = 0;
 444  0011 3f00          	clr	___uartBufferIndex
 446  0013               L361:
 447                     ; 58 }
 450  0013 84            	pop	a
 451  0014 81            	ret
 452  0015               L751:
 453                     ; 56 		__uartBuffer[__uartBufferIndex++] = c;
 455  0015 b600          	ld	a,___uartBufferIndex
 456  0017 97            	ld	xl,a
 457  0018 3c00          	inc	___uartBufferIndex
 458  001a 9f            	ld	a,xl
 459  001b 5f            	clrw	x
 460  001c 97            	ld	xl,a
 461  001d 7b01          	ld	a,(OFST+1,sp)
 462  001f e700          	ld	(___uartBuffer,x),a
 463  0021 20f0          	jra	L361
 507                     	xdef	_uartReceive8
 508                     	xdef	_uartStringReceived
 509                     	xdef	_uartTxComplete
 510                     	xdef	_uartSendStringAsync
 511                     	xdef	_uartSendString
 512                     	xdef	_uartTransmit
 513                     	xdef	_uartInit
 514                     	xdef	___uartBufferIndex
 515                     	switch	.ubsct
 516  0000               ___uartBuffer:
 517  0000 000000000000  	ds.b	32
 518                     	xdef	___uartBuffer
 519  0020               ___strPtr:
 520  0020 0000          	ds.b	2
 521                     	xdef	___strPtr
 522                     	xref	_UART1_GetFlagStatus
 523                     	xref	_UART1_SendData8
 524                     	xref	_UART1_ITConfig
 525                     	xref	_UART1_Cmd
 526                     	xref	_UART1_Init
 527                     	xref	_UART1_DeInit
 547                     	end
