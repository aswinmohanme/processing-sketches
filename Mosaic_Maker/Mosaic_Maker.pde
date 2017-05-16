/*
    * Author :: Aswin
    * Twitter ::@aswinmohanme
    *
    * Generate a Mosaic of an Image with Smaller Images of the Same Context
*/

import processing.pdf.*;

import hype.*;
import hype.extended.colorist.*;

HImage mainImg;
HImage fillImg;
HRect e;
String[] fileColors;

void setup (){
    size(965,645);
    H.init(this);

    //Load the Main Image
    mainImg = new HImage("Main.gif");
    H.add(mainImg);

    //Load the Color Information from the Processed TXT Files
    fileColors = loadStrings("ColorData.txt");

    //Color Pool
    HPixelColorist colors = new HPixelColorist(mainImg);

    //Load the Colors and Pixelate it
    int side = 10;
    int numberShapesX = width /side;
    int numberShapesY = height / side;
    int locx = 0;
    int locy = 0;

    for (int i=0; i < numberShapesX; ++i){
        for (int j=0; j < numberShapesY; ++j) {
            locx = i * (side) + side;
            locy = j * (side) + side;

            e = new HRect();
            e.strokeWeight(0)
                .loc(locx , locy)
                .size(side,side)
                .anchorAt(H.CENTER)
            ;
            color c = colors.getColor(locx , locy);
            // Return the File of name of the Image with the Color at the given spot
            String fileName = getFileWithColor(c);
            fillImg = new HImage(fileName);
            fillImg.loc(locx , locy)
                .size(side)
            ;
            H.add(fillImg)
              .alpha(120)
            ;
        }
    }
    H.drawStage();
    saveFrame("mohanlal.jpg");
}


String getFileWithColor(color c){
    int fileNum = 0;

    int[] colors = new int[fileColors.length];
    for (int i =0; i < fileColors.length; ++i){
        String file = fileColors[i];
        colors[i] = Integer.parseInt(file.split(" ")[1]);
    }

    int distance = Math.abs(colors[0] - c);
    for (int j=0; j<colors.length; ++j){
        int cdistance = Math.abs(colors[j] - c);
        if (cdistance < distance){
            distance = cdistance;
            fileNum = j;
        }
    }

    String fileName = fileColors[fileNum].split(" ")[0];
    return fileName;
}
