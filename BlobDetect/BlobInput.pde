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
  
  public int size(){
    //loadPixels();
    if (isTarget((x,y)) return 1 + size(x+1,y)
                                + size(x+1,y+1)
                                + size(x+1,y+1
  }
  private int sizeUR(x,y){
    if (isTarget(x,y)) return 1 + sizeUR(x+1,y)
                                + sizeUR(x+1,y+1)
                                + sizeUR(x,y+1)
                                + sizeUR(x-1,y+1);
    return 0;
  }
  private int sizeDL(x,y){
    if (isTarget(x,y)) return 1 + sizeUR(x+1,y)
                                + sizeUR(x+1,y+1)
                                + sizeUR(x,y+1)
                                + sizeUR(x-1,y+1);
    return 0;
  }
}
