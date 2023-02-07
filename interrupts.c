#include "stm8s.h"
#include "uart.h"

INTERRUPT void uartReceive8Interrupt(void)	{
	UART1_ClearITPendingBit(UART1_IT_RXNE);
	uartReceive8(UART1_ReceiveData8());
}