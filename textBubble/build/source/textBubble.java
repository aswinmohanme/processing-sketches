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

public class textBubble extends PApplet {







HDrawablePool pool;

PFont fnt;
HText txt;

HTimer timer;
public void setup() {
  
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

    .colorist(new HColorPool(0xffe74c3c, 0xfff1c40f, 0xff2980b9, 0xff27ae60, 0xff16a085, 0xff8e44ad).fillOnly())
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

public void draw() {
  H.drawStage();
  pool.request();
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "textBubble" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
