// Tom McCarroll
// Part 2 LED Blink w/ button using C
#include <avr/io.h>

int main (void)
{
	DDRB = _BV(PINB2);  //All other PORTB Pins are inputs, but we are setting Pin2 as output
	TCCR1B = (1<<CS12) | (1<<CS10); //Set the bits to one 101 for our prescaler
	
	
	while (1)// Infinite loop
	{
		if(PINC & _BV(PINC2)) // If the button is pressed then perform the following events
		{
			TCNT1 = 0x00;   // Restart the clock 
			PORTB = _BV(PINB2);
			
			while(TCNT1 <= 0x2625 ) // While the clock is less than 1.25 seconds
			{
			}
			
			PORTB = 0x00; // After 1.25 Seconds has elapsed turn the LED/Port off.
		}
	}
	
	return 0;
}


