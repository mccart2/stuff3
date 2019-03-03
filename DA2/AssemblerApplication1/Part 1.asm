//Tom McCarroll
// Part 1 LED Blink with ASM

.org 0
	LDI R16,32 //Loads the value into R16
	OUT DDRB, R16 //Uses the value in R16 to enable Pin5 as output
	LDI R17,0 //used to set or reset PB5
	LDI R20,5 //Value we will put into prescaler register
	STS TCCR1B,R20 // Store in register defined the value from R20 which sets prescaler

	Start:		
	LDI R20,0x00 //Resets counter to zero
 	STS TCNT1H,R20 // Loads the value from R20 into the high bit of TCNT1
	STS TCNT1L,R20 // Loads the value from R20 into the low bit of TCNT1
	OUT PORTB,R16 // Writes the value to PORTB Pin 5
	RJMP Low_Bit // Relative Jump to Low Bit Subroutine

	End:
	LDI R20,0x00 //Resets counter to zero
	STS TCNT1H,R20 // Loads the value from R20 into the high bit of TCNT1
	STS TCNT1L,R20 // Loads the value from R20 into the low bit of TCNT1
	OUT PORTB,R17  // Gives us a High Value for our LED
	RJMP Low_Bit2 // Jump to Low_Bit2

	Low_Bit:
	LDS R29, TCNT1H // Loads R29 with the data stored in TCNT1 high
	LDS R28, TCNT1L // Loads R28 with the data stored in TCNT1 low
	CPI R28,LOW(0x0DBB) //Compare if lower 8 bits of timer are 0xBB
	BRSH High_Bit //Branch if the lower bits of the timer match 
	RJMP Low_Bit //Jump back to the start and keep checking
	
	High_Bit:
	CPI R29,HIGH(0x0DBB) //Compare if higher 8 bits of timer are 0x0D
	BRNE Low_Bit //Branch if higher bits of timer dont match desired value back to the low bit checker
	RJMP End //Jump to End once timer has the correct value.
	
	Low_Bit2:
	LDS R29, TCNT1H //loading upper bit of counter to R29
	LDS R28, TCNT1L //loading lower bit of counter to R28
	CPI R28,LOW(0x0927) //comparing if lower 8 bits of timer is 0xBB
	BRSH High_Bit2 //if lower bits of timer have reached desired amount, check the upper bits/
	RJMP Low_Bit2 //otherwise, keep checking lower bits
	
	High_Bit2:
	CPI R29,HIGH(0x0927) //check to see if upper timer bits have reached the desired value
	BRNE Low_Bit2 //If target value not reached go hack to Low_Bit2 for more cycles
	JMP Start //Jump to the start and toggle LED again.
