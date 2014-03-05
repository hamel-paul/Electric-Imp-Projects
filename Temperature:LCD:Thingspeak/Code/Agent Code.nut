/*
* @author: Paul Hamel
* This code takes in the reading of the temperature and sends it to Thingspeak.com
* 
*/

//Variables used to send things to Thingspeak.com
local thingspeakURL = "http://api.thingspeak.com/update";
//Last string in header will change depending on the channel
local headers = {"Content-Type": "application/x-www-form-urlencoded","X-THINGSPEAKAPIKEY":"FAD1ILOBDPY2SLDE "};
local field = "field1";

//Method to send temperature to Thingspeak
function toThingSpeak(data)
{
    local request = http.post(thingspeakURL, headers, data);
    local response = request.sendsync();
    return response;
}

device.on("updateTemp", function(temp) {
    local response = toThingSpeak(field +"="+temp);
    server.log(response.body);
});
