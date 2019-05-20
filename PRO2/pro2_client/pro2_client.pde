
// Import networking
import processing.net.*;
import processing.serial.*;

// Variables for rectangle coordinates and sizes.
int rect1X, rect1Y, rect2X, rect2Y, rect3X, rect3Y;
int rectSizeX = 200;
int rectSizeY = 50;
int squarespace = 80;

// Initialise all color variables
color rect1Color, rect2Color, rect3Color, baseColor;
color rect1Highlight, rect2Highlight, rect3Highlight;
color currentColor1, currentColor2, currentColor3;

// Setup client and data variable.
Client myClient;
int port = 5204;
String choice = "0";
String val;

Serial myPort;

// Initialise variable used if the mouse is over the squares (rectangle).
// Changes value depending on which square the mouse hovers over. (1-4)
int rectOver = 0;

// The void setup function runs once.
void setup() {
  size(360, 640);  // Size must be the first statement
  background(60);
  
  // Text and color variables
  textAlign(CENTER, CENTER);
  textSize(16);
  rect1Color = color(120); // GREEN
  rect2Color = color(120); // YELLOW
  rect3Color = color(120); // RED
  rect1Highlight = color(51,210,51); // DARK GREEN
  rect2Highlight = color(210,210,51);// DARK YELLOW
  rect3Highlight = color(210,51,51); // DARK RED
  currentColor1 = rect1Color;
  currentColor2 = rect2Color;
  currentColor3 = rect3Color;
  
  // Rectangle coordinates
  rect1X = width/2-rectSizeX/2;
  rect1Y = height/2-rectSizeY/2-rectSizeY-20;
  rect2X = width/2-rectSizeX/2;
  rect2Y = height/2-rectSizeY/2;
  rect3X = width/2-rectSizeX/2;
  rect3Y = height/2-rectSizeY/2+rectSizeY+20;
  // Connect to server
  myClient = new Client(this, "127.0.0.1", port);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

// The voice draw function is a loop by default. Runs continously.
void draw() {
  update(); // Tracks mouse movement
  drawRect(); // Draws rectangles
  switch (rectOver) {
    case 1:
      fill(rect1Highlight);
      rect(rect1X, rect1Y, rectSizeX, rectSizeY);
      fill(0);
      text("LÅG DATATAKT", rect1X+rectSizeX/2,rect1Y+rectSizeY/2);
      break;
    case 2:
      fill(rect2Highlight);
      rect(rect2X, rect2Y, rectSizeX, rectSizeY);
      fill(0);
      text("MELLANHÖG DATATAKT", rect2X+rectSizeX/2, rect2Y+rectSizeY/2);
      break;
    case 3:
      fill(rect3Highlight);
      rect(rect3X, rect3Y, rectSizeX, rectSizeY);
      fill(0);
      text("HÖG DATATAKT", rect3X+rectSizeX/2, rect3Y+rectSizeY/2);
      break;
    default:
      break;
  }
  if (choice.equals("0") == false) {
    myClient.write(choice);
    myPort.write(choice);
    choice = "0";
  }
  if ( myPort.available() > 0) {  // If data is available,
  val = myPort.readStringUntil('\n');         // read it and store it in val
  } 
println(val); //print it out in the console
}

// Changes the value of the rectOver variable depending on which square the 
// mouse hovers over.
void update() {
  if ( overRect(rect1X, rect1Y, rectSizeX, rectSizeY) ) {
    rectOver = 1;
  }
  else if ( overRect(rect2X, rect2Y, rectSizeX, rectSizeY) ) {
    rectOver = 2;
  }
  else if ( overRect(rect3X, rect3Y, rectSizeX, rectSizeY) ) {
    rectOver = 3;
  }
  else {
    rectOver = 0; 
  }
}


// If mouse is pressed over a rectangle, color it with the darker color,
// Also, deselects other rectangles.
void mousePressed() {
  if (rectOver == 1 || rectOver == 2 || rectOver == 3) {
    if (rectOver == 1) {
      choice = "1";
      currentColor1 = rect1Highlight;
      fill(currentColor1);
      rect(rect1X, rect1Y, rectSizeX, rectSizeY);
      currentColor2 = rect2Color;
      currentColor3 = rect3Color;
    }
    if (rectOver == 2) {
      choice = "2";
      currentColor2 = rect2Highlight;
      fill(currentColor2);
      rect(rect2X, rect2Y, rectSizeX, rectSizeY);
      currentColor1 = rect1Color;
      currentColor3 = rect3Color;
    }
    if (rectOver == 3) {
      choice = "3";
      currentColor3 = rect3Highlight;
      fill(currentColor3);
      rect(rect3X, rect3Y, rectSizeX, rectSizeY);
      currentColor1 = rect1Color;
      currentColor2 = rect2Color;
    }
  }
}

// Function for figuring out if the mouse is above a rectangle 
// or not. Tracks mouse movement.
boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void drawRect() {
  // Draw squares and fill them with color and text. The fill function fills
  // everything below it, therefore several fill functions need to be used to
  // guarantee correct color usage.
  fill(currentColor1);
  rect(rect1X, rect1Y, rectSizeX, rectSizeY);
  fill(0);
  text("LÅG DATATAKT", rect1X+rectSizeX/2,rect1Y+rectSizeY/2);
  fill(currentColor2);
  rect(rect2X, rect2Y, rectSizeX, rectSizeY);
  fill(0);
  text("MELLANHÖG DATATAKT", rect2X+rectSizeX/2, rect2Y+rectSizeY/2);
  fill(currentColor3);
  rect(rect3X, rect3Y, rectSizeX, rectSizeY);
  fill(0);
  text("HÖG DATATAKT", rect3X+rectSizeX/2, rect3Y+rectSizeY/2);
}
