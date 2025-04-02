
class Wire {
  
  PVector center;
  float w;
  float l;
  
  Wire(int x, int y, float b, float h) {
    center = new PVector(x + w/2, y + h/2);
    w = b;
    l = h;
  }
  
  float getB(Orb other, float current) {
    float r = other.center.dist(this.center);
    float constant = 4 * PI * pow(10, -7);
    float B = (constant * current) / (2 * PI * r);
    return B;
  }
  
  void display() {
    fill(0);
    rect(center.x - w/2, center.y - l/2, w, l);
  }
}
