int ballX,ballY;
float speed; float rad;

public void drawBall(){
  fill(255);
  ellipse(ballX,ballY, diameter/2,diameter/2);
}
public float distance(float x1,float y1){
  float xDiff=ballX-x1;float yDiff=ballY-y1;
  return (float) Math.sqrt(xDiff*xDiff+yDiff*yDiff);
}
