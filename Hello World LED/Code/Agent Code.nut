// Log the URLs we need
server.log("Turn LED On: " + http.agenturl() + "?led=1");
server.log("Turn LED Off: " + http.agenturl() + "?led=0");
 
function requestHandler(request, response) {
  try {
    // check if the user sent led as a query parameter
    if ("led" in request.query) {
      
      // if they did, and led=1.. set our variable to 1
      if (request.query.led == "1" || request.query.led == "0") {
        // convert the led query parameter to an integer
        local ledState = request.query.led.tointeger();
 
        // send "led" message to device, and send ledState as the data
        device.send("led", ledState); 
      }
    }
    // send a response back saying everything was OK.
    response.send(200, "OK");
  } catch (ex) {
    response.send(500, "Internal Server Error: " + ex);
  }
}
 
// register the HTTP handler
http.onrequest(requestHandler);
