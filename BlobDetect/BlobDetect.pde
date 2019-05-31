import processing.video.*;
Capture cam;
boolean targeting,recolor; int millis;
BlobInput input;
float s,b,h; char mode;

void setup() {
  size(320, 240);
  cam = new Capture(this, width, height, 30); //320, 240//Minimum H/W seems to be 79/2 before weird error appears
  cam.start();
  input = new BlobInput();
  h=15.0;s=2.0;b=3.0;
}

void adjust(int x){
  if(mode=='h') h+=x*1.0;
  else if(mode=='s') s+=x*0.1;
  else if(mode=='b') b+=x*0.1;
  println("h: "+h + " s: "+s + " b: "+b);
}

void keyPressed() {
  if (key == 'a') recolor=!recolor;//System.out.println(input.size());
  if (key == 'h' || key == 's' || key == 'b') mode = key; //Change filter value to adjust
  if (key == '[') adjust(-1); if (key == ']') adjust(1);  //Adjust value stored in mode
  if (key == ' ') {
    targeting=true;
    millis = millis();
  }
}

void drawSearching(){
  stroke(255); noFill();
  ellipse(width/2,height/2, 10,10);
  stroke(0); fill(255);
}
void drawAcquired(){
  colorMode(HSB);
  noStroke(); fill(input.targHue,saturation(input.targColor),255);
  ellipse(width/2,height/2,15,15);
  fill(input.targColor);
  ellipse(width/2,height/2,10,10);
}

void recolor(){
  for(int x = 0;x<width;x++){
    for(int y = 0; y<height; y++){
      if(isTarget(x,y)) set(x,y,color(0));
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
  if (targeting){
    drawSearching();//see through inner circle
    if(Math.abs(millis-millis())>500){
      input = new BlobInput(); targeting = false; millis=millis();
    }
  }
  if(recolor)recolor();
  
  if(!targeting && Math.abs(millis-millis())<1000){
    drawAcquired();
  }
}
boolean isTarget(int x, int y){
  int data = get(x,y); int  hueDiff = Math.abs(hue(data)-input.targHue);
  return (hueDiff<h || 359-hueDiff<h )&& //accounts for hue diff accros the 360 mark
         saturation(data)>saturation(input.targColor)/s && //isTarget if at least 1/s as saturated
         brightness(data)>brightness(input.targColor)/b; //if at least 1/b as bright
}

void play(){
  color c1 = color(204, 153, 0);
  color c2 = #FFCC00; //<>//
  noStroke();
  fill(c1);
  rect(0, 0, 25, 100);
  fill(c2);
  rect(25, 0, 25, 100);
  color c3 = get(10, 50);
  fill(c3);
  rect(50, 0, 50, 100);
  
  color c;  // Declare color 'c'
  noStroke();  // Don't draw a stroke around shapes
  
  // If no colorMode is specified, then the
  // default of RGB with scale of 0-255 is used.
  c = color(50, 55, 100);  // Create a color for 'c'
  fill(c);  // Use color variable 'c' as fill color
  rect(0, 10, 45, 80);  // Draw left rect
  
  colorMode(HSB, 100);  // Use HSB with scale of 0-100
  c = color(50, 55, 100);  // Update 'c' with new color
  fill(c);  // Use updated 'c' as fill color
  rect(55, 10, 45, 80);  // Draw right rect
  
  //Garbage initalization code
  while(!cam.available()) delay(10);//Wait for cam available
  for(int x=0;x<100;x++){
    cam.read(); image(cam,0,0); //Paint the background
    delay(10);
  }
  //setTarget(); //Use the display to pull targColor
}
