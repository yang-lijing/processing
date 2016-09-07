float r=0;
float theta=0;

void setup(){
  size(600,400);
  background(255);
  smooth();
}

void draw(){
  float x=r*cos(theta);
  float y=r*sin(theta);
  noStroke();
  fill(5+30*theta,10+10*r,255-60*r);
  ellipse(x+width/2,y+height/2,16,16);
  theta+=0.05;
  r+=0.2;
}