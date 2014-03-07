/*
* @author: Paul Hamel
*
*/

MMA8452 <- hardware.i2c12;
MMA8452.configure(I2C_12);

function readAccel()
{
    imp.wakeup(2.0, readAccel)
    
    server.log("Reading Acceleration...");
    local readx = MMA8452.read(0x01);
    local ready = MMA8452.read(0x03);
    local readz = MMA8452.read(0x05);
    local accelx = (((0x00FF >> (8 - numBits)) << bitPosition) ^ 0x00FF))
    local accely
    local accelz
    server.log(accelx);
    server.log(accely);
    server.log(accelz);
}

