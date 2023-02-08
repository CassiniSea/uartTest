/*
If you want to receive STRINGS by uart
define a UART_RECEIVE_STRINGS_ENABLE and
define a void uartStringReceived(char* str) function

else if you want receive a BYTE by uart
define a UART_RECEIVE_BYTE_ENABLE and
define a void uartReceive8(uint8_t c) function
*/
#define UART_RECEIVE_STRINGS_ENABLE
#define UART_MAX_STRING_LENGTH 32
//#define UART_RECEIVE_BYTE_ENABLE

#ifdef UART_RECEIVE_BYTE_ENABLE
	#undef UART_RECEIVE_STRINGS_ENABLE
#endif 

#if defined(UART_RECEIVE_STRINGS_ENABLE) || defined(UART_RECEIVE_BYTE_ENABLE)
	#define UART_RECEIVE8_INTERRUPT_VECTOR uartReceive8Interrupt
#else
	#define UART_RECEIVE8_INTERRUPT_VECTOR NonHandledInterrupt
#endif

void uartInit(void);
void uartTransmit(uint8_t);
void uartSendString(char*);
void uartTxComplete(void);
void uartStringReceived(char*);
void uartReceive8(uint8_t);
