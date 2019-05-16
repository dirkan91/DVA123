
// Import networking
import processing.net.*;

// Setup client and data variable.
Client myClient;
int port = 5204;
String choice;

// The void setup function runs once.
void setup() {
  size(360, 640);  // Size must be the first statement
  background(255);
  // Connect to server
  myClient = new Client(this, "127.0.0.1", port);
  choice = "0";
}

// The voice draw function is a loop by default. Runs continously.
void draw() {
  if (choice.equals("0") == false); {
    choice = "0";
  }
}

void keyPressed() {
  if (key >= '1' && key <= '9') {
    choice = str(key);
    myClient.write(choice);
  }
  else
    choice = "0";
}
