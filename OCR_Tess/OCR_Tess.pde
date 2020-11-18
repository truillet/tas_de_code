/* OCR recognition example with a webcam
 * 
 * Last Revision: 17/11/2020
 * Philippe Truillet 
 */

import processing.video.*;

public enum FSM {
  INITIAL, /* Initial state */
  CAPTURE,
  RECOGNITION,
  HELP 
};

P_OCR pocr;
String result;

FSM mae;
Capture cam1;

PFont font;
PImage sketch_icon;

void setup() {
  size(800,600);
  surface.setTitle(".: OCR :.");
  surface.setLocation(50,50);
  sketch_icon = loadImage("ocr.png");
  surface.setIcon(sketch_icon);
  pocr= new P_OCR();
  smooth();
  font = loadFont("TwCenMT-Regular-16.vlw");
  textFont(font);  
  cam1 = new Capture(this,800,600);  
  mae=FSM.INITIAL;
}

void draw(){
  switch (mae) {
    case INITIAL:
      background(255);
      fill(0);
      text("Press (C) to display webcam then SPACEBAR to capture image\n(H) for help",50,50);  
      break;
    case CAPTURE:
      background(0);
      image(cam1,0,0);
      break;
    case RECOGNITION:
      background(255);
      text("RESULT EXTRACTED FROM WEBCAM\n\n"+ result,50,50);
      text("Press SPACEBAR to continue",50,height-50);
      break;
      
    case HELP:
      background(255);
      fill(0);
      text("Press (C) to display webcam then SPACEBAR to capture image\n(H) for help",50,50);      
      break;
    default:
      break;
  }
  
}

void keyPressed(){
  switch (key) {
    case 'r': // Recognition
    case 'R':
      // display result
      
      break;
      
    case 'c':
    case 'C': // Capture
      if (mae==FSM.INITIAL) {
        cam1.start();
        mae=FSM.CAPTURE;
      }
      break;

    case 'h':
    case 'H': // Help
        mae = FSM.HELP;
      break;
      
    case ' ': // Take picture then recognition
      switch (mae) {
        case CAPTURE:
          // save picture
          save(dataPath("")+"/doc/imageTemp.png");
          cam1.stop();
          pocr.setFilename("imageTemp.png");
          result = pocr.recognize();
          mae = FSM.RECOGNITION;
          break;
          
        case RECOGNITION:  
          mae = FSM.INITIAL;
          break;
        default:
         break;
      }
      break;
      
    default:
      break;
  }
}


void captureEvent(Capture c) {
  c.read();
}
