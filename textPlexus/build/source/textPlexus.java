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









final int NUMPARTICLES = 80;
final float THRESHOLD = 120;
HColorPool colors;
PVector[] finalLoc;
float[][] points = new float[NUMPARTICLES][2];

PFont fnt;
HText txt;

public void setup() {
  
  H.init(this);
  colors = new HColorPool(0xffF6B352, 0xffF68657, 0xff383A3F, 0xff1F2124);
  fnt = createFont("Roboto",64);
  txt = new HText("S", 600, fnt);
   H.add(txt)
    .anchorAt(H.CENTER)
    .locAt(H.CENTER)
    .noStroke()
    .noFill()
  ;
  final HShapeLayout lay = new HShapeLayout().target(txt);

  finalLoc = new PVector[NUMPARTICLES];
  for(int i=0; i < NUMPARTICLES; ++i){
    finalLoc[i] = lay.getNextPoint();
    points[i][0] = finalLoc[i].x;
    points[i][1] = finalLoc[i].y;
  }
  Delaunay del = new Delaunay(points);

  float[][] edges = del.getEdges();
  float dist;
  HPath[] textPath = new HPath[edges.length];
  for(int i=0; i < edges.length; ++i){
    textPath[i] = new HPath(LINE);
    dist = HMath.dist(edges[i][0], edges[i][1], edges[i][2], edges[i][3]);
    textPath[i]
      .line(edges[i][0], edges[i][1], edges[i][2], edges[i][3])
      .strokeWeight(4)
      .noFill()
      .stroke(colors.getColor())
    ;
    if (dist > THRESHOLD){
      continue;
    }

    H.add(textPath[i]);
  }

  saveVector();
  H.drawStage();
}

public void draw() {
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
