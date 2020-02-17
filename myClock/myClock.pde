/*
 * Clock sample
*/
Clock horloge;

void setup() {
  size(640,480);
  horloge = new Clock(width/2,height/2);
}

void draw() {
  background(0);
  horloge.update();
}
