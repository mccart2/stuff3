// Tom McCarroll
// Part 2 LED Blink w/ button using ASM

.org 0x00

SBI DDRB,2 //Define Pin 2 as output
LDI R20,5 //Value we will put into rescaler register
STS TCCR1B,R20 // Store in register defined the value from R20 which sets prescaler


Main:
IN R16, PINC // This lets us know to read from all pins on PortC
ANDI R16, 0x06 // This tells us to only look at PIN 0 for input 
CPI R16, 0x06 // if the button is pressed values are the same
BRNE Main // if values are not the same then jump back to main and keep reading pinC
RJMP Pressed // otherwise it is pressed and start timer

Pressed:
LDI R20,0x00 //Resets counter to zero
STS TCNT1H,R20 // Loads the value from R20 into the high bit of TCNT1
STS TCNT1L,R20 // Loads the value from R20 into the low bit of TCNT1
SBI PORTB,2  // Turns on PortB Pin 5
RJMP Time1

Turnoff:
LDI R21, 0 // Set R21 to 0
OUT PORTB, R21 // Toggle PORT B to off
RJMP Main // Relative Jump to Main

Time1:
LDS R29, TCNT1H // Loads R29 with the data stored in TCNT1 high
LDS R28, TCNT1L // Loads R28 with the data stored in TCNT1 low
CPI R28, LOW(0x2625) //comparing if lower 8 bits of timer is 0x25
BRSH Time2

Time2:
CPI R29, HIGH(0x2625) //check to see if upper timer bits have reached the desired value
BRNE Time1 //if not, recheck the lower bits
RJMP Turnoff //once the timer reached the desired value, toggle the LED

