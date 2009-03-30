	int RCW = 3; // enable clockwise radius motor control - 3 on arduino to pin 1 on h-bridge
	int RCWPWM = 5; // control radius motor power level (PWM) - 5 on arduino opposite to pin 2 and actual to 7 on h-bridge
	int RCCW = 9; // enable counter-clockwise radius motor control - 9 on arduino to pin 9 on h-bridge
	int RCCWPWM = 10; // ?? check 

	char ARDUINO_HANDSHAKE = '@';

	void setup ()
	{
		Serial.begin (9600);

		/* send handshake to computer */
		Serial.print (ARDUINO_HANDSHAKE);

		pinMode (RCW, OUTPUT);
		pinMode (RCCW, OUTPUT);
		pinMode (RCWPWM, OUTPUT);
		pinMode (RCCWPWM, OUTPUT);
	}

	void loop ()
	{
		// body of the program
		// collect input from the encoders -- it will need to store some of
		// this until the next time it surfaces to communicate
		// pass instructions to the gear motors
		// communicate back and forth with the computer

		if (Serial.available ())
		{
			char val = Serial.read ();
			if (val == 'A')
			{
				RadiusClockwise (128, 500);
			}
			if (val == 'B')
			{
				RadiusCounterClockwise (128, 500);
			}
			if (val == 'C')
			{
				TestZeroPower();
			}
		}
	}
	
	void TestZeroPower()
	{
		digitalWrite (RCW, HIGH);
		analogWrite (RCWPWM, 0);
		delay (1000);
		digitalWrite (RCW, LOW);
		digitalWrite (RCWPWM, LOW);
	}

	void RadiusClockwise (int power, int duration)
	{
		digitalWrite (RCW, HIGH);
		for (int i = 0; i < 26; i++ )
		{
			analogWrite (RCWPWM, i * 10);
			delay (50);
		}
		digitalWrite (RCW, LOW);
		digitalWrite (RCWPWM, HIGH);
	}

	void RadiusCounterClockwise (int power, int duration)
	{

		digitalWrite (RCCW, HIGH);
		for (int i = 0; i < 26; i++ )
		{
			analogWrite (RCCWPWM, i * 10);
			delay (50);
		}
		digitalWrite (RCCW, LOW);
		digitalWrite (RCCWPWM, LOW);
	}
