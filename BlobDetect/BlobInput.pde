class BlobInput{
  private float x,y;
  public color targColor; 
  public float targHue;
  boolean targeting; int millis;
  public Pucker puck;
  
  public BlobInput(){
    targColor = get(width/2,height/2);
    targHue = hue(targColor);
    System.out.println(this);
    x=width/2; y=height/2;
    puck = new Pucker(this);
  }
  
  public String toString(){
    return "\n"+ "   hue: "+(int)targHue 
          +"\n"+ "   sat: "+(int)saturation(targColor) 
          +"\n"+ "bright: "+(int)brightness(targColor);
  }
  public float getX(){return x;}
  public float getY(){return y;}
  /*public color targColor(){return new color(hue(targColor),saturation(targColor),brightness(targColor));}
  public float targHue(){return targHue;}*/
  
  public int size(){
    //loadPixels();
    int xTot=0; int yTot=0; int ans=1; //to avoid division by 0
    for(int xx=0; xx<width;xx++){
      for(int yy=0; yy<height;yy++){
        if (isTarget(xx,yy,this)){
          xTot+=xx; yTot+=yy; ans++;
        }
      }
    }
    if(Math.abs(xTot/ans-x)>20) x=(2*x+xTot/ans)/3;
    else x=xTot/ans;
    if(Math.abs(xTot/ans-x)>20) x=(2*x+xTot/ans)/3;
    else y=yTot/ans;
    /*targColor = get((int)x,(int)y);
    targHue = hue(targColor);*/
    return ans;
  }
  private int sizeUR(int x, int y){ //dead methods
    if (isTarget(x,y,this)) return 1 + sizeUR(x+1,y)
                                //+ sizeUR(x+1,y+1)
                                + sizeUR(x,y+1);
                                //+ sizeUR(x-1,y+1);
    return 0;
  }
  private int sizeDL(int x, int y){  //dead methods
    if (isTarget(x,y,this)) return 1 //+ sizeDL(x+1,y-1)
                                + sizeDL(x,y-1)
                                //+ sizeDL(x-1,y-1)
                                + sizeDL(x-1,y);
    return 0;
  }
}
