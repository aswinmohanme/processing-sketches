import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import hype.*; 
import hype.extended.layout.*; 
import hype.extended.colorist.*; 
import hype.extended.behavior.*; 
import megamu.mesh.*; 
import processing.pdf.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class textPlexus extends PApplet {









final int NUMPARTICLES = 800;
final float THRESHOLD = 16;

HColorPool colors;
HShapeLayout lay;
HPath[] textPath;
Delaunay del;

PVector[] finalLoc;
float dist;
float[][] points = new float[NUMPARTICLES][2];
float[][] edges;

PFont fnt;
HText txt;

boolean shouldUpdate = true;
public void setup() {
  
  H.init(this);

  colors = new HColorPool(0xffF6B352, 0xffF68657, 0xff383A3F, 0xff1F2124, 0xff1F2124, 0xff1F2124, 0xff1F2124);
  fnt = createFont("Slabo",64);
}

public void draw() {
  if (shouldUpdate){
    H.stage().clear();
    renderLetter("R", 800, 12);
    shouldUpdate = false;
  }
  H.drawStage();
}

public void renderLetter(String s, int numParticles, int threshold){
  txt = new HText(s, 600, fnt);
  H.add(txt)
    .anchorAt(H.CENTER)
    .locAt(H.CENTER)
    .noStroke()
    .noFill()
  ;
  lay = new HShapeLayout().target(txt);

  finalLoc = new PVector[numParticles];
  for(int i=0; i < numParticles; ++i){
    finalLoc[i] = lay.getNextPoint();
    points[i][0] = finalLoc[i].x;
    points[i][1] = finalLoc[i].y;
  }
  del = new Delaunay(points);

  edges = del.getEdges();
  textPath = new HPath[edges.length];
  for(int i=0; i < edges.length; ++i){
    textPath[i] = new HPath(LINE);
    dist = HMath.dist(edges[i][0], edges[i][1], edges[i][2], edges[i][3]);
    if (dist > threshold){
      continue;
    }
    textPath[i]
      .line(edges[i][0], edges[i][1], edges[i][2], edges[i][3])
      .strokeWeight(2)
      .noFill()
      .stroke( colors.getColor())
    ;

    H.add(textPath[i]);
    shouldUpdate = true;
}
}
public void saveVector(){
  PGraphics tmp = null;
  tmp = beginRecord(PDF,"render.pdf");
  if (tmp == null){
    H.drawStage();
  } else {
    H.stage().paintAll(tmp, false, 1);
  endRecord();
  }
}
  public void settings() {  size(800, 768); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "textPlexus" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
