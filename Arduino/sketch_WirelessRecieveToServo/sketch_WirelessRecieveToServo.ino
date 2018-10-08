#include <Servo.h>
#include <SPI.h>
#include "nRF24L01.h"
#include "RF24.h"
#include "printf.h"

// Hardware configuration: Set up nRF24L01 radio on SPI bus plus pins 7 & 8 
RF24 radio(7,8);
const uint64_t pipes[2] = { 0xABCDABCD71LL, 0x544d52687CLL };              // Radio pipe addresses for the 2 nodes to communicate.

// A single byte to keep track of the data being sent back and forth
byte counter = 1;
const rf24_datarate_e dataRate = RF24_250KBPS; //Data rate defined in the documentations, RF24_250KBPS, RF24_1MBPS or RF24_2MBPS 
int dataToSend[5];

//Servos
Servo servoX;
Servo servoY;
Servo servoFlex1;
Servo servoFlex2;

void setup(){
  Serial.begin(9600);
  printf_begin();

  //Setup Servos
  servoX.attach(2); 
  servoY.attach(3); 
  servoFlex1.attach(4); 
  servoFlex2.attach(5); 

  // Setup and configure rf radio
  radio.begin();
  radio.setAutoAck(1);                    // Ensure autoACK is enabled
  radio.enableAckPayload();               // Allow optional ack payloads
  radio.setRetries(0,15);                 // Smallest time between retries, max no. of retries
  radio.openReadingPipe(1,pipes[1]);
  radio.startListening();                 // Start listening
  radio.printDetails();                   // Dump the configuration of the rf unit for debugging
  radio.setDataRate(dataRate); //Giving the data rate speed
}

void loop(void) {
  unsigned long time = micros();                          // Take the time, and send it.  This will block until complete   
  while(radio.available() ){
    radio.read( dataToSend, sizeof(dataToSend) );
    //radio.writeAckPayload(pipeNo,dataToSend, sizeof(dataToSend) ); 
    unsigned long tim = micros();
    printf("Got response %d, %d, %d, %d, %d, round-trip delay: %lu microseconds\n\r",dataToSend[0],dataToSend[1],dataToSend[2],dataToSend[3],dataToSend[4],tim-time);   
  
  //  servo_sweep_horizontal.write(sweep_horizontal_pos); 

//  int value;
//  value = dataToSend[0];
    //setServo(servoX, value, -1000, 1000, 0, 180);
    //GYRO setServoY(dataToSend[1], -32767, 32767, 0, 180);
    setServoX(dataToSend[0], -18000, 18000, 0, 180);
    setServoY(dataToSend[1], -18000, 18000, 0, 180);
    setServoFlex1(dataToSend[3], 550, 830, 0, 180);
    setServoFlex2(dataToSend[4], 550, 830, 0, 180);
    delay(50);
  }
}


void setServoFlex1(int value, int fromLower, int fromUpper, int toLower, int toUpper)
{
    int servoAngle;
    servoAngle = map(value, fromLower, fromUpper, toLower, toUpper);
    servoFlex1.write(servoAngle); 
}


void setServoFlex2(int value, int fromLower, int fromUpper, int toLower, int toUpper)
{
    int servoAngle;
    servoAngle = map(value, fromLower, fromUpper, toLower, toUpper);
    servoFlex2.write(servoAngle); 
}

void setServoX(int value, int fromLower, int fromUpper, int toLower, int toUpper)
{
    // Convert to range of 0-180
    //int servoAngle = map(output, -1000, 1000, 0, 180);
    int servoAngle;
    servoAngle = map(value, fromLower, fromUpper, toLower, toUpper);
    servoX.write(servoAngle); 
}

void setServoY(int value, int fromLower, int fromUpper, int toLower, int toUpper)
{
    // Convert to range of 0-180
    //int servoAngle = map(output, -1000, 1000, 0, 180);
    int servoAngle;
    servoAngle = map(value, fromLower, fromUpper, toLower, toUpper);
    servoY.write(servoAngle); 
}
