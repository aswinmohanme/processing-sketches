
import hype.*;
import hype.extended.layout.*;
import hype.extended.colorist.*;
import hype.extended.behavior.*;

final int NUMPARTICLES = 60;
HDrawablePool pool;
PVector[] finalLoc;
float[] finalLocX;
float[] finalLocY;

PFont fnt;
HText txt;
HDrawable[] drawablePool = new HDrawable[NUMPARTICLES];
HTween tween[] = new HTween[NUMPARTICLES];

void setup() {
  size(800, 600);
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

void draw() {
  H.drawStage();
  // saveFrame("frames/########.png");
}
