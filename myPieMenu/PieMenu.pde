/***************************************************************
 * Pie Menu
 * 
 *
 * (c) Philippe Truillet
 * Last revision: 07/10/2016
 * v. 0.93
 * Icons may be found here: http://flaticons.net/
 ***************************************************************/
 
 /* A résoudre
   1. afficher les libellés (fait le 30.05)
   2. limiter le choix si souris dans le rayon du PieMenu (fait le 30.05)
   3. décaler l'affichage des menus (fait le 07.10)
 */
 
 /* Deux types de PieMenu : texte et image
  * A faire : créer une interface PieMenu + PMTexte et PMIcon (inherits PieMenu)
  */
  
class PieMenu {
  private ArrayList<String> S;
  int x,y;
  int r;
  int items;
  boolean state;
  int selected_item;
  color c, hc, ic; // couleur, couleur de surbrillance, couleur "inner circle"
  
  PieMenu() {
    this.state = false;
    
    this.x = 100;
    this.y = 100;
    this.r = 150;
    this.selected_item=-1;
    
    this.S = new ArrayList();
    
    this.c = color(115,122,237);
    this.hc = color(158,184,211);
    
    this.ic = color(115,122,237);
    
    this.items = S.size();
  }
  
  // PieMenu()
  
  void add(String s) {
    this.S.add(s);
    this.items = S.size();
  }
  
  /* setter */
  void setColors(color c, color hc) {
    this.c = c;
    this.hc = hc;
  }
  
  void setInnerColor(color ic) {
    this.ic = ic;
  }
  
  void setRadius(int r) {
    this.r = r;
  }
  
  int setState(boolean b, int x, int y) {
    this.state = b;
    this.x = x;
    this.y = y;
    return(this.selected_item);
  }
   
   
  void update(int x, int y) {
    
    if (this.state==true) { // afficher
      fill(this.c);
      noStroke();   
      ellipse(this.x, this.y, this.r, this.r);
      stroke(0);
      // calcul du nombre d'items à afficher
      this.items = S.size(); 
      
      // calcul angle position de la souris par rapport au centre    
      float theta = atan2(y-this.y, x-this.x); 
      
      // affichage du camembert
      float delta = PI/this.items; 
      
      float alpha;
      for (int i=0;i<this.items;i++)
      {        
        alpha = ((i*2*PI)/this.items) - delta;
        line(this.x,this.y, this.x+this.r*cos(alpha),this.y+ this.r*sin(alpha));
      }
      
      // affichage en inverse video de la bonne portion du camenbert (si la distance est < rayon)
      // println ("dist = " + sqrt(pow(x-this.x,2) + pow(y-this.y,2)) + " rayon = " + this.r/20); 
      if (sqrt(pow(x-this.x,2) + pow(y-this.y,2)) <= this.r/10)
        this.selected_item =-1;        
      else {
        this.selected_item = getItem(theta,this.items);

        fill(this.hc);
        arc(this.x, this.y, this.r, this.r, (this.selected_item-1)*(2*PI/this.items)-delta,(this.selected_item*2*PI)/this.items - delta);
      }    
      
      // affichage du texte
      fill(0);
      textSize(10);
      textAlign(CENTER);
      for (int i=0;i<this.items;i++)
      {
        alpha = (i*2*PI/this.items + (i+1)*2*PI/this.items)/2 - delta;
        text(this.S.get(i), this.x+(this.r/3)*cos(alpha), this.y+ (this.r/3)*sin(alpha));
      }
      // affiche cercle central 
      fill(this.c);
      ellipse(this.x, this.y, this.r/10, this.r/10);
    }
  }
 
  /* Inner functions */
  int getItem(float angle, int nbItems) {
    int i=1;
    float delta = PI/nbItems;
    float alpha = 0.0;
    
    if (angle < 0)
      angle = angle + 2*PI - delta;
    
    //println("angle normalisé : " + angle);
    while (alpha < angle)
      {
        alpha = i*2*PI/nbItems - delta;
        i++;
      } 
     
    if (i > nbItems+1) 
      return(-1);
    else
      return(i-1);
  } 
}


/* *************************************************************
/* PieMenuIcon
 *
 *
 ***************************************************************/
 
class PieMenuIcon extends PieMenu {
  
  private ArrayList<PImage> P;
  PieMenuIcon() {
    super();
    this.P = new ArrayList();  
    this.items = P.size();
  }
  
  void add(String s) {
    this.P.add(loadImage(s));    
    this.items = P.size();
  }
     
  void update(int x, int y) {    
    if (this.state==true) { // afficher
      fill(this.c);
      noStroke();   
      ellipse(this.x, this.y, this.r, this.r);
      stroke(0);
      // calcul du nombre d'items à afficher
      this.items = P.size(); 
      
      // calcul angle position de la souris par rapport au centre    
      float theta = atan2(y-this.y, x-this.x); 
      
      // affichage du camembert
      float delta = PI/this.items; 
      
      float alpha;
      for (int i=0;i<this.items;i++)
      {
        alpha = i*2*PI/this.items - delta;
        line(this.x,this.y, this.x+this.r*cos(alpha),this.y+ this.r*sin(alpha));
      }      
      // affichage en inverse video de la bonne portion du camenbert (si la distance est < rayon)
      // println ("dist = " + sqrt(pow(x-this.x,2) + pow(y-this.y,2)) + " rayon = " + this.r/20); 
      if (sqrt(pow(x-this.x,2) + pow(y-this.y,2)) <= this.r/10)
        this.selected_item =-1;        
      else {
        this.selected_item = getItem(theta,this.items);
        fill(this.hc);
        arc(this.x, this.y, this.r, this.r, ((this.selected_item-1)*2*PI/this.items - delta),(this.selected_item*2*PI/this.items - delta));
      }                
      // affiche cercle épaisseur x pixels no rempli
      // noFill();
      // stroke(this.ic);
      // épaisseur 
      // ellipse(this.x,this.y, this.r-this.r/5, this.r-this.r/5);
      
      // affichage des icônes
      fill(0);
      imageMode(CENTER);
      
      for (int i=0;i<this.items;i++)
      {
        alpha = (i*2*PI/this.items + (i+1)*2*PI/this.items)/2 - delta;     
        image(this.P.get(i), this.x+(this.r/4)*cos(alpha), this.y+ (this.r/4)*sin(alpha));
      }
      // affiche cercle central 
      fill(this.c);
      ellipse(this.x, this.y, this.r/10, this.r/10);
    }
  }  
}