import processing.serial.*;

Serial myPort; // The serial port
int xPos = 1; // horizontal position of the graph 

//Variables to draw a continuous line.
int lastxPos = 1;
int lastheight = 0;
float inByte;

PrintWriter output;

boolean newVal = false;

void setup() {

   output = createWriter("positions.txt");
   size(600, 400);
   println((Object[]) Serial.list());

   myPort = new Serial(this, Serial.list()[0], 115200); //
   myPort.bufferUntil('\n');

   background(0);
   stroke(127, 34, 255);

}

void draw() {

   myPort.write('0'); //send a 1

   if (keyPressed == true) {
      output.flush(); // Writes the remaining data to the file
      output.close(); // Finishes the file
      exit();
   }

   if (newVal) {

      line(lastxPos, lastheight, xPos, height - inByte);
      lastxPos = xPos;
      lastheight = int(height - inByte);

      // at the edge of the window, go back to the beginning:
      if (xPos >= width) {
         xPos = 0;
         lastxPos = 0;
         background(0); //Clear the screen.
      } else {
         // increment the horizontal position:
         xPos++;
      }

      newVal = false;

   }

}

void serialEvent(Serial myPort) {

   // get the ASCII string:
   String inString = myPort.readStringUntil('\n');
   println(inString);
   if (inString != null) {
      inString = trim(inString); // trim off whitespaces.
      inByte = float(inString); // convert to a number.
      inByte = map(inByte, 0, 1023, 0, height); //map to the screen height.
      newVal = true;
   }
}