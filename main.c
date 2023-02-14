#include "stm8s.h"
#include "init.h"
#include "uart.h"
#include "string.h"

void uartStringReceived(char* str) {
	uint8_t num;
	uartSendString(str);
	if(strcmp(str, "Clear") == 0) {
		uartSendString("\"Clear\" received");
	}
	num = stringToNum(str);
	if(num) {
		uartSendString("Number received:");
		uartSendByte(num);
		uartSendByte(0x0D);
	}
}

main()
{
	init();
	
	while (1);
}