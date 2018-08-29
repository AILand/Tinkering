#include <NewPing.h>
#include <Servo.h>
#define TRIGGER_PIN  4  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     5  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 200 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

int loopCounter = 0;
const int loopDelay = 20;
int mydist;

//Logs
const int logLevel = 0;
const int logSonicRanger = 1;
const int logServoSweepPos = 0;

Servo servo_sweep_horizontal;  // create servo object to control a servo
Servo servo_sweep_vertical;
int sweep_horizontal_pos = 0;    // variable to store the servo position
int sweep_horizontal_direction = 1;  //0 for moving left, 1 for moving right
const int sweep_horizontal_range_degrees = 180;  //limit the range of movement for servo
const int sweep_step_size = 1;

const int sweepDistanceCm = 15;
int sweep_vertical_pos = 40;    // variable to store the servo position
int sweep_vertical_direction = 0;  //0 for moving down, 1 for moving up
const int sweep_vertical_range_degrees = 130;  //limit the range of movement for servo
const int sweep_vertical_pos_min = 40;  //limit the range of movement for servo
boolean verticalSweepAngleSet = false;


void setup() {
  Serial.begin(115200); // Open serial monitor at 115200 baud to see ping results.
  servo_sweep_horizontal.attach(7); 
  servo_sweep_vertical.attach(6); 

  servo_sweep_horizontal.write(sweep_horizontal_pos); 
  servo_sweep_vertical.write(sweep_vertical_pos); 
}


void loop() {

  //PerformSonicSweepVertical();
//
  if (!verticalSweepAngleSet)
  {
    verticalSweepAngleSet = SetSweepDistance();
    delay(5000);
    return;
  }
  
  delay(loopDelay);
  if (logLevel >= 1)
  {
    Serial.print("Loopcounter:");
    Serial.println(loopCounter);
  }
  
  UpdateLoopCounter();

  PerformSonicSweep();

 //  delay(200);                    // Wait 50ms between pings (about 20 pings/sec). 29ms should be the shortest delay between pings.
  if(loopCounter % 10 == 0)
  {
    int distance = ReadSonicRanger();
    if(distance==3)
    {
      verticalSweepAngleSet = false;
    }
    Serial.print("Ping: ");
    Serial.print(" Pos:");
    Serial.print(sweep_horizontal_pos);
    Serial.print(" Dist:");
    Serial.print(distance);
    Serial.println("cm");
  }
}


int ReadSonicRanger()
{
//i have just received several hc-sr04 with same bug. when it comes to out of range it returns 0 and set 1 on echo. senseor powered from 5V from arduino and GND to arduino's  GND. thist code helps for me. it resets the sensor.
//if (duration == 0) {
//  pinMode(echoPin,OUTPUT);
//  digitalWrite(echoPin,LOW);
//  delay(1);
//  pinMode(echoPin,INPUT);
//}
  
  int distance = sonar.ping_cm();
  return distance;
}



void PerformSonicSweepVertical()
{
  if(sweep_vertical_pos >= sweep_vertical_range_degrees)
  {
    sweep_vertical_direction = 0;
  } else if(sweep_vertical_pos <= sweep_vertical_pos_min)
  {
    sweep_vertical_direction = 1;
  } 
  
  if (sweep_vertical_direction == 0)
  {
     sweep_vertical_pos -= sweep_step_size;
  } else
  {
     sweep_vertical_pos += sweep_step_size;
  }

  servo_sweep_vertical.write(sweep_vertical_pos); 
  LogSweepVerticalPos(sweep_vertical_pos);
}


boolean SetSweepDistance()
{
  int minPosition = 90;
  int distance = 0;
  //sweepDistanceCm
  sweep_horizontal_pos = 90;
  servo_sweep_horizontal.write(sweep_horizontal_pos); 

  while(distance != sweepDistanceCm)
  {
    for (sweep_vertical_pos = minPosition; sweep_vertical_pos <= sweep_vertical_range_degrees; sweep_vertical_pos += 1) { // goes from 0 degrees to 180 degrees
      // in steps of 1 degree
      servo_sweep_vertical.write(sweep_vertical_pos);
      distance = ReadSonicRanger();
      LogSweepVerticalPos(distance);
      if(distance == sweepDistanceCm)
      {
        return true;
      }
      delay(50);                       
    }
    
    for (sweep_vertical_pos = sweep_vertical_range_degrees; sweep_vertical_pos >= minPosition; sweep_vertical_pos -= 1) { // goes from 180 degrees to 0 degrees
      servo_sweep_vertical.write(sweep_vertical_pos);
      distance = ReadSonicRanger();
      LogSweepVerticalPos(distance);
      if(distance == sweepDistanceCm)
      {
        return true;
      }
      delay(50);                      
    }
  }
  return false;
}

void LogSweepVerticalPos(int distance)
{
    Serial.print("Vert Pos:");
    Serial.print(sweep_vertical_pos);
    Serial.print(" Dist:");
    Serial.print(distance);
    Serial.println("cm");
}

void UpdateLoopCounter()
{
  if (loopCounter >= 360)
  {
    loopCounter = 0;
  }
  
  loopCounter +=1;
}

void PerformSonicSweep()
{
  if(sweep_horizontal_pos >= sweep_horizontal_range_degrees)
  {
    sweep_horizontal_direction = 0;
  } else if(sweep_horizontal_pos <= 0)
  {
    sweep_horizontal_direction = 1;
  } 
  
  if (sweep_horizontal_direction == 0)
  {
     sweep_horizontal_pos -= sweep_step_size;
  } else
  {
     sweep_horizontal_pos += sweep_step_size;
  }

  servo_sweep_horizontal.write(sweep_horizontal_pos); 
}


