
#include <Adafruit_MotorShield.h>


// Create the motor shield object with the default I2C address
Adafruit_MotorShield AFMS = Adafruit_MotorShield(); 
//Set up for a 200step motor (NEMA 17)
Adafruit_StepperMotor *myMotor = AFMS.getStepper(200, 2);

void setup() {
  // put your setup code here, to run once:
  Serial.begin(57600);

  AFMS.begin();
  myMotor->setSpeed(500); //max 600
}

void loop() {
  // put your main code here, to run repeatedly:
  //Serial.println("Microstep steps");
  //myMotor->step(200, FORWARD, MICROSTEP); 
  //myMotor->step(200, BACKWARD, MICROSTEP);
  Serial.println("Frames");
  for (int i = 0; i < 8; i++) {
    myMotor->step(floor(200 / 8), BACKWARD, MICROSTEP);
    delay(1000);  
  }
}
