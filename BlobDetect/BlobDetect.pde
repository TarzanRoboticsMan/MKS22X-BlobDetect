import processing.video.*;
Capture cam;
boolean recolor;
ArrayList<BlobInput> inputs;
float s,b,h; char mode;

void setup() {
  size(320, 240);
  cam = new Capture(this, width, height, 30); //320, 240//Minimum H/W seems to be 79/2 before weird error appears
  cam.start();
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
    inputs.get((int)key).targeting=true;
    inputs.get((int)key).millis = millis();
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
  if (input1.targeting||input2.targeting){
    drawSearching();//see through inner circle
    if(Math.abs(millis-millis())>500){
      if(input1.targeting) {
        input1 = new BlobInput();
        input1.targeting = false;
        input1.millis=millis();
      }
      if(input2.targeting) input2 = new BlobInput(); 
      input1.targeting = false; input2.targeting = false; input1.millis=millis(); 
    }
  }
  if(recolor)recolor();
  
  if(!input1.targeting && Math.abs(input1.millis-millis())<1000){
    drawAcquired(input1);
  }
  if(!input2.targeting && Math.abs(input2.millis-millis())<1000){
    drawAcquired(input2);
  }
  input.size();
  fill(255,0,0);  ellipse(input.getX(),input.getY(),5,5);
}
boolean isTarget(int x, int y, BlobInput input){
  int data = get(x,y); float  hueDiff = Math.abs(hue(data)-input.targHue);
  return (hueDiff<h || 359-hueDiff<h )&& //accounts for hue diff accros the 360 mark
         saturation(data)>saturation(input.targColor)/s && //isTarget if at least 1/s as saturated
         brightness(data)>brightness(input.targColor)/b; //if at least 1/b as bright
} //<>//
