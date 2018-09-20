/*
  // March 2014 - TMRh20 - Updated along with High Speed RF24 Library fork
  // Parts derived from examples by J. Coliz <maniacbug@ymail.com>
*/
/**
 * Example for efficient call-response using ack-payloads 
 *
 * This example continues to make use of all the normal functionality of the radios including
 * the auto-ack and auto-retry features, but allows ack-payloads to be written optionally as well.
 * This allows very fast call-response communication, with the responding radio never having to 
 * switch out of Primary Receiver mode to send back a payload, but having the option to if wanting
 * to initiate communication instead of respond to a commmunication.
 */
 


#include <SPI.h>
#include "nRF24L01.h"
#include "RF24.h"
#include "printf.h"

// Hardware configuration: Set up nRF24L01 radio on SPI bus plus pins 7 & 8 
RF24 radio(7,8);

// Topology
const uint64_t pipes[2] = { 0xABCDABCD71LL, 0x544d52687CLL };              // Radio pipe addresses for the 2 nodes to communicate.

// Role management: Set up role.  This sketch uses the same software for all the nodes
// in this system.  Doing so greatly simplifies testing.  

typedef enum { role_ping_out = 1, role_pong_back } role_e;                 // The various roles supported by this sketch
const char* role_friendly_name[] = { "invalid", "Ping out", "Pong back"};  // The debug-friendly names of those roles
role_e role = role_pong_back;                                              // The role of the current running sketch

// A single byte to keep track of the data being sent back and forth
byte counter = 1;
const rf24_datarate_e dataRate = RF24_250KBPS; //Data rate defined in the documentations, RF24_250KBPS, RF24_1MBPS or RF24_2MBPS 
 int dataToSend[5];

void setup(){

  Serial.begin(9600);
  printf_begin();
  Serial.print(F("\n\rRF24/examples/pingpair_ack/\n\rROLE: "));
  Serial.println(role_friendly_name[role]);
  Serial.println(F("*** PRESS 'T' to begin transmitting to the other node"));

  // Setup and configure rf radio

  radio.begin();
  radio.setAutoAck(1);                    // Ensure autoACK is enabled
  radio.enableAckPayload();               // Allow optional ack payloads
  radio.setRetries(0,15);                 // Smallest time between retries, max no. of retries
  //radio.setPayloadSize(sizeof(dataToSend));                // Here we are sending 1-byte payloads to test the call-response speed
  //radio.openWritingPipe(pipes[1]);        // Both radios listen on the same pipes by default, and switch when writing
  radio.openReadingPipe(1,pipes[1]);
  radio.startListening();                 // Start listening
  radio.printDetails();                   // Dump the configuration of the rf unit for debugging
  radio.setDataRate(dataRate); //Giving the data rate speed

}

void loop(void) {

//  if ( Serial.available() )
//  {
      
       //role = role_pong_back;                // Become the primary receiver (pong back)
       //radio.openWritingPipe(pipes[1]);
       //radio.openReadingPipe(1,pipes[0]);
       //radio.startListening();
   
  
    unsigned long time = micros();                          // Take the time, and send it.  This will block until complete   
 
    byte pipeNo;
    //byte gotByte;  
   
    //char dataToSend[1];// Dump the payloads until we've gotten everything
    while(radio.available() ){
    //while( radio.available(pipes[1])){
      radio.read( dataToSend, sizeof(dataToSend) );
      //radio.writeAckPayload(pipeNo,dataToSend, sizeof(dataToSend) ); 
      unsigned long tim = micros();
      printf("Got response %d, %d, %d, %d, %d, round-trip delay: %lu microseconds\n\r",dataToSend[0],dataToSend[1],dataToSend[2],dataToSend[3],dataToSend[4],tim-time);   
  
    }
//}
  // Change roles

 
}











/////* YourDuinoStarter Example: Simple nRF24L01 Receive
////  - WHAT IT DOES: Receives simple fixed data with nRF24L01 radio
////  - SEE the comments after "//" on each line below
////   Start with radios about 4 feet apart.
////  - SEE the comments after "//" on each line below
////  - CONNECTIONS: nRF24L01 Modules See:
////  http://arduino-info.wikispaces.com/Nrf24L01-2.4GHz-HowTo
////  Uses the RF24 Library by TMRH2o here:
//
///*
//* Arduino Wireless Communication Tutorial
//*       Example 1 - Receiver Code
//*                
//* by Dejan Nedelkovski, www.HowToMechatronics.com
//* 
//* Library: TMRh20/RF24, https://github.com/tmrh20/RF24/
//*/
//#include <SPI.h>
//#include <nRF24L01.h>
//#include <RF24.h>
//RF24 radio(7, 8); // CE, CSN
//const byte address[6] = "00001";
//
//
//
//char dataToSend[32];; //Message to be transmitted, can contain up to 3 array elements, 3 bytes
//int ackMessage[1]; //Acknowledgment message, means the message that will be received from the receiver or the car, 1 element for the moment
//
////Defining the radio variables and values
//const uint64_t pipe = 0xE8E8F0F0E1LL; //pipe address
//const rf24_datarate_e dataRate = RF24_250KBPS; //Data rate defined in the documentations, RF24_250KBPS, RF24_1MBPS or RF24_2MBPS 
//
//
////VOID SETUP()
//void setup()
//{
//    Serial.begin(9600); //Default Baud rate 
//      
//    //radio start
//    radio.begin();  
//    radio.setChannel(108);
//    radio.setDataRate(dataRate); //Giving the data rate speed
//    radio.enableAckPayload(); //enables receiving data from receiver side
//  
//}
//
////MAIN LOOP FUNCTION
//void loop()
//{
//    //DataTransmission();
//    AcknowledgmentDATA();
//    
//    //Serial.println(ackMessage[1]);
//  
//}   
//  
//
////DATA Transmission Function
//void DataTransmission(){
//  
//    radio.openWritingPipe(pipe); //Opens Pipe 0 for Writing
//    dataToSend[0] = 'B';
//      
//    radio.write(&dataToSend, sizeof(dataToSend)); //Sends the Data
//  
//}
//
////DATA Receiving from the Receiver part, Acknowledgment Data
//void AcknowledgmentDATA(){
//    
//    if ( radio.isAckPayloadAvailable() ){
//       
//        radio.read(&dataToSend, sizeof(dataToSend));
//        Serial.println(dataToSend[0]);
//          
//     }else{
//         Serial.println("No connection is made");
//     }
//  
//}

//
//  https://github.com/TMRh20/RF24
//   1 - GND
//   2 - VCC 3.3V !!! NOT 5V
//   3 - CE to Arduino pin 7
//   4 - CSN to Arduino pin 8
//   5 - SCK to Arduino pin 13
//   6 - MOSI to Arduino pin 11
//   7 - MISO to Arduino pin 12
//   8 - UNUSED
//
//   V1.02 02/06/2016
//   Questions: terry@yourduino.com */
//
///*-----( Import needed libraries )-----*/
//#include <SPI.h>   // Comes with Arduino IDE
//#include "RF24.h"  // Download and Install (See above)
///*-----( Declare Constants and Pin Numbers )-----*/
////None yet
///*-----( Declare objects )-----*/
//// (Create an instance of a radio, specifying the CE and CS pins. )
//RF24 myRadio (7, 8); // "myRadio" is the identifier you will use in following methods
///*-----( Declare Variables )-----*/
//byte addresses[][6] = {"1Node"}; // Create address for 1 pipe.
////int dataReceived;  // Data that will be received from the transmitter
//char dataReceived[32]; // Data that will be received from the transmitter
//
////######## SETUP ###########
//void setup()   /****** SETUP: RUNS ONCE ******/
//{
//  // Use the serial Monitor (Symbol on far right). Set speed to 115200 (Bottom Right)
//  //Serial.begin(115200);
//  Serial.begin(9600);
//  delay(1000);
//  Serial.println(F("RF24/Simple Receive data Test"));
//  Serial.println(F("Questions: terry@yourduino.com"));
//
//  myRadio.begin();  // Start up the physical nRF24L01 Radio
//  myRadio.setChannel(108);  // Above most Wifi Channels
//  // Set the PA Level low to prevent power supply related issues since this is a
//  // getting_started sketch, and the likelihood of close proximity of the devices. RF24_PA_MAX is default.
//  myRadio.setPALevel(RF24_PA_MIN);
//  //  myRadio.setPALevel(RF24_PA_MAX);  // Uncomment for more power
//
//  myRadio.openReadingPipe(1, addresses[0]); // Use the first entry in array 'addresses' (Only 1 right now)
//  myRadio.startListening();
//
//}//--(end setup )---
//
//
////######## LOOP ###########
//void loop()   /****** LOOP: RUNS CONSTANTLY ******/
//{
//
//Serial.println("Checking if payload  Available");
//  if ( myRadio.available()) // Check for incoming data from transmitter
//  {
//    Serial.println("Radio Available");
//    while (myRadio.available())  // While there is data ready
//    {
//      Serial.println("Radio Read");
//      myRadio.read( &dataReceived, sizeof(dataReceived) ); // Get the data payload (You must have defined that already!)
//    }
////     if(strlen(dataReceived)!=0)
////     {
////      if(dataReceived[0]>0)
////      {
//        // DO something with the data, like print it
//        Serial.print("Data received = ");
//        Serial.println(dataReceived[0]);
//      //}
//    // }
//  } //END Radio available
//
//}//--(end main loop )---
//
///*-----( Declare User-written Functions )-----*/
//
////None yet
////*********( THE END )***********
