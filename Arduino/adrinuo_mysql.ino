#include <SPI.h>
#include <Ethernet.h>

byte mac[] = {
  0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };
 
// Enter the IP address for Arduino, as mentioned we will use 192.168.0.16
// Be careful to use , insetead of . when you enter the address here
IPAddress ip(192,168,0,16);

int photocellPin = 0;  // Analog input pin on Arduino we connected the SIG pin from sensor
int photocellReading;  // Here we will place our reading

char server[] = "192.168.0.11";
EthernetClient client;

void setup() {
  Serial.begin(9600);
  Ethernet.begin(mac, ip);
    }
void loop() {
 
  photocellReading = analogRead(photocellPin); 
   
  if (client.connect(server, 80)) {
    client.print("GET /write_data.php?"); 
    client.print("value="); 
    client.print(photocellReading); 
    client.println(" HTTP/1.1"); 
    client.println("Host: 192.168.0.11");
    client.println("Connection: close"); 
    client.println(); 
    client.stop();    

  }

  else {
    Serial.println("connection failed");
  }

  delay(10000);
}
