/* ===================================
 Keyboard commands:
 1: Gravitational
 2: Spring
 3: Drag
 4: Magnetic
 5: Combination
 6: Randomize the orbs
 =: add a new node to the front of the list
 -: remove the node at the front
 SPACE: Toggle moving on/off
 b: Toggle bounce on/off
 
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
boolean comboSim;
int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int SPRING = 3;
int DRAGF = 4;
int MAGNETIC = 5;
int RANDOM = 6;
boolean[] toggles = new boolean[7];
String[] modes = {"Moving", "Bounce", "Gravitational Orbit", "Spring", "Drag", "Magnetic Field", "Random Orbs"};
FixedOrb earth;

OrbList slinky;

void setup() {
  size(800, 800);
  CURRENT = 15;// Unit is made up Amperes.
  earth = new FixedOrb(width/2, height/2, 2*MAX_SIZE, 2*MAX_MASS);
  comboSim = false;
  slinky = new OrbList();
  slinky.populate(NUM_ORBS, true);
}//setup


void draw() {
  background(255);
  displayMode();
  slinky.run(toggles[BOUNCE]);
  if (toggles[MOVING]) {
    if (toggles[GRAVITY]) {
      earth.display();
      slinky.applyGravity(earth, G_CONSTANT);
    }
    if (toggles[SPRING]) {
      slinky.applySprings(SPRING_LENGTH, SPRING_K);
    }
    if (toggles[DRAGF]) {
      slinky.applyGravity(earth, G_CONSTANT);
      slinky.applyDragForce(D_COEF);
    }
    if (toggles[MAGNETIC]) {
    }
    if (comboSim) {
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
  if (key == '6') {
    toggles[RANDOM] = !toggles[RANDOM];
  }
  //Simulations
  //------
  if (key == '1') {
    toggles[GRAVITY] = !toggles[GRAVITY];
    slinky.populate(NUM_ORBS, toggles[RANDOM]);
    
  }
  if (key == '2') {
    toggles[SPRING] = !toggles[SPRING];
    slinky.populate(NUM_ORBS, toggles[RANDOM]);

  }
  if (key == '3') {
    toggles[DRAGF] = !toggles[DRAGF];
    slinky.populate(NUM_ORBS, toggles[RANDOM]);

  }
  if (key == '4') {
    toggles[MAGNETIC] = !toggles[MAGNETIC];
    slinky.populate(NUM_ORBS, toggles[RANDOM]);

  }
  if (key == '5') {
    comboSim = !comboSim;
    toggles[GRAVITY] = !toggles[GRAVITY];
    toggles[SPRING] = !toggles[SPRING];
    toggles[DRAGF] = !toggles[DRAGF];
    slinky.populate(NUM_ORBS, toggles[RANDOM]);
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
}//display
