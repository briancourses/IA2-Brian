/*
Tangible Interactive Computing IA2
Brian Brubach 

This code simply reads all of the Arduino Leonardo's input and prints it out 
in the form:
analog0, analog1, ..., analog5; digital0, digital1, ..., digital13
with analog and digital separated by a semi-colon.
*/


int aIn[6];
int digIn[14];

void setup() {
  Serial.begin(9600);
}

void loop() {
  
  for (int i = 0; i < 6; i++) {
    aIn[i] = analogRead(i);
  }
  
  for (int i = 0; i < 14; i++) {
    digIn[i] = digitalRead(i);
  }

  String printOut = String(aIn[0]) + "," + String(aIn[1]) 
    + "," + String(aIn[2]) + "," + String(aIn[3]) 
    + "," + String(aIn[4]) + "," + String(aIn[5])//;
    + ";" + String(digIn[0]) + "," + String(digIn[1])
    + "," + String(digIn[2]) + "," + String(digIn[3])
    + "," + String(digIn[4]) + "," + String(digIn[5])
    + "," + String(digIn[6]) + "," + String(digIn[7])
    + "," + String(digIn[8]) + "," + String(digIn[9])
    + "," + String(digIn[10]) + "," + String(digIn[11])
    + "," + String(digIn[12]) + "," + String(digIn[13]);
    
  Serial.println(printOut);
  delay(5);
}
