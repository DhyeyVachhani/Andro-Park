#include <SoftwareSerial.h>
SoftwareSerial mySerial(10, 11); // RX, TX

int i=0;
char str[12],inChar;
const int ledPin =  13;      // the number of the LED pin

void setup() {
  Serial.begin(9600);
  mySerial.begin(9600);
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);
  }

void loop() 
{ 
     
      while (mySerial.available()) 
      { 
        for(i=0;i<12;i++)
        {inChar=mySerial.read();
         str[i++]=inChar;
        }
       Serial.print(str);
       
       digitalWrite(ledPin, HIGH);
       delay(1);
       digitalWrite(ledPin, LOW);
       
     }
      
       
}
