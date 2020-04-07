/*
 * Color Picker
 * v. 0.8 january 2014
 *   v 0.9 march, 17, 2014
 *   v 0.99 april 06, 2020
 *
 * (c) Philippe Truillet
 */
 
import processing.video.*;

Capture cam;
Cible c;
PImage img; // selected color
boolean modified = false;

void setup() {
  size(700,520);
   surface.setResizable(false);
   surface.setTitle("Change couleur");
   surface.setLocation(20,20);
   surface.setIcon(loadImage("palette.png"));
  
   background(0);
   cam = new Capture(this, 640, 480);
   cam.start(); // start the cam
   noCursor();
   c= new Cible(20); // size of the target
}


void draw() {
  background(0);
  fill(0);
  stroke(0);

  // write rect 
  stroke(255);
  rect(660,20,30,30);
  
  if (img != null) {
  // display the selected color
    image(img,660,20, 30,30);
  }    
  // restore previous stroke
  stroke(0);
  
  if (modified == true) {
    color SC = c.getSelectedColor();
    color RC = c.getReplacedColor();
    cam.loadPixels();
      
    for (int i=0;i<cam.width;i++)
      for (int j=0;j<cam.height;j++)
        if (computeDifference(cam.pixels[i+ j*cam.width], SC) < 0.3)
          cam.pixels[i+ j*cam.width] = RC;
        cam.updatePixels();
  }
  image(cam, 0, 0); // read and display image from cam
  c.display(mouseX,mouseY);
  fill(255);
  text("clic gauche pour sélectionner une couleur, clic droit pour la remplacer", 20,500);
}


void mousePressed() {
  if (mouseButton == LEFT) {
    // sélectionne une couleur --> dans le carré sur le côté
    img = c.press(mouseX,mouseY);
    modified = false;
  }
  else { // RIGHT - change la couleur courante par celle sélectionnnée précédemment
    c.pickColor(mouseX,mouseY);
    modified = true;
  }  
}

float computeDifference(color c1, color c2) {
  float b = abs((c2 & 0xFF) - (c1 & 0xFF));
  float g = abs((c2 >> 8 & 0xFF) - (c1 >> 8 & 0xFF));
  float r = abs((c2 >> 16 & 0xFF) - (c1 >> 16 & 0xFF));
  // float alpha = abs((c2 >> 24 & 0xFF) - (c1 >> 24 & 0xFF));  
  return((r/256 + b/256 + g/256));
}

void captureEvent(Capture c) {
    c.read();
}

void exit(){
  println("Fin du sketch ;)");
  super.stop();
}
