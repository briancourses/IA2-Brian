

/*
Tangible Interactive Computing IA2 (Rainbow Inkpen Etch-a-sketch)
Brian Brubach 
 
This program reads analog input from two potentiometers and draws 
a line like an etch-a-sketch. The line has an inkpen style which is 
thicker when the pen moves slowly. It also changes color depending 
on which part of the window you're drawing in.

Input from the Arduino is of the form:
analog0, analog1, ..., analog5; digital0, digital1, ..., digital13
with analog and digital separated by a semi-colon.

The code below borrows lots of sample code from:
http://arduino.cc/en/tutorial/graph
https://processing.org/examples/
*/

 
 import processing.serial.*;
 
 Serial myPort;        // The serial port
 int xPos = 1;         // horizontal position of the graph
 int lastX = 0;
 int lastY = 0;
 
 void setup () {
 // set the window size:
 size(400, 300);
 if (frame != null) {
    frame.setResizable(true);
 }  
 
 // List all the available serial ports
 println(Serial.list());
 // I know that the first port in the serial list on my mac
 // is always my  Arduino, so I open Serial.list()[0].
 // Open whatever port is the one you're using.
 myPort = new Serial(this, Serial.list()[5], 9600);
 // don't generate a serialEvent() unless you get a newline character:
 myPort.bufferUntil('\n');
 // set inital background:
 background(0);
 }

 
 void serialEvent (Serial myPort) {
 // get the ASCII string:
 String inString = myPort.readStringUntil('\n');
 
 if (inString != null) {
   // trim off any whitespace:
   inString = trim(inString);
   
   // parse input from the arduino
   String[] aIn = split(inString, ',');
   float[] inByte = new float[6];
   float[] sizedInByte = new float[6];
    
   // convert analog input to floats mapped to screen height and
   // digital input to ints
   for (int i = 0; i < 5; i++) {
     inByte[i] = float(aIn[i]);
     sizedInByte[i] = map(inByte[i], 0, 1023, 0, height);
   }
 
 
 // draw the line:
 int redColor = (int)map(inByte[0], 0, 1023, 55, 255);
 int greenColor = (int)map(inByte[1], 0, 1023, 55, 255);

 float noise = inByte[1] - inByte[2];
 if (abs(noise) > 40)
   noise = 0;
 int potX = (int)map(inByte[0], 0, 1023, 0, width) + (int)noise/2;
 int potY = (int)map(inByte[1], 0, 1023, 0, height) + (int)noise; 
// int potX = (int)map(inByte[0], 0, 1023, 0, width);
// int potY = (int)map(inByte[1], 0, 1023, 0, height); 
 float diff = sqrt(sq(potX-lastX) + sq(potY-lastY));
 if (diff < 1)
   diff = 1;

 stroke(redColor,greenColor,abs(greenColor - redColor));
 fill(redColor,greenColor,abs(greenColor - redColor)); 
 ellipse(potX, height - potY, 10/diff, 10/diff);
 lastX = potX - (int)noise/2;
 lastY = potY - (int)noise;
// lastX = potX;
// lastY = potY;
 
 }
 }
 






