/* Gestion de Menu sous forme hexagonale 
 *
 *
 *
 *
 */
 
ArrayList<Hexa> Menu;


void setup() {
  size(300,300);
  
  // Création de Menu
  Menu = new ArrayList();
  
  Hexa h = new Hexa(80, 80, 80, "Play");
  Menu.add(h); 
  h = new Hexa(150, 200, 80, "Quit");
  Menu.add(h); 
  h = new Hexa(220, 80, 80, "Credits");
  Menu.add(h);   
}

void draw() {
 background(0); 
 for (int i = 0; i<Menu.size();i++)
   (Menu.get(i)).update();
}

void mousePressed() {
  for (int i = 0; i<Menu.size();i++)
   if ((Menu.get(i)).onClick(mouseX,mouseY) == true) {
     if (i==1) // Quitter
       System.exit(0);
   }
}

void mouseReleased() {
  for (int i = 0; i<Menu.size();i++)
   (Menu.get(i)).onRelease(mouseX,mouseY);
}
