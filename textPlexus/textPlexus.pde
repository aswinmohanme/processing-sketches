
import hype.*;
import hype.extended.layout.*;
import hype.extended.colorist.*;
import hype.extended.behavior.*;
import megamu.mesh.*;
import processing.pdf.*;

final int NUMPARTICLES = 800;
final float THRESHOLD = 16;
HColorPool colors;
PVector[] finalLoc;
float[][] points = new float[NUMPARTICLES][2];

PFont fnt;
HText txt;

void setup() {
  size(800, 600);
  H.init(this);
  colors = new HColorPool(#F6B352, #F68657, #383A3F, #1F2124);
  fnt = createFont("Slabo",64);
  txt = new HText("D", 600, fnt);
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
      .strokeWeight(2)
      .noFill()
      .stroke(#8e44ad)
    ;
    if (dist > THRESHOLD){
      continue;
    }

    H.add(textPath[i]);
  }

  saveVector();
  H.drawStage();
}

void draw() {
}

void saveVector(){
  PGraphics tmp = null;
  tmp = beginRecord(PDF,"render.pdf");
  if (tmp == null){
    H.drawStage();
  } else {
    H.stage().paintAll(tmp, false, 1);
  endRecord();
  }
}
