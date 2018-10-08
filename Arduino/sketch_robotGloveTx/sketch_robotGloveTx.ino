#include<Wire.h> //Required for Gyro
#include <SPI.h>   //Required for Wireless
#include "RF24.h"  //Required for Wireless
#include "nRF24L01.h" //Required for Wireless
#include "printf.h"

//Loop cycle segments
const int loopSegments=360;
int loopCounter=0;

//Log
int logFlexLevel = 0;
int logGyroLevel = 0;
int logWirelessTxLevel = 1;
int logWirelessRxLevel = 0;

//Gyro
const int MPU_addr=0x68;  // I2C address of the MPU-6050
int16_t AcX,AcY,AcZ,Tmp,GyX,GyY,GyZ;

//Flex Sensors
const int flexPin1 = 8;
const int flexPin2 = 1;
int flexPosition1;
int flexPosition2;

//Wireless
RF24 myRadio (7, 8); // "myRadio" is the identifier you will use in following methods
// Topology 
const uint64_t pipes[2] = { 0xABCDABCD71LL, 0x544d52687CLL };              // Radio pipe addresses for the 2 nodes to communicate.

byte addresses[][6] = {"1Node"}; // Create address for 1 pipe.
int dataToSend[5]; // Data that will be received from the transmitter
//uint8_t dataToSend[5]; // Data that will be received from the transmitter
//byte dataToSend[5];  // Data that will be received from the transmitter
int ackMessage[1]; //Acknowledgment message, means the message that will be received from the receiver (robot), 1 element for the moment
//Defining the radio variables and values
const uint64_t pipe = 0xE8E8F0F0E1LL; //pipe address
const rf24_datarate_e dataRate = RF24_250KBPS; //Data rate defined in the documentations, RF24_250KBPS, RF24_1MBPS or RF24_2MBPS 


void setup() {
  Serial.begin(9600); // Open serial monitor at 115200 baud to see ping results.
  printf_begin();
  
  //Setup Gyro
  Wire.begin();
  Wire.beginTransmission(MPU_addr);
  Wire.write(0x6B);  // PWR_MGMT_1 register
  Wire.write(0);     // set to zero (wakes up the MPU-6050)
  Wire.endTransmission(true);

  //Setup Wireless - WRITE
  myRadio.begin();
  myRadio.setAutoAck(1);                    // Ensure autoACK is enabled
  myRadio.enableAckPayload();               // Allow optional ack payloads
  myRadio.setRetries(0,15);                 // Smallest time between retries, max no. of retries
  myRadio.setPayloadSize(sizeof(dataToSend));                // Here we are sending 1-byte payloads to test the call-response speed
  myRadio.openWritingPipe(pipes[1]);        // Both radios listen on the same pipes by default, and switch when writing
  myRadio.printDetails(); 

  //Setup Wireless - WRITE
//    myRadio.begin();  
//    myRadio.setChannel(108);
    myRadio.setDataRate(dataRate); //Giving the data rate speed
//    myRadio.enableAckPayload(); //enables receiving data from receiver side
//  

  //Setup Wireless - READ
//  myRadio.begin();  // Start up the physical nRF24L01 Radio
//  myRadio.setChannel(108);  // Above most Wifi Channels
//  myRadio.setPALevel(RF24_PA_MIN);  // Set the PA Level low to prevent power supply related issues since this is a getting_started sketch, and the likelihood of close proximity of the devices. RF24_PA_MAX is default
//  //  myRadio.setPALevel(RF24_PA_MAX);  // Uncomment for more power
//  myRadio.openReadingPipe(1, addresses[0]); // Use the first entry in array 'addresses' (Only 1 right now)
//  myRadio.startListening();


}

void loop() {
  
  UpdateLoopCounter();
 
  //Flex Sensors - Read every 360 cycles
  if(loopCounter % 360 == 0)
  {
    ReadFlexSensors();
  }


 //Gyro - Read every 360 cycles
  if(loopCounter % 360 == 0)
  {
    ReadGyro();
  }

  if(loopCounter % 360 == 0)
  {
    SendData();
  }
  
  //AcknowledgmentDATA();
}



void SendData()
{
//  byte gotByte;  
//    unsigned long time = micros();                          // Take the time, and send it.  This will block until complete   
//                                                            //Called when STANDBY-I mode is engaged (User is finished sending)
//    if (!radio.write( &counter, 1 )){
//      Serial.println(F("failed."));      
//    }
  //myRadio.openWritingPipe(pipe); //Opens Pipe 0 for Writing
//  dataToSend[0] = 'A';
//  dataToSend[1] = 'B';
//  dataToSend[2] = 'C';
//  dataToSend[3] = 'D';
//  dataToSend[4] = 'E';

  
  if(logWirelessTxLevel>0)
  {
    //Serial.print("Sending Data: ");
    //Serial.println(dataToSend[0]);
     printf("Sending %d, %d, %d, %d, %d \n\r",dataToSend[0],dataToSend[1],dataToSend[2],dataToSend[3],dataToSend[4]);   
 
  }
  
    myRadio.stopListening();  
  myRadio.write(dataToSend, sizeof(dataToSend)); //Sends the Data
}

//DATA Receiving from the Receiver part, Acknowledgment Data
void AcknowledgmentDATA(){
  if ( myRadio.isAckPayloadAvailable() ){
    myRadio.read(&ackMessage, sizeof(ackMessage));
    if(logWirelessRxLevel>0)
    {
      Serial.println(ackMessage[0]);
    }
  }else{
    if(logWirelessRxLevel>0)
    {
      Serial.println("No connection is made");
    }
  }
}

//
//void ReceiveData()
//{
//  if ( myRadio.available()) // Check for incoming data from transmitter
//  {
//    while (myRadio.available())  // While there is data ready
//    {
//      myRadio.read( &dataReceived, sizeof(dataReceived) ); // Get the data payload (You must have defined that already!)
//    }
//     if(strlen(dataReceived)!=0)
//     {
//      if(dataReceived>0)
//      {
//        // DO something with the data, like print it
//        Serial.print("Data received = ");
//        Serial.println(dataReceived);
//      }
//     }
//  } //END Radio available
//}



void ReadGyro()
{
  Wire.beginTransmission(MPU_addr);
  Wire.write(0x3B);  // starting with register 0x3B (ACCEL_XOUT_H)
  Wire.endTransmission(false);
  Wire.requestFrom(MPU_addr,14,true);  // request a total of 14 registers
  AcX=Wire.read()<<8|Wire.read();  // 0x3B (ACCEL_XOUT_H) & 0x3C (ACCEL_XOUT_L)    
  AcY=Wire.read()<<8|Wire.read();  // 0x3D (ACCEL_YOUT_H) & 0x3E (ACCEL_YOUT_L)
  AcZ=Wire.read()<<8|Wire.read();  // 0x3F (ACCEL_ZOUT_H) & 0x40 (ACCEL_ZOUT_L)
  Tmp=Wire.read()<<8|Wire.read();  // 0x41 (TEMP_OUT_H) & 0x42 (TEMP_OUT_L)
  GyX=Wire.read()<<8|Wire.read();  // 0x43 (GYRO_XOUT_H) & 0x44 (GYRO_XOUT_L)
  GyY=Wire.read()<<8|Wire.read();  // 0x45 (GYRO_YOUT_H) & 0x46 (GYRO_YOUT_L)
  GyZ=Wire.read()<<8|Wire.read();  // 0x47 (GYRO_ZOUT_H) & 0x48 (GYRO_ZOUT_L)

  dataToSend[0] = AcX;
  dataToSend[1] = AcY;
  dataToSend[2] = AcZ;
    
  if (logGyroLevel>0)
  {
    Serial.print("GYRO - AcX = "); Serial.print(AcX);
    Serial.print(" | AcY = "); Serial.print(AcY);
    Serial.print(" | AcZ = "); Serial.print(AcZ);
    Serial.print(" | Tmp = "); Serial.print(Tmp/340.00+36.53);  //equation for temperature in degrees C from datasheet
    Serial.print(" | GyX = "); Serial.print(GyX);
    Serial.print(" | GyY = "); Serial.print(GyY);
    Serial.print(" | GyZ = "); Serial.println(GyZ);
  }
}


void ReadFlexSensors()
{
  flexPosition1 = analogRead(flexPin1);
  flexPosition2 = analogRead(flexPin2);
  dataToSend[3] = flexPosition1;
  dataToSend[4] = flexPosition2;
  
  if (logFlexLevel>0)
  {
    Serial.print("Flex Pos1: ");
    Serial.print(flexPosition1);    
    Serial.print("   Flex Pos2: ");
    Serial.println(flexPosition2);
  }
}

void UpdateLoopCounter()
{
  delay(1);
  if (loopCounter >= loopSegments)
  {
    loopCounter = 0;
  }
  loopCounter +=1;
  
}
