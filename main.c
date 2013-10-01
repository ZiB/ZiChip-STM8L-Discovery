/*
 *	File:	main.c
 *	Date:	24.04.2011
 *	Denis Zheleznyakov aka ZiB @ http://ziblog.ru
 */

#include "main.h"

//------------------------------------------------------------------------------
void main(void)
{
	disableInterrupts();

	PIN_CONFIGURATION(PIN_LED_GREEN);
	PIN_CONFIGURATION(PIN_USER_BUTTON);

	enableInterrupts();

	while (1)
	{
		if(PIN_SIGNAL(PIN_USER_BUTTON))
		{
			PIN_ON(PIN_LED_GREEN);
		}
		else
		{
			PIN_OFF(PIN_LED_GREEN);
		}
	}
}
