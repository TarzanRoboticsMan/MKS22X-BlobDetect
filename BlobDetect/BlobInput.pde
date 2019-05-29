public class BlobInput{
  private float x,y;
  public final color targColor; 
  public final float targHue;
  
  public BlobInput(){
    targColor = get(width/2,height/2);
    targHue = hue(targColor);
    System.out.println(this);
  }
  
  public String toString(){
    return "\n"+ "   hue: "+(int)targHue 
          +"\n"+ "   sat: "+(int)saturation(targColor) 
          +"\n"+ "bright: "+(int)brightness(targColor);
  }
  public float getX(){return x;}
  public float getY(){return y;}
  /*public String getColor(){return hex(targColor);}
  public float getHue(){return targHue;}*/
}
