// create a global variabled called led, 
// and assign pin9 to it
led <- hardware.pin9;
 
// configure led to be a digital output
led.configure(DIGITAL_OUT);
 
// function to turn LED on or off
function setLed(ledState) {
  server.log("Set LED: " + ledState);
  led.write(ledState);
}
 
// register a handler for "led" messages from the agent
agent.on("led", setLed);
