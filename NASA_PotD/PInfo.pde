// Second window

class PInfo extends PApplet {
  private String path;
  private String texte;
  private PFont f;
  
  PInfo(String path) {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    this.path= path;
  }

  void settings() {
    size(400, 400);
  }

  void setup() {
    windowTitle("Information");
    // this.getSurface().setLocation(200,200);  
    smooth();   
    f = loadFont(this.path + "/Sarabun-Medium-14.vlw");
    textFont(f,14);    
  }

  void draw() {   
    background(0);
    text(texte,10,10,width-10,height-10);
  }
  
  void setText(String t){
    texte = t; 
  }

  void mousePressed() {
    this.getSurface().setVisible(false); // fake destroy
  }
}
