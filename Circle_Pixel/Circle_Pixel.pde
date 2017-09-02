
/*
    * Author :: Aswin Mohan
    * Twitter :: @aswinmohanme
    *
    * Render an Image of Marlin Monroe with Cirlces , Just Learning
*/

import processing.pdf.*;

import hype.*;
import hype.extended.colorist.*;

HEllipse e;
HImage img;
HPixelColorist colors;

void setup() {
    size(640 , 904);
    H.init(this)
        .background(#000000)
    ;

    // Load the Image and the Colors
    img = new HImage("m.jpg");
    colors = new HPixelColorist(img);

    int radius = 20;
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

void draw() {
    H.drawStage();
}

void keyPressed() {
    if (key == 's'){
        saveFrame("render.png");
        exit();
    }
}
