import processing.video.*;
Capture cam;
color targColor;

void setup() {
  size(320, 240);
  cam = new Capture(this, width, height, 30); //320, 240//Minimum H/W seems to be 79/2 before weird error appears
  cam.start();
  targColor = color(254,0,0);
  System.out.println(targColor);
}

void draw() {
  if(cam.available()) {
    cam.read();
  }
  image(cam, 0,0);
  isTarget(0,0);
}

boolean isTarget(int x, int y){
  fill(get(x,y));
  ellipse(10, 10,10,10);
  return true;
}
