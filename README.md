# IA2-Brian

This repo contains two separate processing visualizers for Arduino Leonardo input and various related files.

1. The StandardIn Arduino code is needed to read and print input from the Arduino.
2. The StandardVis processing code is a temporal graph of the analog and digital inputs to an Arduino.
3. The ArduinoInkpen processing code is a rainbow inkpen etch-a-sketch which can be controlled by two potentiometers 
   going to analog inputs on the Arduino.
4. The pictures StandardPic.tiff and Inkpen.tiff show examples of these programs.


## Known Problems
When resizing the window for the standard visualizer, the backgound info (ie graph labels) isn't redrawn until the 
x-value resets. This only takes a few seconds.

## About
Originally written for my CMSC838f Tangible Interactive Computing course at the University of Maryland

http://cmsc838f-s15.wikispaces.com/

