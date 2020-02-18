/***************************************************************
 * Key
 * 
 *
 * (c) Philippe Truillet
 * Last revision: 19/04/2016
 * 
 ***************************************************************/
 
class Key
{
  private int x,y;
  private color currentc, c, c_inactive; // color
  private int largeur, longueur;  
  private String s = "A";

  private PFont f;

  Key() // basic constructor
  {
    this.x = 100;
    this.y = 100;
    this.largeur = 50;
    this.longueur = 50;
    this.c = color(19,203,255,180);
    this.c_inactive = color(#BCB4B4);
    
    this.currentc = this.c;
    f = loadFont("VK20.vlw");
  }
  
  Key(int longueur, int largeur, String s)
  {
    this.x = 0;
    this.y = 0;
    this.largeur = largeur;
    this.longueur = longueur;
    
    this.c = color(19,203,255,180);
    this.c_inactive = color(#BCB4B4);
    
    this.currentc = this.c;
    this.s = s;
    f = loadFont("VK20.vlw");
  }
  
  void setPosition(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  
  /*
  void setSize(int size)
  {

  }
  */
  
  void setColor(color c)
  {
    this.c = c;
  }
  
  void update() { 

    noStroke();
    fill(this.currentc);
    rect(this.x, this.y, this.longueur, this.largeur, 7);
    textAlign(CENTER,CENTER);
    textSize(20);
    fill(255);
    text(this.s, this.x+this.longueur/2, this.y+this.largeur/2);
  }
  
  
  String onPress() {
    if (mouseX < this.x + this.longueur && mouseX > this.x && mouseY> this.y && mouseY < this.y+this.largeur)
    {  
      this.currentc = this.c_inactive;
      if (this.s=="EN\nTER")
        return("\n");
      else  
        return(this.s);
    }
    else 
      return("");
  }
  
  void onRelease() {
   if (mouseX < this.x + this.longueur && mouseX > this.x && mouseY> this.y && mouseY < mouseY+this.largeur)
     this.currentc = this.c;
  }
}