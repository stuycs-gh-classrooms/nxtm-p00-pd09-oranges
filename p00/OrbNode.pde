class OrbNode extends Orb {

  OrbNode next;
  OrbNode previous;

  OrbNode() {
    next = previous = null;
  }//default constructor
  OrbNode(float x, float y, float s, float m) {
    super(x, y, s, m);
    next = previous = null;
  }//constructor
  
  OrbNode(float x, float y, float s, float m, float xspeed, float yspeed) {
    super(x, y, s, m, xspeed, yspeed);
    next = previous = null;
  }

  void display() {
    super.display();
    if (next != null) {
      float dnext = this.center.dist(next.center);
      if (dnext < SPRING_LENGTH) {
        stroke(0, 255, 0);
      } else if (dnext > SPRING_LENGTH) {
        stroke(255, 0, 0);
      } else {
        stroke(0);
      }
      if (toggles[SPRING]) {
        line(this.center.x, this.center.y+5, next.center.x, next.center.y+5);
      }
    }//next spring

    if (previous != null) {
      float dprev = this.center.dist(previous.center);
      if (dprev < SPRING_LENGTH) {
        stroke(0, 255, 0);
      } else if (dprev > SPRING_LENGTH) {
        stroke(255, 0, 0);
      } else {
        stroke(0);
      }
      if (toggles[SPRING]) {
        line(this.center.x, this.center.y-5, previous.center.x, previous.center.y-5);
      }
    }//next spring
  }//drawSpring

  void applySprings(int springLength, float springK) {
    if (next != null) {
      PVector sforce = getSpring(next, springLength, springK);
      applyForce(sforce);
    }
    if (previous != null) {
      PVector sforce = getSpring(previous, springLength, springK);
      applyForce(sforce);
    }
  }///applySprings
}//OrbNode
