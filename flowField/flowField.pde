
/*
  * Author :: Aswin Mohan
  * Twitter :: @aswinmohanme
*/

float angle;

Particle[] particles;
void setup(){
  size(800, 600);
  smooth();

  particles = new Particle[100];
  for (int i=0; i < particles.length; ++i){
    particles[i] = new Particle();
  }
}

void draw(){
  for (int i=0; i < particles.length; ++i){
    angle = noise((int)random(width), (int)random(height)) * PI;
    particles[i].update(PVector.fromAngle(angle));
    particles[i].draw();
  }
}
