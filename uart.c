#include "stm8s.h"

#define __UART_MAX_STRING_LENGTH 32

char* __uartStrPtr;
char __uartBuffer[__UART_MAX_STRING_LENGTH];
uint8_t __uartBufferIndex = 0;

void uartInit(void) {
	UART1_DeInit();
	UART1_Init(	57600,
							UART1_WORDLENGTH_8D,
							UART1_STOPBITS_1,
							UART1_PARITY_NO,
							UART1_SYNCMODE_CLOCK_DISABLE,
							UART1_MODE_TXRX_ENABLE);
	UART1_ITConfig(	UART1_IT_RXNE, ENABLE);
	UART1_Cmd(ENABLE);
}

void uartTransmit(uint8_t data) {
	while(!UART1_GetFlagStatus(UART1_FLAG_TXE));
	UART1_SendData8(data);
}

void uartSendString(char* str) {
	while(*str) {
		uartTransmit(*str++);
	}
}

void uartSendStringAsync(char* str) {
	__uartStrPtr = str;
	UART1_ITConfig(UART1_IT_TXE, ENABLE);
}

void uartTxComplete(void) {
	if (*__uartStrPtr) {
		UART1_SendData8(*__uartStrPtr++);
	}
	else {
		UART1_ITConfig(UART1_IT_TXE, DISABLE);
	}
}

void uartStringReceived(char* str) {
	uartSendString(str);
}

void uartReceive8(uint8_t c) {
	if(c == '\r' || __uartBufferIndex >= __UART_MAX_STRING_LENGTH) {
		__uartBuffer[__uartBufferIndex] = c;
		__uartBufferIndex = 0;
		uartStringReceived(__uartBuffer);
	}
	else {
		__uartBuffer[__uartBufferIndex++] = c;
	}
}

