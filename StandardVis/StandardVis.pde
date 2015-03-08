/*
Tangible Interactive Computing IA2 (Standard Visualizer)
Brian Brubach 
 
This program read input from the Arduino Leonardo and graphs it 
temporally.

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
  
 textSize(12);
 for (int i = 1; i < 5; i++) {
   text((int)map((i*height)/6, 0, (5*height)/6, 0, 1023), 
     10, height-(((i+1)*height)/6));
   stroke(60,60,60);
   line(40, height-(((i+1)*height)/6), 
     width, height-(((i+1)*height)/6));
 }
 }
 void draw () {
 // everything happens in the serialEvent()
 }
 
 void serialEvent (Serial myPort) {
 // get the ASCII string:
 String inString = myPort.readStringUntil('\n');
 
 if (inString != null) {
   // trim off any whitespace:
   inString = trim(inString);
   
   // parse input from the arduino
   String[] analogDigital = split(inString, ';');
   String[] aIn = split(analogDigital[0], ',');
   String[] digIn = split(analogDigital[1], ',');

   float[] inByte = new float[6];
   float[] sizedInByte = new float[6];
   int[] inDigit = new int[14];

   // convert analog input to floats mapped to screen height and
   // digital input to ints
   for (int i = 0; i < 5; i++) {
     inByte[i] = float(aIn[i]);
     sizedInByte[i] = map(inByte[i], 0, 1023, height/6, height);
   }
 
   for (int i = 0; i < 14; i++) {
     inDigit[i] = int(digIn[i]);
   }
 
 
 // draw the line:
 stroke(200,75,100);
 line(xPos, height - sizedInByte[0] + 1, 
   xPos, height - sizedInByte[0] - 1);
 
 stroke(75,100,220);
 line(xPos, height - sizedInByte[1] + 1, 
   xPos, height - sizedInByte[1] - 1);
 
// stroke(220,180,0);
// line(xPos, height - sizedInByte[2] + 1, 
//   xPos, height - sizedInByte[2] - 1);
  
  if (inDigit[0] > 0.8) {
    stroke(255,255,255);
    line(xPos, height - height/24, xPos, height - (3*height)/24);
  }
  
  if (inDigit[1] > 0.8) {
    stroke(220,180,0);
    line(xPos, height - (4*height)/24, xPos, height - (7*height)/24);
  }
  
//  if (inDigit[2] > 0.8) {
//    stroke(75,200,100);
//    line(xPos, height - (8*height)/24, xPos, height - (11*height)/24);
//  }
//  
//  if (inDigit[3] > 0.8) {
//    stroke(75,75,220);
//    line(xPos, height - (12*height)/24, xPos, height - (15*height)/24);
//  }
//  
  
 // at the edge of the screen, go back to the beginning:
 if (xPos >= width) {
 xPos = 0;
 background(0); 
 for (int i = 1; i < 5; i++) {
   text((int)map((i*height)/6, 0, (5*height)/6, 0, 1023), 
     10, height-(((i+1)*height)/6));
   stroke(60,60,60);
   line(40, height-(((i+1)*height)/6), 
     width, height-(((i+1)*height)/6));
 }
 
 } 
 else {
 // increment the horizontal position:
 xPos++;
 }
 }
 }
 


