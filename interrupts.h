#include "stm8s.h"

INTERRUPT_HANDLER_TRAP(uartReceive8Interrupt);
INTERRUPT_HANDLER_TRAP(uartTxCompleteInterrupt);