int MOVING = 0;
int BOUNCE = 1;
int GRAVITY = 2;
int DRAGF = 3;
int Customs = 4;
boolean[] toggles = new boolean[5];
String[] modes = {"Moving", "Bounce", "Gravity", "Drag", "Custom"};

void setup() {
  size(600, 600);
}

void draw() {
  displayMode();
  if (toggles[MOVING]) {
    if (toggles[GRAVITY]) {
    }
    if (toggles[DRAGF]) {
    }
    //slinky.run(toggles[BOUNCE]);
  }
}

void displayMode() {
  textAlign(LEFT, TOP);
  textSize(20);
  noStroke();
  int spacing = 85;
  int x = 0;

  for (int m=0; m<toggles.length; m++) {
    //set box color
    if (toggles[m]) {
      fill(0, 255, 0);
    } else {
      fill(255, 0, 0);
    }

    float w = textWidth(modes[m]);
    rect(x, 0, w+5, 20);
    fill(0);
    text(modes[m], x+2, 2);
    x+= w+5;
  }
}//display

void keyPressed() {
  if (key == ' ') {
    toggles[MOVING] != toggles[MOVING];
