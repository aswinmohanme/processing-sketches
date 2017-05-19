
import processing.pdf.*;

import hype.*;
import hype.extended.layout.*;
import hype.extended.colorist.*;
import hype.extended.behavior.*;

import megamu.mesh.*;

import controlP5.*;
ControlP5 controlP5;

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
HCanvas letterCanvas;

boolean shouldUpdate = true;
void setup() {
  size(800, 768);
  smooth();
  H.init(this);

  // controlP5 = new ControlP5(this);
  // controlP5.addSlider("partSlider", 0, 1000, 800, 600,  50, 100, 10);

  colors = new HColorPool(#F6B352, #F68657, #383A3F, #1F2124, #1F2124, #1F2124 );
  fnt = createFont("Slabo",64);

  char[] alphabets = "abcdefghijklmnopqrstuvwxyz".toCharArray();
  String letter;
  for(int i=0; i < 26; ++i){
    letter = str(alphabets[i]);
    renderLetter(letter, 800, 12);
  }
}

void draw() {
  H.drawStage();
}

void controlEvent(ControlEvent event){
  if(event.isController()){
    if(event.getController().getLabel() == "partSlider"){
      shouldUpdate = true;
    }
  }
}

void renderLetter(String s, int numParticles, int threshold){
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
      .stroke( #1F2124)
    ;

    H.add(textPath[i]);
  }
    saveVector(s+".pdf");
  for(int i=0; i < edges.length; ++i){
    H.remove(textPath[i]);
  }
}

void removePoints(){
}

void saveVector(String fileName){
  PGraphics tmp = null;
  tmp = beginRecord(PDF,fileName);
  if (tmp == null){
    H.drawStage();
  } else {
    H.stage().paintAll(tmp, false, 1);
  endRecord();
  }
}
