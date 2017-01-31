import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.pdf.*; 
import hype.*; 
import hype.extended.colorist.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class MarlinMonroe_Circles extends PApplet {


/*
    * Author :: Aswin Mohan
    * Twitter :: @aswinmohanme
    *
    * Render an Image of Marlin Monroe with Cirlces , Just Learning
*/






HEllipse e;
HImage img;
HPixelColorist colors;

public void setup() {
    
    H.init(this)
        .background(0xff000000)
    ;

    // Load the Image and the Colors
    img = new HImage("Marlin.gif");
    colors = new HPixelColorist(img);

    int radius = 10;
    int padding = 10;
    int numberShapesX = width / ((radius+padding));
    int numberShapesY = height / ((radius+padding));

    for (int i=0; i < numberShapesX; ++i){
        for (int j=0; j < numberShapesY; ++j) {
            e = new HEllipse();
            e.strokeWeight(0)
                .loc(i*(radius+padding)+radius ,j*(radius+padding) + radius)
                .size(radius)
                .anchorAt(H.CENTER)
            ;
            colors.applyColor(e);
            H.add(e);
        }
    }

}

public void draw() {
    H.drawStage();
}

public void keyPressed() {
    if (key == 's'){
        saveFrame("render.png");
        exit();
    }
}
  public void settings() {  size(640 , 904); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "MarlinMonroe_Circles" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
