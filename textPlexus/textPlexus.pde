
import hype.*;
import hype.extended.layout.*;
import hype.extended.colorist.*;
import hype.extended.behavior.*;
import megamu.mesh.*;

final int NUMPARTICLES = 80;
HColorPool colors;
PVector[] finalLoc;
float[][] points = new float[NUMPARTICLES][2];

PFont fnt;
HText txt;

void setup() {
  size(800, 600);
  H.init(this);
  colors = new HColorPool(#F6B352, #F68657, #383A3F, #1F2124);
  fnt = createFont("Roboto",64);
  txt = new HText("R", 600, fnt);
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
  HPath[] textPath = new HPath[edges.length];
  for(int i=0; i < edges.length; ++i){
    textPath[i] = new HPath(LINE);
    textPath[i]
      .line(edges[i][0], edges[i][1], edges[i][2], edges[i][3])
      .strokeWeight(2)
      .noFill()
      .stroke( colors.getColor() )
    ;

    H.add(textPath[i]);
  }

  H.drawStage();
}

void draw() {
  // saveFrame("frames/########.png");
}
