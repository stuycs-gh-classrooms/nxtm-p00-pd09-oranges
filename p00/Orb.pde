class Orb {

  //instance variables
  PVector center;
  PVector velocity;
  PVector acceleration;
  float bsize;
  float mass;
  color c;
  int q = (int)random(-5, 5);
  


  Orb() {
    bsize = random(10, MAX_SIZE);
    float x = random(bsize/2, width-bsize/2);
    float y = random(bsize/2, height-bsize/2);
    center = new PVector(x, y);
    mass = random(10, 100);
    velocity = new PVector();
    acceleration = new PVector();
    setColor();
  }

  Orb(float x, float y, float s, float m) {
    bsize = s;
    mass = m;
    center = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
    setColor();
  }
  
  Orb(float x, float y, float s, float m, float xspeed, float yspeed) {
    bsize = s;
    mass = m;
    center = new PVector(x, y);
    velocity = new PVector(xspeed, yspeed);
    acceleration = new PVector();
    setColor();
  }
  

  //movement behavior
  void move(boolean bounce) {
    if (bounce) {
      xBounce();
      yBounce();
    }

    velocity.add(acceleration);
    center.add(velocity);
    acceleration.mult(0);
  }//move

  void applyForce(PVector force) {
    PVector scaleForce = force.copy();
    scaleForce.div(mass);
    acceleration.add(scaleForce);
  }

  PVector getDragForce(float cd) {
    float dragMag = velocity.mag();
    dragMag = -0.5 * dragMag * dragMag * cd;
    PVector dragForce = velocity.copy();
    dragForce.normalize();
    dragForce.mult(dragMag);
    println("dragForce: " + dragForce);
    return dragForce;
  }

  PVector getGravity(Orb other, float G) {
    float strength = G * mass*other.mass;
    //dont want to divide by 0!
    float r = max(center.dist(other.center), MIN_SIZE);
    strength = strength/ pow(r, 2);
    PVector force = other.center.copy();
    force.sub(center);
    force.mult(strength);
    return force;
  }
 
  
  PVector getElectricForce(Orb other, float electricK) {
    if (q == 0) {
      q = (int)random(1, 5);
    }
    if (other.q == 0) {
      other.q = (int)random(1, 5);
    }
    float strength = electricK * q * other.q;
    float r = max(center.dist(other.center), MIN_SIZE);
    strength /= pow(r, 2);
    PVector force = other.center.copy();
    force.sub(center);
    force.mult(strength);
    force.normalize();
    if (q * other.q > 0) {
      force.mult(-1);
    }
    return force;
  }
    

  //spring force between calling orb and other
  PVector getSpring(Orb other, int springLength, float springK) {
    PVector direction = PVector.sub(other.center, this.center);
    direction.normalize();

    float displacement = this.center.dist(other.center) - springLength;
    float mag = springK * displacement;
    direction.mult(mag);

    return direction;
  }//getSpring
  
  
  boolean yBounce() {
    if (center.y > height - bsize/2) {
      velocity.y *= -1;
      center.y = height - bsize/2;

      return true;
    }//bottom bounce
    else if (center.y < bsize/2) {
      velocity.y*= -1;
      center.y = bsize/2;
      return true;
    }
    return false;
  }//yBounce
  boolean xBounce() {
    if (center.x > width - bsize/2) {
      center.x = width - bsize/2;
      velocity.x *= -1;
      return true;
    } else if (center.x < bsize/2) {
      center.x = bsize/2;
      velocity.x *= -1;
      return true;
    }
    return false;
  }//xbounce

  boolean collisionCheck(Orb other) {
    return ( this.center.dist(other.center)
      <= (this.bsize/2 + other.bsize/2) );
  }//collisionCheck

  boolean isSelected(float x, float y) {
    float d = dist(x, y, center.x, center.y);
    return d < bsize/2;
  }//isSelected

  void setColor() {
    color c0 = color(0, 255, 255);
    color c1 = color(0);
    c = lerpColor(c0, c1, (mass-MIN_SIZE)/(MAX_MASS-MIN_SIZE));
  }//setColor

  //visual behavior
  void display() {
    noStroke();
    if (toggles[ELECTRIC] == false) {
      fill(c);
    } else {
      if (q > 0) {
        fill(255, 0, 0);
      } else {
        fill(0, 0, 255);
      }
    }
    circle(center.x, center.y, bsize);
    fill(0);
    
  }//display
  
  void displayMass() {
    text("mass: " + (int)mass, center.x - bsize/2, center.y - bsize);
  }//displayMass
  
  void displayCharge() {
    text("q = " + q, center.x + bsize/2, center.y);
  }//displayCharge
  
  void displayVelocity() {
    text(velocity.copy().mag(), center.x + bsize/2, center.y);
  }//displayVelocity
}//Orb
