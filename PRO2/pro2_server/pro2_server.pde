// Import networking
import processing.net.*;

// Setup the server variable
Server myServer;

int choice = 0;
int prevchoice = 0;
int choiceflag = 0;
int revflag = 0;
int resX=1080/2;
int resY=1527/2;
int counter=0;

// Create image array
PImage[] img = new PImage[13];

// Runs once.
void setup() {
  //size(1080, 1527);
  size(540,763);
  frameRate(1.5);
  background(255);
  // Initialise server.
  myServer = new Server(this, 5204, "127.0.0.1");
  
  // Load all the images into the array
  img[0] = loadImage("Bild1.jpg");
  img[1] = loadImage("Bild2.jpg");
  img[2] = loadImage("Bild3.jpg");
  img[3] = loadImage("Bild4.jpg");
  img[4] = loadImage("Bild5.jpg");
  img[5] = loadImage("Bild6.jpg");
  img[6] = loadImage("Bild7.jpg");
  img[7] = loadImage("Bild8.jpg");
  img[8] = loadImage("Bild9.jpg");
  img[9] = loadImage("Bild10.jpg");
  img[10] = loadImage("Bild11.jpg");
  img[11] = loadImage("Bild12.jpg");
  img[12] = loadImage("Bild13.jpg");
}

// Runs as a loop
void draw() {
  Client thisClient = myServer.available();
  // If the client is not null, and says something, save what it said in a
  // variable and count it.
  if (thisClient !=null) {
    String whatClientSaid = thisClient.readString();
    if (whatClientSaid != null) {
      // Splits the string the client sent, converts it to an integer and stores
      // them in an integer array.
      if (prevchoice != choice) {
        prevchoice = choice;
      }
      choice = int(whatClientSaid);
      if (choice < prevchoice) {
        revflag = 1;
      }
    }
  }
  if (choice == 1 && counter < 3 && revflag != 1) {
    image(img[counter],0,0,resX,resY);
    counter++;
    if (counter == 3) {
      counter = counter - 3;
    }
  }
  else if (choice == 2 && counter < 8 && revflag != 1) {
    image(img[counter],0,0,resX,resY);
    counter++;
    if (counter == 8) {
      counter = counter - 3;
    }
  }
  else if (choice == 3 && counter < 13 && revflag != 1) {
    image(img[counter],0,0,resX,resY);
    counter++;
    if (counter == 13) {
      counter = counter - 3;
    }
  }
  
  if (counter > 0 && revflag == 1) {
    image(img[counter],0,0,resX,resY);
    counter--;
    if (choice == 2 && counter == 5) {
      revflag = 0;
    }
    else if (choice == 1 && counter == 0) {
      revflag = 0;
    }
  }
}
