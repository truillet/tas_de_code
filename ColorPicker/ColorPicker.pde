import ij.IJ;
import ij.ImageJ;
import ij.ImagePlus;
import ij.gui.PointRoi;
import ij.measure.Calibration;
import ij.plugin.PlugIn;

color fg;

void settings(){
  size(400,400, FX2D);
}

void setup(){
  surface.setLocation(500,300);
  surface.setTitle(" .: Icône :.");
  PImage p =loadImage("colormap.gif");  
  surface.setIcon(p);
  
  IJ.run("Color Picker...");
  WindowManager.getWindow("CP").setLocation(new java.awt.Point(100,400));
}

void draw() {
  fg = colorFromAWTColor(Toolbar.getForegroundColor());
  background(fg);
  
}

color colorFromAWTColor (java.awt.Color c) {
  return color(c.getRed(), c.getGreen(), c.getBlue());
}
