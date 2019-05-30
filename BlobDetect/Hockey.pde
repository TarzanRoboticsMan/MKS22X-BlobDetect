int radius = 50;
public class Pucker{
  int x,y,lastX,lastY;
  BlobInput input; 
  
  public Pucker(BlobInput newInput){
    input = newInput;
  }
  
  public void drawPucker(){
    fill(input.targColor);
    ellipse(x,y,radius,radius);
  }
}
