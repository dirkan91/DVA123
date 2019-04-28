import processing.net.*;

int rect1X, rect1Y, rect2X, rect2Y, rect3X, rect3Y, rect4X, rect4Y;   // Position of square button
int rectSize = 140;     // Diameter of rect
color rect1Color, rect2Color, rect3Color, rect4Color, baseColor;
color rect1Highlight, rect2Highlight, rect3Highlight, rect4Highlight;
color currentColor1, currentColor2, currentColor3, currentColor4;
int rectOver = 0;
String rectChoice1 = "0";
String rectChoice2 = "0";
int squarespace = 80;
Client myClient;
int port = 5204;
String data;

void setup() {
  size(360, 640);  // Size must be the first statement
  // Set all color variables
  background(0,204,204);
  fill(145,245,245);
  int x=200;
  int y=80;
  rect(width/2-x/2, height/14, x, y);
  textSize(32);
  textAlign(CENTER, CENTER);
  fill(32,32,32);
  text("HÄNG MED", width/2, height/14+y/2);
  textSize(16);
  rect1Color = color(102,255,102);
  rect2Color = color(255,102,102);
  rect3Color = color(255,255,102);
  rect4Color = color(102,102,255);
  rect1Highlight = color(51,210,51);
  rect2Highlight = color(210,51,51);
  rect3Highlight = color(210,210,51);  
  rect4Highlight = color(51,51,210);
  
  currentColor1 = rect1Color;
  currentColor2 = rect2Color;
  currentColor3 = rect3Color;
  currentColor4 = rect4Color;
  // Set position of squares
  rect1X = width/2-rectSize/2-squarespace;
  rect1Y = height/2-rectSize/2-squarespace-5;
  rect2X = width/2-rectSize/2+squarespace;
  rect2Y = height/2-rectSize/2-squarespace-5;
  rect3X = width/2-rectSize/2-squarespace;
  rect3Y = height/2-rectSize/2+squarespace+5;
  rect4X = width/2-rectSize/2+squarespace;
  rect4Y = height/2-rectSize/2+squarespace+5;
  ellipseMode(CENTER);
  drawLine();
  // Connect to server
  myClient = new Client(this, "127.0.0.1", port);
  
}


void draw() { 
  update(mouseX, mouseY);
  drawRect();
  
  //myClient.write(rectChoice1);
  //myClient.write(rectChoice2);
  switch (rectOver) {
    case 1:
      fill(rect1Highlight);
      rect(rect1X, rect1Y, rectSize, rectSize);
      fill(0);
      text("JAG FÖRSTÅR", rect1X+rectSize/2,rect1Y+rectSize/2);
      break;
    case 2:
      fill(rect2Highlight);
      rect(rect2X, rect2Y, rectSize, rectSize);
      fill(0);
      text("JAG FÖRSTÅR EJ", rect2X+rectSize/2, rect2Y+rectSize/2);
      break;
    case 3:
      fill(rect3Highlight);
      rect(rect3X, rect3Y, rectSize, rectSize);
      fill(0);
      text("GÅ VIDARE", rect3X+rectSize/2, rect3Y+rectSize/2);
      break;
    case 4:
      fill(rect4Highlight);
      rect(rect4X, rect4Y, rectSize, rectSize);
      fill(0);
      text("UTVECKLA", rect4X+rectSize/2, rect4Y+rectSize/2);
      break;
    default:
      break;
  }
}

void update(int x, int y) {
  if ( overRect(rect1X, rect1Y, rectSize, rectSize) ) {
    rectOver = 1;
  }
  else if ( overRect(rect2X, rect2Y, rectSize, rectSize) ) {
    rectOver = 2;
  }
  else if ( overRect(rect3X, rect3Y, rectSize, rectSize) ) {
    rectOver = 3;
  }
  else if ( overRect(rect4X, rect4Y, rectSize, rectSize) ) {
    rectOver = 4;
  }
  else {
    rectOver = 0; 
  }
}

void mousePressed() {
  if (rectOver == 1 || rectOver == 2) {
    if (rectOver == 1) {
      rectChoice1 = "1";
      currentColor1 = rect1Highlight;
      fill(currentColor1);
      rect(rect1X, rect1Y, rectSize, rectSize);
      currentColor2 = rect2Color;
    }
    if (rectOver == 2) {
      rectChoice1 = "2";
      currentColor2 = rect2Highlight;
      fill(currentColor2);
      rect(rect2X, rect2Y, rectSize, rectSize);
      currentColor1 = rect1Color;
    }
    
  }
  else if (rectOver == 3 || rectOver == 4) {
    if (rectOver == 3) {
      rectChoice2 = "3";
      currentColor3 = rect3Highlight;
      fill(currentColor3);
      rect(rect3X, rect3Y, rectSize, rectSize);
      currentColor4 = rect4Color;
    }
    if (rectOver == 4) {
      rectChoice2 = "4";
      currentColor4 = rect4Highlight;
      fill(currentColor4);
      rect(rect4X, rect4Y, rectSize, rectSize);
      currentColor3 = rect3Color;
    }
  }
  
  else {
    rectChoice1 = "0";
    rectChoice2 = "0";
    currentColor1 = rect1Color;
    currentColor2 = rect2Color;
    currentColor3 = rect3Color;
    currentColor4 = rect4Color;
  }
  data = rectChoice1 + " " + rectChoice2;
  if (rectChoice1.equals("0") == false && rectChoice2.equals("0") == false) {
    myClient.write(data);
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void drawRect() {
  // Fill squares with color and text
  fill(currentColor1);
  rect(rect1X, rect1Y, rectSize, rectSize);
  fill(0);
  text("JAG FÖRSTÅR", rect1X+rectSize/2,rect1Y+rectSize/2);
  fill(currentColor2);
  rect(rect2X, rect2Y, rectSize, rectSize);
  fill(0);
  text("JAG FÖRSTÅR EJ", rect2X+rectSize/2, rect2Y+rectSize/2);
  fill(currentColor3);
  rect(rect3X, rect3Y, rectSize, rectSize);
  fill(0);
  text("GÅ VIDARE", rect3X+rectSize/2, rect3Y+rectSize/2);
  fill(currentColor4);
  rect(rect4X, rect4Y, rectSize, rectSize);
  fill(0);
  text("UTVECKLA", rect4X+rectSize/2, rect4Y+rectSize/2);
}

void drawLine() {
  // Draw lines
  strokeWeight(3);
  line(50, height/2, width-50, height/2);
  line(width/2-6, rect1Y+rectSize/2, width/2+6, rect1Y+rectSize/2);
  line(width/2-6, rect3Y+rectSize/2, width/2+6, rect3Y+rectSize/2);
  strokeWeight(1);
}
