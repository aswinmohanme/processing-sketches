import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import hype.*; 
import hype.extended.layout.*; 
import hype.extended.colorist.*; 
import hype.extended.behavior.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class textPlexus extends PApplet {







final int NUMPARTICLES = 60;
HDrawablePool pool;
PVector[] finalLoc;
float[] finalLocX;
float[] finalLocY;

PFont fnt;
HText txt;
HDrawable[] drawablePool = new HDrawable[NUMPARTICLES];
HTween tween[] = new HTween[NUMPARTICLES];

public void setup() {
  
  H.init(this);

  fnt = createFont("Roboto",64);
  txt = new HText("I", 500, fnt);
   H.add(txt)
    .anchorAt(H.CENTER)
    .locAt(H.CENTER)
    .noStroke()
    .noFill()
  ;
  final HShapeLayout lay = new HShapeLayout().target(txt);
  HPath textPath = new HPath();

  finalLoc = new PVector[NUMPARTICLES];
  for(int i=0; i < NUMPARTICLES; ++i){
    finalLoc[i] = lay.getNextPoint();
    textPath.vertex(finalLoc[i].x,finalLoc[i].y);
  }

  textPath.mode(POINTS).noFill().strokeWeight(1);
  H.add(textPath);

}

public void draw() {
  H.drawStage();
  // saveFrame("frames/########.png");
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "textPlexus" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
