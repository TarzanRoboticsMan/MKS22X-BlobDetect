import processing.video.*;
Capture cam;
boolean recolor,hockeyTime;
ArrayList<BlobInput> inputs;
float s,b,h; char mode;

void setup() {
  size(640, 480);//size(320, 240);
  cam = new Capture(this, width, height, 30); //320, 240//Minimum H/W seems to be 79/2 before weird error appears
  cam.start();
  inputs = new ArrayList<BlobInput>();
  inputs.add(new BlobInput()); inputs.add(new BlobInput());
  h=15.0;s=2.0;b=3.0;
}

void adjust(int x){
  if(mode=='h') h+=x*1.0;
  else if(mode=='s') s+=x*0.1;
  else if(mode=='b') b+=x*0.1;
  println("h: "+h + " s: "+s + " b: "+b);
}

void keyPressed() {
  if (key == 'a') recolor=!recolor;//System.out.println(input1.size());
  if (key == 'h' || key == 's' || key == 'b') mode = key; //Change filter value to adjust
  if (key == '[') adjust(-1); if (key == ']') adjust(1);  //Adjust value stored in mode
  if (key == ' ') {
    inputs.get(0).targeting=true;
    inputs.get(0).millis = millis();
  }
  if (key == '0'|| key == '1') {
    int index=0; if(key == '1') index=1;
    inputs.get(index).targeting=true;
    inputs.get(index).millis = millis();
  }
}

void drawSearching(){
  stroke(255); noFill();
  ellipse(width/2,height/2, 10,10);
  stroke(0); fill(255);
}
void drawAcquired(BlobInput input){
  colorMode(HSB);
  noStroke(); fill(input.targHue,saturation(input.targColor),255);
  ellipse(width/2,height/2,15,15);
  fill(input.targColor);
  ellipse(width/2,height/2,10,10);
}

void recolor(){
  for(int x = 0;x<width;x++){
    for(int y = 0; y<height; y++){
      if(isTarget(x,y,inputs.get(0))||isTarget(x,y,inputs.get(1))) set(x,y,color(0));
      else set(x,y,color(255));
    }
  }
}
  

void draw() {
  if(cam.available()) {
    cam.read();
  }
  pushMatrix(); //Invert image so it appears normal
  scale(-1,1);
  image(cam, -width,0);
  popMatrix(); //Back to normal for drawing purposes
  for(int i=0;i<inputs.size();i++){
    if(inputs.get(i).targeting){
      drawSearching();//see through inner circle
      if(Math.abs(inputs.get(i).millis-millis())>500){
        if(inputs.get(i).targeting) {
          inputs.remove(i); inputs.add(i, new BlobInput());
          inputs.get(i).millis=millis();
        }
      }
    }
  }
  
  if(recolor)recolor();
  
  for(int i=0;i<inputs.size();i++){
    if(!inputs.get(i).targeting && Math.abs(inputs.get(i).millis-millis())<1000){
    drawAcquired(inputs.get(i));
    }
    inputs.get(i).size();
  }
  
  if(hockeyTime){
  }
}

boolean isTarget(int x, int y, BlobInput input){
  int data = get(x,y); float  hueDiff = Math.abs(hue(data)-input.targHue);
  return (hueDiff<h || 359-hueDiff<h )&& //accounts for hue diff accros the 360 mark
         saturation(data)>saturation(input.targColor)/s && //isTarget if at least 1/s as saturated
         brightness(data)>brightness(input.targColor)/b; //if at least 1/b as bright
} //<>//
