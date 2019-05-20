import processing.video.*;
Capture cam;

void setup() {
  size(600, 300); //320, 240
  cam = new Capture(this, 320, 240, 30); //Minimum H/W seems to be 79/2 before weird error appears
  cam.start();
}

void draw() {
  if(cam.available()) {
    cam.read();
  }
  image(cam, 0,0);//random(width), random(height));
}
