import processing.video.*;
Capture cam;
color targColor; float targHue;
boolean targeting; int sec;

void setup() {
  size(320, 240);
  cam = new Capture(this, width, height, 30); //320, 240//Minimum H/W seems to be 79/2 before weird error appears
  cam.start();
}

void keyPressed() {
  if (key != ' ') return;
  targeting=true;
  sec = second();
}

void drawTarget(){
  stroke(255); noFill();
  ellipse(width/2,height/2, 10,10);
  stroke(0,1.0); fill(255);
}

void setTarget(){
  //Set up color variables
  targColor = get(width/2,height/2);
  targHue = hue(targColor);
  System.out.println("hue "+targHue); 
  System.out.println("sat "+saturation(targColor)); System.out.println("bright "+brightness(targColor));
}

void draw() {
  if(cam.available()) {
    cam.read();
  }
  image(cam, 0,0);
  if (targeting){
    drawTarget();
    if(Math.abs(sec-second())>1){
      setTarget(); targeting = false;
    }
  }
  //isTarget(0,0);
}

boolean isTarget(int x, int y){
  color data = get(x,y);
  return Math.abs(hue(data)-targHue)<30;
}

void play(){
  color c1 = color(204, 153, 0);
  color c2 = #FFCC00;
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
  setTarget(); //Use the display to pull targColor
}
