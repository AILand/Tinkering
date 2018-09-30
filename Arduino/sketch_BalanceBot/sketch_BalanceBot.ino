int input, output;

//Gyro mma7361 replacement variables
int x; // x axis variable
int y; // y axis variable
int z; // z axis variable
const int balancePoint=350;

// connect motor controller pins to Arduino digital pins
// motor one
int enA = 6;
int in1 = 2;
int in2 = 3;
// motor two
int enB = 7;
int in3 = 4;
int in4 = 5;
int tolleranceAmount = 25;
int minSpeed = 70;
int maxSpeed=100;
int accelDecelStep=30;
int accelDecelDelay=1; 
int rightLeftSpeedDifference=50;

void setup() {
  output=0;
  Serial.begin(9600);

  // set all the motor control pins to outputs
  pinMode(enA, OUTPUT);
  pinMode(enB, OUTPUT);
  pinMode(in1, OUTPUT);
  pinMode(in2, OUTPUT);
  pinMode(in3, OUTPUT);
  pinMode(in4, OUTPUT);

  //By default turn off both the motors
  //    analogWrite(4,LOW);
  //    analogWrite(5,LOW);
  //    analogWrite(6,LOW);
  //    analogWrite(7,LOW);
}

 

void loop() {
 
    // if programming failed, don't try to do anything
    //if (!dmpReady) return;
    output = analogRead(0); // read A5 input pin
    y = analogRead(1); // read A4 input pin
    z = analogRead(2); // read A3 input pin

    // Convert to range of 0-255
    int MotorSpeedF = map(output, balancePoint, balancePoint+50, minSpeed, maxSpeed);
    int MotorSpeedR = map(output, balancePoint, balancePoint-50, minSpeed, maxSpeed);

    if (output>(balancePoint+tolleranceAmount)) //Falling towards front 
      Forward(MotorSpeedF); //Rotate the wheels forward 
    else if (output<(balancePoint-tolleranceAmount)) //Falling towards back
      Reverse(MotorSpeedR); //Rotate the wheels backward 
    else //If Bot not falling
      Stop(); //Hold the wheels still

//    // wait for MPU interrupt or extra packet(s) available
//    while (!mpuInterrupt && fifoCount < packetSize)
//    {
//        //no mpu data - performing PID calculations and output to motors     
//        pid.Compute();   
//        
//        //Print the value of Input and Output on serial monitor to check how it is working.
//        Serial.print(input); Serial.print(" =>"); Serial.println(output);
//               
//        if (input>150 && input<200){//If the Bot is falling 
//          
//        if (output>0) //Falling towards front 
//        Forward(); //Rotate the wheels forward 
//        else if (output<0) //Falling towards back
//        Reverse(); //Rotate the wheels backward 
//        }
//        else //If Bot not falling
//        Stop(); //Hold the wheels still
//        
//    }
//
//    // reset interrupt flag and get INT_STATUS byte
//    mpuInterrupt = false;
//    mpuIntStatus = mpu.getIntStatus();
//
//    // get current FIFO count
//    fifoCount = mpu.getFIFOCount();
//
//    // check for overflow (this should never happen unless our code is too inefficient)
//    if ((mpuIntStatus & 0x10) || fifoCount == 1024)
//    {
//        // reset so we can continue cleanly
//        mpu.resetFIFO();
//        Serial.println(F("FIFO overflow!"));
//
//    // otherwise, check for DMP data ready interrupt (this should happen frequently)
//    }
//    else if (mpuIntStatus & 0x02)
//    {
//        // wait for correct available data length, should be a VERY short wait
//        while (fifoCount < packetSize) fifoCount = mpu.getFIFOCount();
//
//        // read a packet from FIFO
//        mpu.getFIFOBytes(fifoBuffer, packetSize);
//        
//        // track FIFO count here in case there is > 1 packet available
//        // (this lets us immediately read more without waiting for an interrupt)
//        fifoCount -= packetSize;
//
//        mpu.dmpGetQuaternion(&q, fifoBuffer); //get value for q
//        mpu.dmpGetGravity(&gravity, &q); //get value for gravity
//        mpu.dmpGetYawPitchRoll(ypr, &q, &gravity); //get value for ypr
//
//        input = ypr[1] * 180/M_PI + 180;
delay(300);
   
}

void Forward(int motorSpeed) //Code to rotate the wheel forward 
{
  // turn on motor A
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  // turn on motor B
  digitalWrite(in3, HIGH);
  digitalWrite(in4, LOW);

  // decelerate from maximum speed to zero
  for (int i = motorSpeed; i >= minSpeed;  i-=accelDecelStep)
  {
    analogWrite(enA, i);
    analogWrite(enB, i+rightLeftSpeedDifference);
    delay(accelDecelDelay);
  } 

  Serial.print("F: "); //Debugging information
  Serial.print(motorSpeed);
  Serial.print("  X: ");
  Serial.println(output); 
}

void Reverse(int motorSpeed) //Code to rotate the wheel Backward  
{
  // turn on motor A
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);  
  // turn on motor B
  digitalWrite(in3, LOW);
  digitalWrite(in4, HIGH); 
  
  // decelerate from maximum speed to zero
  for (int i = motorSpeed; i >= minSpeed; i-=accelDecelStep)
  {
    analogWrite(enA, i);
    analogWrite(enB, i+rightLeftSpeedDifference);
    delay(accelDecelDelay);
  } 
  Serial.print("R: ");
  Serial.print(motorSpeed);
  Serial.print("  X: ");
  Serial.println(output); 
}

void Stop() //Code to stop both the wheels
{
  digitalWrite(in1, LOW);
  digitalWrite(in2, LOW);  
  digitalWrite(in3, LOW);
  digitalWrite(in4, LOW);
  //Serial.print("S: ");
    //Serial.println(output); 
}
