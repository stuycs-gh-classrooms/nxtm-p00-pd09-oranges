/* ===================================
 Keyboard commands:
 1: Create a new list of orbs in a line.
 2: Create a new list of random orbs.
 =: add a new node to the front of the list
 -: remove the node at the front
 SPACE: Toggle moving on/off
 g: Toggle earth gravity on/off
 
 Mouse Commands:
 mousePressed: if the mouse is over an
 orb, remove it from the list.
 =================================== */


int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 1;
float D_COEF = 0.1;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;
float CURRENT;
boolean gravSim, springSim, dragSim, magneticSim, comboSim;
int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int SPRING = 3;
int DRAGF = 4;
int MAGNETIC = 5;

boolean[] toggles = new boolean[6];
String[] modes = {"Moving", "Bounce", "Gravity", "Spring", "Drag", "Magnetic"};

String[] sims = {"Gravitational Orbit", "Spring", "Drag", "Magnetic Field", "Combination"};
int currentSim;
  
FixedOrb earth;

OrbList slinky;

void setup() {
  size(1000, 1000);
  CURRENT = 15;// Unit is made up Amperes.
  earth = new FixedOrb(width/2, height/2, 2*MAX_SIZE, 2*MAX_MASS);
  gravSim = false;
  springSim = false;
  dragSim = false;
  magneticSim = false;
  comboSim = false;
  slinky = new OrbList();
  slinky.populate(NUM_ORBS, true);
}//setup


void draw() {
  background(255);
  displayMode();
  slinky.run(toggles[BOUNCE]);
  if (toggles[MOVING]) {
    if (gravSim) {
      currentSim = 0;
      earth.display();
      slinky.applyGravity(earth, G_CONSTANT);
    }
    if (springSim) {
      currentSim = 1;
      slinky.applySprings(SPRING_LENGTH, SPRING_K);
    }
    if (dragSim) {
      currentSim = 2;
      slinky.applyDragForce(D_COEF);
    }
    if (magneticSim) {
      currentSim = 3;
    }
    if (comboSim) {
      currentSim = 4;
      slinky.applyGravity(earth, G_CONSTANT);
      slinky.applySprings(SPRING_LENGTH, SPRING_K);
      slinky.applyDragForce(D_COEF);
    }
  }
}//draw
  
void mousePressed() {
  OrbNode selected = slinky.getSelected(mouseX, mouseY);
  if (selected != null) {
    slinky.removeNode(selected);
  }
}//mousePressed

void keyPressed() {
  if (key == ' ') {
    toggles[MOVING] = !toggles[MOVING];
  }
  if (key == 'b') {
    toggles[BOUNCE] = !toggles[BOUNCE];
  }
  if (key == '=' || key =='+') {
    slinky.addFront(new OrbNode());
  }
  if (key == '-') {
    slinky.removeFront();
  }
  if (key == '8') {
    slinky.populate(NUM_ORBS, true);
  }
  if (key == '9') {
    slinky.populate(NUM_ORBS, false);
  }
  //Simulations
  //------
  if (key == '1') {
    gravSim = !gravSim;
    toggles[GRAVITY] = !toggles[GRAVITY];
    
  }
  if (key == '2') {
    springSim = !springSim;
    toggles[SPRING] = !toggles[SPRING];
  }
  if (key == '3') {
    dragSim = !dragSim;
    toggles[DRAGF] = !toggles[DRAGF];
  }
  if (key == '4') {
    magneticSim = !magneticSim;
    toggles[MAGNETIC] = !toggles[MAGNETIC];
  }
  if (key == '5') {
    comboSim = !comboSim;
    toggles[GRAVITY] = !toggles[GRAVITY];
    toggles[SPRING] = !toggles[SPRING];
    toggles[MAGNETIC] = !toggles[MAGNETIC];
  }
  if (keyCode == UP) {
    CURRENT++;
  }
  if (keyCode == DOWN) {
    CURRENT--;
  }
}//keyPressed


void displayMode() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  //Forces
  int spacing = 20;
  int x = 0;
  for (int m=0; m<toggles.length; m++) {
    //set box color
    if (toggles[m]) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    float w = textWidth(modes[m]);
    rect(x, 20, w+5, spacing);
    fill(0);
    text(modes[m], x+2, 2);
    x+= w+5;
  }
  //Simulations
  /*
  text("Simulations", 0, 22);
  x = 0; 
  for (int s = 0; s < sims.length; s++) {
    if (s == currentSim) {
      fill(0, 0, 255);
    } else {
      fill(255, 0, 0);
    }
    
    float w = textWidth(sims[s]);
    rect(x, 100, w+5, spacing);
    fill(0);
    text(sims[s], x+2, 2);
    x += w+5;
  }
  */
  
  
}//display
