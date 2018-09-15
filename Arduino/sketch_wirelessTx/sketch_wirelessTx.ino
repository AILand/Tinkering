
/*
* Arduino Wireless Communication Tutorial
*     Example 1 - Transmitter Code
*                
* by Dejan Nedelkovski, www.HowToMechatronics.com
* 
* Library: TMRh20/RF24, https://github.com/tmrh20/RF24/
*/
#include <SPI.h>
#include <nRF24L01.h>
#include <RF24.h>
RF24 radio(7, 8); // CE, CSN
const byte address[6] = "00001";
const int flexPin1 = 4;

void setup() {
  Serial.begin(115200); // Open serial monitor at 115200 baud to see ping results.
  radio.begin();
  radio.openWritingPipe(address);
  radio.setPALevel(RF24_PA_MIN);
  radio.stopListening();
}
void loop() {
  int flexPosition1;
  flexPosition1 = analogRead(flexPin1);
  Serial.print("Flex Pos: ");
  Serial.println(flexPosition1);
  
  const char text[] = "Hello World";
  //radio.write(&text, sizeof(text));

  radio.write(&flexPosition1, sizeof(flexPosition1));

  delay(1000);
}