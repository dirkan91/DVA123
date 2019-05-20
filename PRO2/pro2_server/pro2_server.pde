// Import networking
import processing.net.*;

// Setup the server variable
Server myServer;

// Set up variables for choices and previous choices
int choice = 0;
int prevchoice = 0;

// Variable used for reversing the image flow.
int revflag = 0;

// Size of resolution. Used in image rendering.
float resX=1080*0.65;
float resY=1527*0.65;
//int resX=540;
//int resY=764;
//int resX=648;
//int resY=917;
int cordX=1280/2;
int cordY=1024/2;

// Create image array
PImage[] img = new PImage[13];

// Used in array to track image selection
int counter=0;

// Runs once.
void setup() {
  //size(1080, 1527);
  //size(540,763);
  size(1280, 1024);
  frameRate(3);
  background(60);
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
  imageMode(CENTER);
  Client thisClient = myServer.available();
  // If the client is not null, and says something, save what it said in a
  // variable and count it.
  if (thisClient !=null) {
    String whatClientSaid = thisClient.readString();
    if (whatClientSaid != null) {
      // Stores previous choices if they are different
      // from the new choice.
      if (prevchoice != choice) {
        prevchoice = choice;
      }
      // Converts the data from the client to an integer "choice".
      choice = int(whatClientSaid);
      // Sets a flag for reversing the image flow if the new choice
      // is lower than the previous choice (for example, going from high
      // data rate to lower).
      if (choice < prevchoice) {
        revflag = 1;
      }
    }
  }
  // The following if statements determine what image to display depending
  // on the choice made and if the new choice is lower data rate or higher.
  if (choice == 1 && counter < 3 && revflag != 1) {
    image(img[counter],cordX,cordY,resX,resY);
    counter++;
    // Loops between three images to create the illusion of a movie.
    if (counter == 3) {
      counter = counter - 3;
    }
  }
  else if (choice == 2 && counter < 8 && revflag != 1) {
    image(img[counter],cordX,cordY,resX,resY);
    counter++;
    if (counter == 8) {
      counter = counter - 3;
    }
  }
  else if (choice == 3 && counter < 13 && revflag != 1) {
    image(img[counter],cordX,cordY,resX,resY);
    counter++;
    if (counter == 13) {
      counter = counter - 3;
    }
  }
  // Reverses the image flow if the reverse flag is set.
  if (counter > 0 && revflag == 1) {
    image(img[counter],cordX,cordY,resX,resY);
    counter--;
    if (choice == 2 && counter == 5) {
      revflag = 0;
    }
    else if (choice == 1 && counter == 0) {
      revflag = 0;
    }
  }
}
