
ChangeCompteur cc;
Compteur c;
Slogan s;
int v;

void setup() {
  
  size(350,300);
  cc = new ChangeCompteur(100450L,10); // change value each 10 secondes
  c = new Compteur(cc.getValue());
  s= new Slogan("28","28 days in February 2018");
  
  c.setCoord(50,25);
  s.setCoord(150,200);
  v=100450;
}

void draw() {
  background(0);
  
  c.setValue((int) cc.getValue());
  c.update();
  s.update();
  println(v);
}
