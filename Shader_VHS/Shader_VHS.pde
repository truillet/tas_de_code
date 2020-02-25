/*
 * Une caméra old fashion type vieille cassette VHS
 * Tiré et adapté de https://github.com/georgehenryrowe
 */
import processing.video.*;

Capture cam;
PShader vhs_glitch;

//**********************************************************************

void setup() {
  size(640, 480, P3D);
  cam = new Capture(this, 640, 480);
  cam.start(); // démarrer la caméra
  
  //LOAD IN SHADER
  vhs_glitch = loadShader("vhs_glitch.glsl");
  vhs_glitch.set("iResolution", float(width), float(height));  
}

//**********************************************************************

void draw() {
  //SHADER SETTINGS
  vhs_glitch.set("iGlobalTime", millis() / 1000.0);
  image(cam, 0, 0);
  filter(vhs_glitch);
}

void captureEvent(Capture c) {
  c.read();
}
