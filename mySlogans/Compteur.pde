/* Compteur
 * 
 * 9 plots 
 * 
 * Dernière mise à jour : 20/02/2016
 */

import java.lang.Long;

class Compteur
{
  private String valeur;
  private long val;
  private int x,y;
  private int l,L; // Longueur, largeur du carré
  private PFont f;
  
   Compteur() {
    val = 0;
    valeur = Long.toString(val);
    f = loadFont("DotMatrix-24.vlw");
    textFont(f);
    x=100;
    y=100;
    l=50;
    L=30;
  }
  
  Compteur(long demarrage)
  { 
    val = demarrage;
    valeur = Long.toString(val);
    f = loadFont("DotMatrix-24.vlw");
    textFont(f);
    l=30;
    L=20;
  }
  
  void setCoord(int x, int y) {
    this.x=x;
    this.y=y;
  }
  
  void setValue(int value) {
    val = value;
    valeur = Long.toString(val);
  }
  
  void setFont(String fonte) {
    f= loadFont(fonte);
  } 
  
  void update() {
    noStroke();
    textFont(f);
    /* dessiner la forme */
    /* des carrés et un chiffre par carré */ 
    fill(#F25D5D);
    for (int i=0;i<9;i++)
      rect(x+i*(L+10),y,L,l);
    fill(255);
    
    textAlign(CENTER,CENTER);
    textSize(24);
    int diff = 9-valeur.length();
    
    for (int i=0;i<valeur.length();i++)
      text(valeur.charAt(i), diff*(L+10) + x+i*(L+10)+L/2, y+l/2);

    for (int i=0;i<diff;i++)
      text("0", x+i*(L+10)+L/2, y+l/2);
        
  }
}