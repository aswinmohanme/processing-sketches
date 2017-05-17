import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class flowField extends PApplet {


/*
  * Author :: Aswin Mohan
  * Twitter :: @aswinmohanme
*/

float angle;

Particle[] particles;
public void setup(){
  
  

  particles = new Particle[100];
  for (int i=0; i < particles.length; ++i){
    particles[i] = new Particle();
  }
}

public void draw(){
  for (int i=0; i < particles.length; ++i){
    angle = noise((int)random(width), (int)random(height)) * PI;
    particles[i].update(PVector.fromAngle(angle));
    particles[i].draw();
  }
}

class Particle {
  PVector pos = new PVector((int)random(width), (int)random(height));
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);

  public void update(PVector force){
    pos.add(vel);
    vel.mult(acc);
    acc.add(force);
  }

  public void draw(){
    strokeWeight(1);
    point(pos.x, pos.y);
  }
}
  public void settings() {  size(800, 600);  smooth(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "flowField" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
