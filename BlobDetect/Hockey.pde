int diameter = 50;
int ballX,ballY;
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

//public void
