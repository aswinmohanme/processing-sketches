
import hype.*;
import hype.extended.layout.*;
import hype.extended.colorist.*;
import hype.extended.behavior.*;

HDrawablePool pool;
PVector[] finalLoc;

PFont fnt;
HText txt;
HDrawable[] drawablePool = new HDrawable[800];
HTween tween[] = new HTween[800];

void setup() {
  size(800, 600);
  H.init(this);

  fnt = createFont("Roboto",64);
  txt = new HText("ISQUIP", 200, fnt);
   H.add(txt)
    .anchorAt(H.CENTER)
    .locAt(H.CENTER)
    .noStroke()
    .noFill()
  ;
  final HShapeLayout lay = new HShapeLayout().target(txt);

  finalLoc = new PVector[800];
  for(int i=0; i < 800; ++i){
    finalLoc[i] = lay.getNextPoint();
  }

  pool = new HDrawablePool(800);
  pool.autoAddToStage()
    .add(
      new HEllipse()
    )
    .layout(new HShapeLayout().target(new HRect(width, height)))
    .colorist(new HColorPool(#e74c3c, #f1c40f, #2980b9, #27ae60, #16a085, #8e44ad).fillOnly())
    .onCreate(
      new HCallback() {
        public void run(Object obj) {
          HEllipse e = (HEllipse) obj;
          e.size(random(4, 10))
            .noStroke()
          ;
        }
      }
    )
  ;

  for(int i=0; i < 800; ++i){
    drawablePool[i] = pool.request();
    tween[i] = new HTween();
    tween[i].target(drawablePool[i])
      .property(H.LOCATION)
      .start(drawablePool[i].x(), drawablePool[i].y())
      .end(finalLoc[i].x, finalLoc[i].y)
      .ease(0.03)
      .spring(0.8)
    ;
  }


}

void draw() {
  H.drawStage();
}
