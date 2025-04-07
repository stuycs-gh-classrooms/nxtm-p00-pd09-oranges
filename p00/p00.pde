int NUM_ORBS = 10;
int MIN_SIZE = 10;
int MAX_SIZE = 60;
float MIN_MASS = 10;
float MAX_MASS = 100;
float G_CONSTANT = 0.1;
float D_COEF = 1;

int SPRING_LENGTH = 50;
float  SPRING_K = 0.005;
float E_CONSTANT = 100;;

boolean comboSim;
int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int SPRING = 3;
int DRAGF = 4;
int ELECTRIC = 5;
int RANDOM = 6;
boolean[] toggles = new boolean[7];
String[] modes = {"Moving", "Bounce", "Gravitational Orbit", "Spring", "Drag", "Electric", "Random Orbs"};

int MASS = 0;
int CHARGE = 1;
int SPEED = 2;
boolean[] otherTogs = new boolean[3];
String[] otherModes = {"mass", "charge", "speed"};

FixedOrb earth;
OrbList slinky;

void setup() {
  size(800, 800);
  earth = new FixedOrb(width/2, height/2, 2*MAX_SIZE, 2*MAX_MASS);
  comboSim = false;
  slinky = new OrbList();
  background(255);
}//setup


void draw() {
  background(255);
  displayMode();
  displayOtherToggles();
  writeControls();
  slinky.display();
  if (toggles[MOVING]) {
    
    if (toggles[GRAVITY]) {
      earth.display();
      slinky.applyGravity(earth, G_CONSTANT);
    }
    
    if (toggles[SPRING]) {
      slinky.applySprings(SPRING_LENGTH, SPRING_K);
    }
    
    if (toggles[DRAGF]) {
      slinky.applyDragForce(D_COEF);
    }
    
    if (toggles[ELECTRIC]) {
      slinky.applyElectricForce(E_CONSTANT);
    }
    
    combinationSim(comboSim);
    slinky.run(toggles[BOUNCE]);
    slinky.displayMasses(otherTogs[MASS]);
    slinky.displayCharges(otherTogs[CHARGE]);
    slinky.displayVelocities(otherTogs[SPEED]);
  }
  
  //Pertaining to other toggles: mass and charge, where the user can view those values on each orb. 
  if (otherTogs[MASS] && (toggles[GRAVITY] || comboSim )) {
    earth.displayMass();
  }
}//draw

void combinationSim(boolean combo) {
  if (combo) {
      toggles[GRAVITY] = toggles[SPRING] = toggles[DRAGF] = true;
      slinky.applyGravity(earth, G_CONSTANT);
      slinky.applySprings(SPRING_LENGTH, SPRING_K);
      slinky.applyDragForce(D_COEF);
    } else {
      toggles[GRAVITY] = toggles[SPRING] = toggles[DRAGF] = false;
    }
}
  
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
    NUM_ORBS = 8;
    toggles[GRAVITY] = !toggles[GRAVITY];
    slinky.populate(NUM_ORBS, toggles[RANDOM]);
    
  }
  if (key == '2') {
    NUM_ORBS = 5;
    toggles[SPRING] = !toggles[SPRING];
    slinky.populate(NUM_ORBS, toggles[RANDOM]);

  }
  if (key == '3') {
    NUM_ORBS = 10;
    toggles[DRAGF] = !toggles[DRAGF];
    slinky.dragPopulate(NUM_ORBS, toggles[RANDOM]);

  }
  if (key == '4') {
    NUM_ORBS = 2;
    toggles[ELECTRIC] = !toggles[ELECTRIC];
    slinky.electricityPopulate(NUM_ORBS, toggles[RANDOM]);

  }
  if (key == '5') {
    NUM_ORBS = 3;
    comboSim = !comboSim;
    slinky.dragPopulate(NUM_ORBS, toggles[RANDOM]);
  }
  
  if (key == 'm') {
    otherTogs[MASS] = !otherTogs[MASS];
  }
  if (key == 'q') {
    otherTogs[CHARGE] = !otherTogs[CHARGE];
  }
  if (key == 'v') {
    otherTogs[SPEED] = !otherTogs[SPEED];
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

void displayOtherToggles() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int spacing = 20;
  int y = 50;
  for (int i = 0; i < otherTogs.length; i++) {
    if (otherTogs[i]) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    float w = textWidth("view " + otherModes[i]);
    rect(0, y, w+5, spacing);
    fill(0);
    text("view " + otherModes[i], 0, y+2);
    y+=spacing;
  }
}

void writeControls() {
  textSize(15);
  text("Press-->SPACE:moving, 0:bounce, 1:Gravitational sim, 2:Spring sim, 3:Drag sim, 4:Electricity sim, 5:Combo sim, 6:Random Orbs", 0, height - 30);
  text("m: mass, q: charge, v: speed, = or +: add Orb, -/click an Orb to remove Orb", 0, height - 15);
}
  
