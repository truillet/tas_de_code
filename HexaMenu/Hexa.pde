class Hexa {
  PFont _f;
  int _size;
  
  PShape h, original;
  float _scale;
  boolean _isClicked;
  
  PVector[] _forme = new PVector[7];
  int _x,_y; // coordonnées
  int _l; // largeur
  color _colorH;
  String _text;
  color _colorT;
  
  
  Hexa(int x, int y, int l, String texte) {
    this._x = x;
    this._y = y;
    this._l = l;
    this._size = 36;
    this._f = loadFont("Ambrosia36.vlw"); // fonte par défaut
    
    this._colorH = color(82,57,247,180);
    this._text = texte;
    this._colorT = color(#F2FC6B);
    this._isClicked = false;
    
    // Define the shape
    _forme[0] = new PVector(_l*cos(PI/6), _l*sin(PI/6));
    _forme[1] = new PVector(0, _l);
    _forme[2] = new PVector(-_l*cos(PI/6), _l/2);
    _forme[3] = new PVector(-_l*cos(PI/6), -_l/2);
    _forme[4] = new PVector(0,-_l);
    _forme[5] = new PVector(_l*cos(PI/6), -_l/2);
    _forme[6] = new PVector(_l*cos(PI/6), _l*sin(PI/6));
    
    // create a new hexa from PVectors
    h = recreateShape(_forme);
  }
  
  void update() {
     h.setFill(this._colorH);
    shape(this.h,this._x,this._y);
    fill(this._colorT);
    textAlign(CENTER,CENTER);
    textAlign(CENTER,CENTER);
    textFont(this._f);
    textSize(this._size);
    text(this._text,this._x,this._y);
  }
  
  void update(int x, int y) { // move the form at the current position
    this._x = x;
    this._y = y;
    this.update();
  }
  
  
 /* different useful functions */ 
  boolean onClick(int x, int y) {
    if(containsPoint(_forme,x-this._x,y-this._y)) {
      this._isClicked = true; // clic is on
      h.scale(0.8); // apply scale
      return true;
    }
   return false; 
  }
  
  void onRelease(int x, int y) {
    if((containsPoint(_forme,x-this._x,y-this._y)) && (this._isClicked == true)) {  
      // remettre l'original
      _isClicked = false;      
    }
    h = recreateShape(_forme);
  }
  
 void setFont(String font) {
   this._f = loadFont(font);
 }
 
 void setSize(int size) {
   this._size = size;
 }
  
 void setText(String t) {
 }
 
 String getText() {
   return(this._text);
 }
 
 void setColorH(color c) {   
   this._colorH = c;
 }
 void setColorT(color c) {   
   this._colorT = c;
 }
 
boolean containsPoint(PVector[] verts, float px, float py) {
  int num = verts.length;
  int i, j = num - 1;
  boolean oddNodes = false;
  for (i = 0; i < num; i++) {
    PVector vi = verts[i];
    PVector vj = verts[j];
     if (vi.y < py && vj.y >= py || vj.y < py && vi.y >= py) {
       if (vi.x + (py - vi.y) / (vj.y - vi.y) * (vj.x - vi.x) < px) {
         oddNodes = !oddNodes;
       }
     }
     j = i;
   }
   return oddNodes;
  }
  
  PShape recreateShape(PVector[] _f) {
    PShape h = createShape();   
    h.beginShape();
    for(PVector v : _f) {
      h.vertex(v.x,v.y);
    }
    h.endShape(CLOSE);
    return(h);
  }
}