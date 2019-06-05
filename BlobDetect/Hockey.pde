float diameter = 50.0;
public class Pucker{
  int x,y,lastX,lastY;
  BlobInput input; 
  
  public Pucker(BlobInput newInput){
    input = newInput;
  }
  
  public void update(){
    lastX=x;lastY=y;
    x=(int)input.getX();y=(int)input.getY();
  }
  public void drawPucker(){
    fill(input.targColor);
    ellipse(x,y,diameter,diameter);
  }
}

int goalH; int goalW;
public void drawGoals(){
  fill(255); rectMode(CORNER);
  rect(0,(height-goalH)/2,goalW,goalH);
  rect(width-goalW,(height-goalH)/2,goalW,goalH);
}
