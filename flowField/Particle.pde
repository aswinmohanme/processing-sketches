
class Particle {
  PVector pos = new PVector((int)random(width), (int)random(height));
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);

  void update(PVector force){
    pos.add(vel);
    vel.add(acc);
    acc.add(force);
  }

  void draw(){
    strokeWeight(1);
    point(pos.x, pos.y);
  }
}
