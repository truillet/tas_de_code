/* Java swing in Processing */

import javax.swing.JOptionPane;
 
String value;

void setup(){
  size(480,120);
}

void draw(){
  background(0);    
 }
 
void mousePressed(){
  value = JOptionPane.showInputDialog("Entrez une valeur : ");
  float v=parseFloat(value);
  println("Valeur flottante :" + v);
}
