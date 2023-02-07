#include "stm8s.h"

char* strPtr;

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
	strPtr = str;
	UART1_ITConfig(UART1_IT_TXE, ENABLE);
}

void uartTxComplete(void) {
	if (*strPtr) {
		UART1_SendData8(*strPtr++);
	}
	else {
		UART1_ITConfig(UART1_IT_TXE, DISABLE);
	}
}

void uartReceive8(uint8_t data) {
	uartSendString("Hello World\n");
}