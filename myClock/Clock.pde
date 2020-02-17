/***************************************************************
 * Clock, "futurist design" 
 * 
 *
 * (c) Philippe Truillet 2018
 * Last revision: 21/12/2018
 *
 ***************************************************************/
 
import java.util.*;

class Clock
{
  //colors
  // font
  private Calendar cal;
  private int x,y;
  private int size;
  private PFont f_hour,/*f_minute*/;
  private color b1,b2;
  
  Clock(int x, int y)
  {
    this.x = x;
    this.y = y;
    this.b1 = color(19,203,255);
    this.b2 = color(10,170,202);
    this.size = 240;
   
    f_hour = loadFont("hour32.vlw");
  }
  
 private String getDatebyType(int type)
 {
   String res = "";
   int n = cal.get(type);
   if (n < 10)
   {
     res = "0"+n;
   }
  else res = ""+n;
 
   return(res); 
 }
 
 private void drawPattern(float min, float sec)
 {
    noFill();
    // set color + 
    stroke(b1);
    strokeWeight(6);
    ellipse(x,y, size/2,size/2);
    strokeWeight(8);
    //
    arc(x,y, size/2 - 32, size/2 -32, (min/60)*2*PI +PI + HALF_PI,  (min/60)*2*PI + PI + HALF_PI + 0.4);
    strokeWeight(2);
    arc(x,y, size/2 - 60, size/2 -60, 0,  PI);
    
    stroke(b2);
    strokeWeight(4);
    arc(x,y, size/2-10, size/2-10, (sec/60)*2*PI + PI + HALF_PI,  (sec/60)*2*PI + PI + HALF_PI + 0.4);
    ellipse(x,y, size/2-18,size/2-18);
    arc(x,y, size/2 - 45, size/2 -45, 0.1,  1.0);
    strokeWeight(2);
    arc(x,y, size/2 - 50, size/2 -50, -0.4,  PI+HALF_PI-0.2);
 }
 
  void update()
  {    
    // draw hour
    fill(b1);
    textFont(f_hour,32);         
    this.cal = Calendar.getInstance();
    cal.getTime();
    
    text(getDatebyType(Calendar.HOUR_OF_DAY),x-2,y-10);
    noFill();
    textFont(f_hour,18);
    text(getDatebyType(Calendar.MINUTE),x-20,y+10);
    textFont(f_hour,12);
    text(getDatebyType(Calendar.SECOND), x+5,y+10);
    noFill();
    drawPattern((float) cal.get(Calendar.MINUTE), (float) cal.get(Calendar.SECOND));
   }
 
}
