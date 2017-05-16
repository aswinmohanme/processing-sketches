
/*
  * Author :: Aswin Mohan
  * Twitter :: @aswinmohanme

  * Given an Image, Convert the image to an Image full of text
*/

import hype.*;
import hype.extended.colorist.*;

PFont font;
String text;
char[] textArr;
int lineNo = 0;

HImage img;
HText txt;
HPixelColorist colors;

void setup() {
  size(800, 600);
  H.init(this);

  img = new HImage("image.jpg");
  font = createFont("roboto-mono.ttf", 12);

  colors = new HPixelColorist(img);

  text = join(loadStrings("text.txt"), ' ');
  textArr = text.toCharArray();
  for(int i=0, j=0; lineNo * 6 < height; ++i, ++j){
    if (i == textArr.length - 1) i = 0;
    if(j > 170) {
      textArr[i] = '\n';
      j = 0;
      lineNo++;
    }
    txt = new HText(str(textArr[i]), 5, font);
    H.add(txt)
      .loc(j*5, lineNo*6)
      .fill(colors.getColor(j*5, lineNo*6))
    ;
  }

  H.drawStage();
  noLoop();
}
void draw() {
}

void keyPressed() {
  if(key == 's')
    saveFrame("out.jpg");
    exit();
}
