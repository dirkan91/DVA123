// Import networking
import processing.net.*;

// Specify the listening port.
int port=5204;

// Setup the server variable
Server myServer;

int choice = 0;
int resX=1080/2;
int resY=1527/2;
PImage img1, img2, img3, img4, img5, img6, img7, img8, img9, img10, img11, img12, img13;

// Runs once.
void setup() {
  //size(1080, 1527);
  size(540,764);
  background(255);
  // Initialise server.
  myServer = new Server(this, port, "127.0.0.1");
  
  img1 = loadImage("Bild1.jpg");
  img2 = loadImage("Bild2.jpg");
  img3 = loadImage("Bild3.jpg");
  img4 = loadImage("Bild4.jpg");
  img5 = loadImage("Bild5.jpg");
  img6 = loadImage("Bild6.jpg");
  img7 = loadImage("Bild7.jpg");
  img8 = loadImage("Bild8.jpg");
  img9 = loadImage("Bild9.jpg");
  img10 = loadImage("Bild10.jpg");
  img11 = loadImage("Bild11.jpg");
  img12 = loadImage("Bild12.jpg");
  img13 = loadImage("Bild13.jpg");
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
      choice = int(whatClientSaid);
      if (choice != 0) {
        changeImage();
      }
    } 
  }
}

void changeImage() {
  switch (choice) {
    case 1:
      image(img1, 0, 0, resX, resY);
      break;
    case 2:
      image(img2, 0, 0, resX, resY);
      break;
    case 3:
      image(img3, 0, 0, resX, resY);
      break;
    case 4:
      image(img4, 0, 0, resX, resY);
      break;
    default:
      //background(255);
      //choice = 0;
      break;
  }
}

void loopImage() {
  
}
