/* fabriquer une cible bouton */

class Cible
{
  int x, y;
  int size;
  color baseGray;
  color outline;
  boolean checked = false;
  color filled;
  PImage p; 
  
  // two colors
  color selectedColor;
  color replacedColor;
  
  
  Cible(int s)
  {
    size = s;
    selectedColor = color(0,0,0,0);
    replacedColor = color(0,0,0,0);
  }
  
  color pickColor(float mx, float my)
  { 
    replacedColor = get((int) mx+size/2,(int) my+size/2); // actual center of target cursor
    return(replacedColor);
  }
  
  PImage press(float mx, float my)
  {
    if ((mx >= x) && (mx <= x+size) && (my >= y) && (my <= y+size))
    {
      p = get((int) mx+size/2,(int) my+size/2, size/4, size/4);
      selectedColor = get((int) mx+size/2,(int) my+size/2);
    }    
    return(p);
  }
  
  void display(int x,int y)
  {
    this.x = x;
    this.y = y;
    
    stroke(255);
    noFill();

    // form
    rect(x,y, size, size);
    line(x+size/2,y-size/4,x+size/2,y+size/4);
    line(x+size/2,y+size-size/4,x+size/2,y+size+size/4);
    line(x-size/4,y+size/2,x+size/4,y+size/2);
    line(x+size-size/4,y+size/2,x+size+size/4,y+size/2);
  }
  
  boolean getState()
  {
    return(this.checked);
  }
  
  color getSelectedColor()
  {
    return(this.selectedColor);
  }
  
  color getReplacedColor()
  {
    return(this.replacedColor);
  }
  
  // setFill(color c)
  // color getFill(c)
}
