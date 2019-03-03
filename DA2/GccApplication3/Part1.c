//Tom McCarroll
//Part 1 LED Blink with C


#include <avr/io.h>
int main ()
{
	
	DDRB = 0xFF;// This should set  all PORT B Pins to output
	TCCR1B =  (1<<CS12) | (1<<CS10); // Bitwise logical OR, settings the bits to 101
	TCNT1 = 0x00;// Counter initialized to zero
	PORTB = 0x02; // Defines the pin we will be outputting to
	
	int toggle = 0x02;
	int counter = 0;
	
	
	while(1)
	{ 
		if(counter %2 == 0)
		{
			if(TCNT1==0x0DBB) // Checks the counter and enters loop to toggle on
			{
				PORTB ^= toggle; // Toggles PORTB to HIGH
				TCNT1 = 0x00; // Resets our counter
				counter+=1; // Increments our counter
			}
		
		else
		{
			if (TCNT1 == 0x927) //  Checks the counter and enters loop  to toggle off
			{
				TCNT1 = 0x00; // Resets the counter
				counter+=1;// Increments our counter
			}
		}
	}
	return 0;
	}
}