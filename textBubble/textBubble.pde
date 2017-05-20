
import hype.*;
import hype.extended.layout.*;
import hype.extended.colorist.*;
import hype.extended.behavior.*;

final int NUMPARTICLES = 800;
HDrawablePool pool;
PVector[] finalLoc;

PFont fnt;
HText txt;
HDrawable[] drawablePool = new HDrawable[NUMPARTICLES];
HTween tween[] = new HTween[NUMPARTICLES];

void setup() {
  size(800, 600);
  H.init(this);

  fnt = createFont("Roboto Mono",64);
  txt = new HText("Malavika", 150, fnt);
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
  }

  pool = new HDrawablePool(NUMPARTICLES);
  pool.autoAddToStage()
    .add(
      new HEllipse()
    )
    .colorist(new HColorPool(#e74c3c, #f1c40f, #2980b9, #27ae60, #16a085, #8e44ad).fillOnly())
    .onCreate(
      new HCallback() {
        public void run(Object obj) {
          HEllipse e = (HEllipse) obj;
          e.size(random(4, 8))
            .noStroke()
            .loc(random(random(-50), random(850)), random(random(-50), random(650)))
          ;
        }
      }
    )
  ;

  for(int i=0; i < NUMPARTICLES; ++i){
    drawablePool[i] = pool.request();
    tween[i] = new HTween();
    tween[i].target(drawablePool[i])
      .property(H.LOCATION)
      .start(drawablePool[i].x(), drawablePool[i].y())
      .end(finalLoc[i].x, finalLoc[i].y)
      .ease(0.005)
      .spring(0.9)
    ;
  }


}

void draw() {
  H.drawStage();
  saveFrame("frames/2########.png");
}
