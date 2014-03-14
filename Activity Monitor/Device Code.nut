/*
* @author: Paul Hamel
*
*/

MMA8452 <- hardware.i2c12;
MMA8452.configure(CLOCK_SPEED_100_KHZ);

led <- hardware.pin9;
led.configure(DIGITAL_OUT);

ReadAddr <- 0x3B;
WriteAddr <- 0x3A;
input <- "squat";
reps <- 0;

function chooseFunction(inp)
{
    if(inp == "slouch")
    {
        imp.wakeup(2.0, Slouch)
    }
    if(inp == "squat")
    {
        imp.wakeup(2.0, Squat)
    }
    if(inp == "curls")
    {
        imp.wakeup(2.0, Curls)
    }
    
}

function form12bit(msb,lsb)
{
  local v = ((msb << 8) + lsb) >> 4;
  if (v & 0x800) v = -(0x1000 - v);
  return v;
}

//imp pointing up
function Slouch()
{
  local mmaaddr = 0x1d << 1;
  local ret;

  local v = MMA8452.read(mmaaddr,"\x0d",1);
  server.log(format("mma who %2x",v[0]));

  local v = MMA8452.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  local m = blob(2);
  m[0] = 0x2a;
  m[1] = v[0] & 0xfe; // clear active bit
  ret = MMA8452.write(mmaaddr,m.tostring());

  local v = MMA8452.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  // change register configuration

  local v = MMA8452.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  m[0] = 0x2a;
  m[1] = v[0] | 0x01; // set active bit
  ret = MMA8452.write(mmaaddr,m.tostring());

  local v = MMA8452.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  local xyz = MMA8452.read(mmaaddr,"\x01",6);
//  server.log(format("mma xyz %2x %2x   %2x %2x   %2x %2x",
//              xyz[0],xyz[1],xyz[2],xyz[3],xyz[4],xyz[5]));

  local x = form12bit(xyz[0],xyz[1]);
  local y = form12bit(xyz[2],xyz[3]);
  local z = form12bit(xyz[4],xyz[5]);

  server.log(format("mma %d %d %d",x,y,z));
  imp.wakeup(2.0, Slouch);
  
  if(x > -1000)
  {
      server.log("Sit up!");
      led.write(1);
  }
  else
  {
      led.write(0);
  }
}

//imp pointing right
function Squat()
{
    local mmaaddr = 0x1d << 1;
  local ret;

  local v = MMA8452.read(mmaaddr,"\x0d",1);
  server.log(format("mma who %2x",v[0]));

  local v = MMA8452.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  local m = blob(2);
  m[0] = 0x2a;
  m[1] = v[0] & 0xfe; // clear active bit
  ret = MMA8452.write(mmaaddr,m.tostring());

  local v = MMA8452.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  // change register configuration

  local v = MMA8452.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  m[0] = 0x2a;
  m[1] = v[0] | 0x01; // set active bit
  ret = MMA8452.write(mmaaddr,m.tostring());

  local v = MMA8452.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  local xyz = MMA8452.read(mmaaddr,"\x01",6);
//  server.log(format("mma xyz %2x %2x   %2x %2x   %2x %2x",
//              xyz[0],xyz[1],xyz[2],xyz[3],xyz[4],xyz[5]));

  local x = form12bit(xyz[0],xyz[1]);
  local y = form12bit(xyz[2],xyz[3]);
  local z = form12bit(xyz[4],xyz[5]);

  server.log(format("mma %d %d %d",x,y,z));
  imp.wakeup(2.0, Squat);
  
  if(y > 0)
  {
      led.write(0);
  }
  else
  {
      led.write(1);
      reps = reps + 1;
      server.log(reps);
  }  
}

//imp pointing at wrist
function Curls()
{
    local mmaaddr = 0x1d << 1;
    local ret;

  local v = MMA8452.read(mmaaddr,"\x0d",1);
  server.log(format("mma who %2x",v[0]));

  local v = MMA8452.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  local m = blob(2);
  m[0] = 0x2a;
  m[1] = v[0] & 0xfe; // clear active bit
  ret = MMA8452.write(mmaaddr,m.tostring());

  local v = MMA8452.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  // change register configuration

  local v = MMA8452.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  m[0] = 0x2a;
  m[1] = v[0] | 0x01; // set active bit
  ret = MMA8452.write(mmaaddr,m.tostring());

  local v = MMA8452.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  local xyz = MMA8452.read(mmaaddr,"\x01",6);
//  server.log(format("mma xyz %2x %2x   %2x %2x   %2x %2x",
//              xyz[0],xyz[1],xyz[2],xyz[3],xyz[4],xyz[5]));

  local x = form12bit(xyz[0],xyz[1]);
  local y = form12bit(xyz[2],xyz[3]);
  local z = form12bit(xyz[4],xyz[5]);

  server.log(format("mma %d %d %d",x,y,z));
  imp.wakeup(2.0, Curls);
  
  if(x < -750)
  {
    led.write(1);
    reps = reps + 1;
    server.log(reps);
  }
  else
  {
      led.write(0);
  }  
}

chooseFunction(input);
