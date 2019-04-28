import processing.net.*;
int port=5204;
int test=0;
int choice1;
int choice2;
int stringindex;
int clientcounter;
int choicecounter1;
int choicecounter2;
int rectX=200;
int rectY=80;
Server myServer;

void setup() {
  size(960, 720);  // Size must be the first statement
  background(0,204,204);   // Clear the screen with a white background.

  int textX=170;
  int textY=300;
  fill(145,245,245);
  rect(width/2-rectX/2, height/8, rectX, rectY);
  
  textSize(32);
  textAlign(CENTER, CENTER);
  fill(32,32,32);
  text("HÄNG MED", width/2, height/8+rectY/2);
  textSize(20);
  text("ANTAL", width/2, height-height/8+20);
  textAlign(RIGHT, CENTER);
  text("JAG FÖRSTÅR", textX, textY); 
  text("GÅ VIDARE", textX, textY+200); 
  textAlign(LEFT, CENTER);
  text("JAG FÖRSTÅR EJ", width-textX, textY); 
  text("UTVECKLA", width-textX, textY+200); 
  fill(255);
  strokeWeight(3);
  line(200, 400, width-200, 400);
  strokeWeight(1);
  myServer = new Server(this, port, "127.0.0.1");
  
}

void draw() {
  fill(145,245,245);
  rect(width/2-rectX/2, height-height/8, rectX, rectY);
  fill(32,32,32);
  textAlign(CENTER,CENTER);
  textSize(20);
  text("ANTAL", width/2, height-height/8+20);
  text(str(clientcounter), width/2, height-height/8+50);
  drawCircles();
  // Get the next available client
  Client thisClient = myServer.available();
  // If the client is not null, and says something, display what it said
  if (thisClient !=null) {
    String whatClientSaid = thisClient.readString();
    if (whatClientSaid != null) {
      clientcounter++;
      int[] x = int(split(whatClientSaid, " "));
      choice1 = int(x[0]);
      if (choice1 == 1)
        choicecounter1++;
      choice2 = int(x[1]);
      if (choice2 == 3)
        choicecounter2++;


    } 
  }
}

void drawCircles() {
  fill(250);
  int circlewidth=45;
  int circlecolumns=12;
  int circlerows=3;
  int circX=50;
  int circY=50;
  int circlecounter1=0;
  int circlecounter2=0;
  //(int i = circX+offsetX; i < (circX*circlecolumns)+circX+offsetX; i = i+circX)
  //(int j = circY+200; j <= circY*circlerows+200; j = j+circY)
  float offsetX = (width/2)-((circlecolumns*circX)/2);
  float offsetY1 = 200;
  float offsetY2 = 400;
  for (float i = circX+offsetX; i < (circX*circlecolumns)+circX+offsetX; i = i+circX) {
    for (float j = circY+offsetY1; j <= circY*circlerows+offsetY1; j = j+circY) {
      circlecounter1++;
      if (clientcounter == 0) {
        fill(250);
      }
      //else if ((circlecounter1 < (float(circlecolumns)*circlerows)/clientcounter) && (choice1 == 1)) {
      else if (choicecounter1/float(clientcounter) >= float(circlecounter1)/(circlecolumns*circlerows)) {
        fill(102,255,102);
      }
      //else if ((circlecounter1 < (float(circlecolumns)*circlerows)/clientcounter) && (choice1 == 2)) {
      else {
        fill(255,102,102);
      }
      circle(i-circX/2, j, circlewidth);
      
    }
  }
  for (float l = circX+offsetX; l < (circX*circlecolumns)+circX+offsetX; l = l+circX) {
    for (float k = circY+offsetY2; k <= circY*circlerows+offsetY2; k = k+circY) {
      circlecounter2++;
      if (clientcounter == 0) {
        fill(250);
      }
      else if (choicecounter2/float(clientcounter) >= float(circlecounter2)/(circlecolumns*circlerows)) {
        fill(255,255,102);
      }
      else {
        fill(102,102,255);
      }
      circle(l-circX/2, k, circlewidth);
    }
  }
  //return circlecounter;
}
