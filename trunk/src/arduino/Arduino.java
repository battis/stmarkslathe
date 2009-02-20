
package arduino;

import processing.core.*;
import processing.serial.*;

@SuppressWarnings ("serial")
public class Arduino extends PApplet
{	
	public static final String ARDUINO_HANDSHAKE = "@";
	private Serial port;

	public void setup ()
	{
		/* get a list of all active ports */
		String ports[] = Serial.list ();
		Timer t = new Timer (2500);
		
		/* try every port, looking for the handshake from the Arduino board */
		boolean handshake = false;
		for (int i = 0; i < ports.length && !handshake; i++ )
		{
			System.out.println ("Testing " + ports[i] + "...");
			
			/* open connection to port */
			port = new Serial (this, ports[i], 9600);
			
			/* wait a couple of seconds for a response */
			t.reset ();
			while ( (port.available () < 1) && (t.isRunning ()))
			{}
			
			/* check any response received against the handshake */
			if (port.available () > 0)
			{
				if (port.readString ().equals (ARDUINO_HANDSHAKE))
				{
					println ("Arduino USB connected to port " + ports[i]);
					handshake = true;
				}
			}
		}
		if (!handshake)
		{
			System.out.println ("Arduino USB was not found.");
		}
	}

	public void draw ()
	{
		Timer t = new Timer (3000);
		
		// sending instructions about how to control the lathe
		// collecting information about the encoders
		// communicating with the rest of the lathe software on the computer
		
		System.out.println ("Testing RCW");
		port.write('A');
	
		t.reset();
		while (t.isRunning()) {}
		
		System.out.println ("Testing RCCW");
		port.write('B');
		
		t.reset();
		while (t.isRunning()) {}

	}
}