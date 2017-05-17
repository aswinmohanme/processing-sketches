
import hype.*;
import hype.extended.layout.*;
import hype.extended.colorist.*;
import hype.extended.behavior.*;

HDrawablePool pool;

PFont fnt;
HText txt;

HTimer timer;
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
  HShapeLayout lay = new HShapeLayout().target(txt);

  pool = new HDrawablePool(800);
  pool.autoAddToStage()
    .add(
      new HEllipse()
    )
    .layout(lay)

    .colorist(new HColorPool(#e74c3c, #f1c40f, #2980b9, #27ae60, #16a085, #8e44ad).fillOnly())
    .onCreate(
      new HCallback() {
        public void run(Object obj) {
          HEllipse e = (HEllipse) obj;
          e.size(random(2,10))
            .anchorAt(H.CENTER)
            .noStroke()
          ;
        }
      }
    )
  ;

}

void draw() {
  H.drawStage();
  pool.request();
}
