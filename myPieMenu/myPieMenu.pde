PieMenu pm;
PieMenuIcon pmi1;

int item; 
int FSM; // Finite Sate Machine

void setup() {
  size(600,600);
  pm = new PieMenu();
  pm.add("choice 1");
  pm.add("choice 2");
  pm.add("choice 3");
  pm.add("choice 4");
  pm.add("choice 5");
  pm.add("choice 6");
  pm.setRadius(250);
  //pm.setColors(color(74,229,215),color(201,237,234,120));
  pm.setColors(color(74,229,215),color(255,0,0,120));
  
  pmi1 = new PieMenuIcon();
  pmi1.add("Beverage-Alcohol-48.png");
  pmi1.add("Beverage-Beer-02-48.png");
  pmi1.add("Beverage-Juice-03-48.png");  
  pmi1.add("Beverage-Coffee-02-48.png");       
  pmi1.setRadius(250);  
  pmi1.setInnerColor(color(245,188,42));
  
  pm.setState(true, 250, 250);
  item = -1;
}

void draw() {
  background(0);
  println(FSM);
  
  switch (FSM) {
    case 1: // Strating screen
      pm.update(mouseX,mouseY);
      println("Pie Menu displayed");
      break;
      
    case 2 : // 2nd screen
      pmi1.update(mouseX,mouseY);
      break;
      
    default: 
      println("Nothing");
      break;
  }
}

void mousePressed() {

}

void mouseReleased() {
  switch(FSM)  {
     case 1: 
       item=pm.setState(false, 250, 250);
       switch(item) {
          case 1 : 
            FSM=2;
            pmi1.setState(true, 250, 250);
            
            break;
          default:
            FSM=1;
            pm.setState(true, 250, 250);
            break;
       }
       break;
       
      case 2: 
        item=pmi1.setState(true, 250, 250);
        FSM = 1;
        break;
        
      default:
        pmi1.setState(false, 250, 250);
        pm.setState(true, 250, 250);
        FSM = 1;
        break; 
  }
}
