//waking up the imp and configuring the the breakout board
tmp102 <- hardware.i2c12;
tmp102.configure(CLOCK_SPEED_100_KHZ);

function takeTemp()
{
    //wake up the imp
    imp.wakeup(5.0, takeTemp);
    //gets the imp going
    tmp102.write(0x90, "");
    tmp102.write(0x90, "0");
    //lets it process its working
    imp.sleep(0.05);
    //read in the temperature and print it out.
    
    
    server.log("Taking temperature...");
    local v = tmp102.read(0x90, "\x00", 2);
    local t = ((((v[0] & 0x7f) << 8) + v[1] >> 4) * 0.0625);
    server.log("Reading...")
    server.log(v);
    server.log(t + "ºC");
}

imp.wakeup(5.0, takeTemp);
