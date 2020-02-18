/* Slogan
 * 
 * 9 plots 
 * 
 * Dernière mise à jour : 20/02/2016
 */

import java.lang.Long;

class Slogan
{
  private String SHaut;
  private String SBas;
  private int x,y;
  private PFont f1,f2;
  
   Slogan() {
    SHaut="5";
    SBas="5 doigts de la main";
    
    f1 = loadFont("Sansation_Light-24.vlw");
    f2 = loadFont("Sansation_Light-14.vlw");
    x=100;
    y=100;
  }
  
  Slogan(String h, String b) {
    SHaut=h;
    SBas=b;
    
    f1 = loadFont("Sansation_Light-24.vlw");
    f2 = loadFont("Sansation_Light-14.vlw");
    x=100;
    y=100;  
  }
  
  void setFont(String fonte) {
    f1= loadFont(fonte);
  }
  
  void setCoord(int x, int y) {
    this.x=x;
    this.y=y;
  }
  
  void update() {
    textFont(f1);
    textAlign(LEFT);
    noStroke();
    /* haut en jaune */
    fill(255,255,0);
    textSize(24);
    text(SHaut,x,y);
    
    fill(255);
    textFont(f2);
    textSize(14);
    text(SBas, x,y+20);
    noFill();
    stroke(255);
    rect(x-10,y-30,textWidth(SBas)+20,70);
  }
}