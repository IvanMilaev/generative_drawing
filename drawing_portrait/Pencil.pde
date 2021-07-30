class Particle {
  int x;
  int y;
  float angle;
  color col;
  
  Particle(int x_, int y_, float angle_, color col_) {
    x = x_;
    y = y_;
    angle = angle_;
    col = col_;
  }
  
  void update() {
    x = x+1;
    y = y+1;
  }
  void display() {
    
    fill(col,100);
    //rectMode(CENTER);
    rect(x, y, 1, 1);
  }
}
