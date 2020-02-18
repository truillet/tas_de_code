/*
 *  virtual_keyboard -> 
 * v. 1.0
 * 
 * (c) Ph. Truillet, April 2016
 * Last Revision: 20/04/2016
 */
 
import fr.dgac.ivy.*;

Ivy bus;
boolean received;
ArrayList <Key> k = new ArrayList<Key>();
Key touche;

String machaine, prediction;

void setup() {
  size(600,500);
  
  genere_clavier();
  machaine ="";
  prediction="";
  
  received = false;
  try {
    bus = new Ivy("VK", "VK is ready", null);
    bus.start("127.255.255.255:2010");
    
    bus.bindMsg("^VKPredictor String=(.*) Prediction=(.*)", new IvyMessageListener()
    {
      public void receive(IvyClient client,String[] args)
      {
        received = true;       
        prediction = args[1];        
      }        
    });    
  }
  catch (IvyException ie)  { }
}

void draw() {
  background(0);
  
  for (int i=0; i< k.size();i++)
  {    
    (k.get(i)).update();
  }
  textAlign(LEFT);
  
  fill(255);
  text("Chaîne tapée :", 50,350);
  text("Chaîne prédite :", 50,400);
  fill(#68A1CE);
  text(machaine, 210,350);
  fill(#E0618A);
  text(prediction, 210,400);
}


void mousePressed() {
  for (int i=0; i< k.size();i++)
  {    
    machaine= machaine + (k.get(i)).onPress();
  }
  // send data
  try {
      bus.sendMsg("VKPredictor String="+machaine);
  }
  catch (IvyException ie)  { }
}

void mouseReleased() {
  for (int i=0; i< k.size();i++)
  {    
    (k.get(i)).onRelease();
  }
}


void genere_clavier() {
  touche = new Key(50,50,"A");
  touche.setPosition(10,100);
  k.add(touche);  
  touche = new Key(50,50,"Z");
  touche.setPosition(61,100);
  k.add(touche);  
  touche = new Key(50,50,"E");
  touche.setPosition(112,100);
  k.add(touche);  
  touche = new Key(50,50,"R");
  touche.setPosition(163,100);
  k.add(touche);  
  touche = new Key(50,50,"T");
  touche.setPosition(214,100);
  k.add(touche); 
  touche = new Key(50,50,"Y");
  touche.setPosition(265,100);
  k.add(touche); 
  touche = new Key(50,50,"U");
  touche.setPosition(316,100);
  k.add(touche); 
  touche = new Key(50,50,"I");
  touche.setPosition(367,100);
  k.add(touche); 
  touche = new Key(50,50,"O");
  touche.setPosition(418,100);
  k.add(touche); 
  touche = new Key(50,50,"P");
  touche.setPosition(469,100);
  k.add(touche);   
  
  touche = new Key(50,101,"EN\nTER");
  touche.setPosition(530,100);
  k.add(touche); 
  
  // 2ème ligne
  touche = new Key(50,50,"Q");
  touche.setPosition(20,151);
  k.add(touche); 
  touche = new Key(50,50,"S");
  touche.setPosition(71,151);
  k.add(touche); 
  touche = new Key(50,50,"D");
  touche.setPosition(122,151);
  k.add(touche); 
  touche = new Key(50,50,"F");
  touche.setPosition(173,151);
  k.add(touche);
  touche = new Key(50,50,"G");
  touche.setPosition(224,151);
  k.add(touche); 
  touche = new Key(50,50,"H");
  touche.setPosition(275,151);
  k.add(touche);
  touche = new Key(50,50,"J");
  touche.setPosition(326,151);
  k.add(touche); 
  touche = new Key(50,50,"K");
  touche.setPosition(377,151);
  k.add(touche);
  touche = new Key(50,50,"L");
  touche.setPosition(428,151);
  k.add(touche); 
  touche = new Key(50,50,"M");
  touche.setPosition(479,151);
  k.add(touche);  
  
 // 3ème ligne
  touche = new Key(50,50,"W");
  touche.setPosition(30,202);
  k.add(touche); 
  touche = new Key(50,50,"X");
  touche.setPosition(81,202);
  k.add(touche); 
  touche = new Key(50,50,"C");
  touche.setPosition(132,202);
  k.add(touche); 
  touche = new Key(50,50,"V");
  touche.setPosition(183,202);
  k.add(touche);
  touche = new Key(50,50,"B");
  touche.setPosition(234,202);
  k.add(touche); 
  touche = new Key(50,50,"N");
  touche.setPosition(285,202);
  k.add(touche);  
}