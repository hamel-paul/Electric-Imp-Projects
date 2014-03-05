/*
* @author: Paul Hamel
* This is the device code for a temperature sensor and a LCD screen.
* The TakeTemp method will use the temperature sensor to read in the temperature
* and the LCD screen to print out the reading.
*/
//Configure LCD screen
lcd <- hardware.uart57;
lcd.configure(9600, 8, PARITY_NONE, 1, NO_CTSRTS);

//Configure temperature sensor
tmp102 <- hardware.i2c12;
tmp102.configure(CLOCK_SPEED_100_KHZ);

//Method that reads the temperature from the sensor and prints it out on the LCD screen
function TakeTemp()
{
    //reading the temperature and converting it to Celcius
    server.log("Taking temperature...");
    local v = tmp102.read(0x90, "\x00", 2);
    local t = ((((v[0] & 0x7f) << 8) + v[1] >> 4) * 0.0625);
    server.log(t);

    //writing the temperature to the LCD screen
    server.log("Writing..."); 
    lcd.write(0xFE);
    lcd.write(0x01);
    lcd.write(0x80);
    lcd.write(t + " C");
    
    agent.send("updateTemp", t);
    imp.wakeup(60, TakeTemp);
}

//Configuring the imp and running the method
imp.configure("Tmp102 sensor", [],[]);
TakeTemp();
