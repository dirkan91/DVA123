// This is the server part of the system.
// It only processes incoming data and counts the number of previously connected
// clients.

// Import networking
import processing.net.*;

// Specify the listening port.
int port=5204;

// Variables to store choices made by clients
int choice1;
int choice2;

// Used to count clients
int clientcounter;

// Used to count choices
int choicecounter1;
int choicecounter2;

// Size of text box
int rectX=200;
int rectY=80;

// Setup the server variable
Server myServer;

// Runs once.
void setup() {
  size(960, 720);  // Size of interface
  background(0,204,204);   // Clear the screen with a background.

  // Coordinates for text
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

  // Initialise server.
  myServer = new Server(this, port, "127.0.0.1");
}

// Runs as a loop
void draw() {
  fill(145,245,245);
  rect(width/2-rectX/2, height-height/8, rectX, rectY);
  fill(32,32,32);
  textAlign(CENTER,CENTER);
  textSize(20);
  text("ANTAL", width/2, height-height/8+20);
  // Lists number of choices made by number of clients.
  text(str(clientcounter), width/2, height-height/8+50);
  drawCircles(); // Draws the circles.
  // Get the next available client
  Client thisClient = myServer.available();
  // If the client is not null, and says something, save what it said in a
  // variable and count it.
  if (thisClient !=null) {
    String whatClientSaid = thisClient.readString();
    if (whatClientSaid != null) {
      clientcounter++;
      // Splits the string the client sent, converts it to an integer and stores
      // them in an integer array.
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

// Runs one. Draws the circles on screen.
void drawCircles() {
  fill(250);
  int circlewidth=45;
  int circlecolumns=12;
  int circlerows=3;
  // Position of the circle
  int circX=50;
  int circY=50;
  int circlecounter1=0;
  int circlecounter2=0;

  // Used to get the coordinates right in the loop below.
  float offsetX = (width/2)-((circlecolumns*circX)/2);
  float offsetY1 = 200;
  float offsetY2 = 400;
  // Two for loops draws circles. Draws the vertical three first, then jumps to
  // the next circle in the column and repeats. Also colors them based on
  // choices made by the clients. The color is based on the proportion of
  // the choice made. For example, if one quarter have made the choice
  // "JAG FÖRSTÅR", then one quarter will be filled green, the rest red.
  for (float i = circX+offsetX; i < (circX*circlecolumns)+circX+offsetX; i = i+circX) {
    for (float j = circY+offsetY1; j <= circY*circlerows+offsetY1; j = j+circY) {
      circlecounter1++;
      // Starts off with white circles if no choices have been made by clients.
      if (clientcounter == 0) {
        fill(250);
      }
      else if (choicecounter1/float(clientcounter) >= float(circlecounter1)/(circlecolumns*circlerows)) {
        fill(102,255,102);
      }
      else {
        fill(255,102,102);
      }
      circle(i-circX/2, j, circlewidth);
      
    }
  }
  // Same as above, but for the choices "GÅ VIDARE" and "UTVECKLA"
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
}
