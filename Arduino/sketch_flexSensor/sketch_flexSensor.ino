
const int flexPin1 = 4;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200); // Open serial monitor at 115200 baud to see ping results.


}

void loop() {
  // put your main code here, to run repeatedly:

int flexPosition1;

flexPosition1 = analogRead(flexPin1);

 Serial.print("Flex Pos: ");
  Serial.println(flexPosition1);
}
