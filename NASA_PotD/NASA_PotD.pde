/***************************************************************
 * NASA API 
 * 
 * Nasa Pic of the Day API
 * (c) Philippe Truillet 2023
 * First revision: 18/01/2023
 * Last revision: 19/01/2023
 *
 ***************************************************************/
 
 PotD pic;
 PImage p,sketch_icon;
 PInfo info;
 
 void setup() {
   size(800,600);
   surface.setResizable(true);
   surface.setLocation(20,20);
   sketch_icon = loadImage("nasa.png");
   surface.setIcon(sketch_icon);
   
   pic = new PotD(); 
   p = loadImage(pic.getUrl());
   p.resize(800,0);
   surface.setSize(p.width,p.height);
   surface.setTitle("Nasa Pic of the Day - " + pic.getTitle());
}  

void draw(){
  background(0);
  image(p,0,0);
  //text("", 20, 20);
}

void mousePressed(){
  if (info == null)
    try {
      info = new PInfo(dataPath("")); // we have to give the local path in parameter
      info.setText(pic.getExplanation());
    }
    catch (Exception e) {}
  else
    info.getSurface().setVisible(true);
}
