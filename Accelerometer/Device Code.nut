/*
* @author: Paul Hamel
*
*/

function form12bit(msb,lsb) {
  local v = ((msb << 8) + lsb) >> 4;
  if (v & 0x800) v = -(0x1000 - v);
  return v;
}

function readAccelerometer() {
  local mmaaddr = 0x1d << 1;
  local ret;

  local v = i2c.read(mmaaddr,"\x0d",1);
  server.log(format("mma who %2x",v[0]));

  local v = i2c.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  local m = blob(2);
  m[0] = 0x2a;
  m[1] = v[0] & 0xfe; // clear active bit
  ret = i2c.write(mmaaddr,m.tostring());

  local v = i2c.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  // change register configuration

  local v = i2c.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  m[0] = 0x2a;
  m[1] = v[0] | 0x01; // set active bit
  ret = i2c.write(mmaaddr,m.tostring());

  local v = i2c.read(mmaaddr,"\x2a",1);
  server.log(format("mma ctrl1 %2x",v[0]));

  local xyz = i2c.read(mmaaddr,"\x01",6);
//  server.log(format("mma xyz %2x %2x   %2x %2x   %2x %2x",
//              xyz[0],xyz[1],xyz[2],xyz[3],xyz[4],xyz[5]));

  local x = form12bit(xyz[0],xyz[1]);
  local y = form12bit(xyz[2],xyz[3]);
  local z = form12bit(xyz[4],xyz[5]);

  server.log(format("mma %d %d %d",x,y,z));
}
