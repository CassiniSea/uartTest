/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */

#include "stm8s.h"
#include "init.h"
#include "uart.h"

void uartStringReceived(char* str) {
	uartSendString(str);
}

main()
{
	init();
	
	while (1);
}