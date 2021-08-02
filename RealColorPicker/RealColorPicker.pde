/*
 * Color Picker
 * v. 0.8 january 2014
 *   v 0.9 march, 17, 2014
 *   v. 0.99 january, 21, 2021
 *   v. 1.0  february 08, 2021
 *   v. 1.1  february 14, 2021
 *
 * replace that (keyPressed) by this (mousePressed)
 * (c) Philippe Truillet
 */
 
import processing.video.*;

// ajout de FSM
public enum FSM {
  INITIAL,
  MODIFIED,
  HELP
}

Capture cam;
Cible c;
PImage img; // selected color
PImage f; // frame of a video
PImage sketch_icon;
FSM mae;


void setup() {
 surface.setLocation(218,0);
 surface.setTitle(".: RealColorPicker :.");
 sketch_icon = loadImage("picker.png");
 surface.setIcon(sketch_icon); 
 size(700,480);
 background(0);
 cam = new Capture(this, 640, 480);
 cam.start(); // start the cam
 noCursor();
 c= new Cible(20); // size of the target
 mae = FSM.INITIAL;
}

// how to: press color
void draw() {
  // draw current interface
  fill(0);
  stroke(0);
  rect(640,0,640,480);
  // write rect 
  stroke(255);
  rect(660,20,30,30);
  
  if (img != null) {
    // display the selected color
    image(img,660,20, 30,30);
  }
  stroke(0);
  
  switch (mae) {
    case INITIAL:
      break;

    case MODIFIED:
      // restore previous stroke
      color SC = c.getSelectedColor();
      color RC = c.getReplacedColor();
      // change to HSB ?
      colorMode(HSB,360,100,100);
      cam.loadPixels();
      // change color where possible  
      for (int i=0;i<cam.width;i++)
        for (int j=0;j<cam.height;j++)
          if (computeDistanceHSB(cam.pixels[i+ j*cam.width], SC) < 100)
            cam.pixels[i+ j*cam.width] = RC;       
      cam.updatePixels();
      colorMode(RGB);
      break;

    case HELP:
      break;

    default:
      break;
  }
  // draw image
  image(cam, 0, 0); // read and display image from cam
  c.display(mouseX,mouseY);
}


void keyPressed() {
  img = c.press(mouseX,mouseY);
  mae = FSM.INITIAL;
}

void mousePressed() {
  c.pickColor(mouseX,mouseY);
   mae = FSM.MODIFIED;
}

float computeDistanceRGB(color c1, color c2) {
  float b = abs(blue(c2)-blue(c1));        // abs((c2 & 0xFF) - (c1 & 0xFF));
  float g = abs(green(c2)-green(c1));      // abs((c2 >> 8 & 0xFF) - (c1 >> 8 & 0xFF));
  float r = abs(red(c2)-red(c1));          // abs((c2 >> 16 & 0xFF) - (c1 >> 16 & 0xFF));
  // float alpha = abs(alpha(c2)-alpha(c1));  // abs((c2 >> 24 & 0xFF) - (c1 >> 24 & 0xFF));  
  return(sqrt(b*b+g*g+r*r));
}

float computeDistanceHSB(color c1, color c2) {
  float h = abs(hue(c2)-hue(c1)); 
  float s = saturation(c1);
  float b = brightness(c1); 
  return(sqrt(h*h + s*s + b*b));
}

// webcam event: get image when enabled
void captureEvent(Capture c) {
  c.read();
}
