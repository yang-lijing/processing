PImage img;
int pointillize=8;

void setup(){
  size(600,400);
  img=loadImage("1122.jpg");
  background(0);
  smooth();
}

void draw(){
  int x=int(random(img.width));
  int y=int(random(img.height));
  int loc=x+y*img.width;
  float r=red(img.pixels[loc]);
  float g=green(img.pixels[loc]);
  float b=blue(img.pixels[loc]);
  noStroke();
  
  fill(r,g,b,100);
  rect(x,y,pointillize/2,pointillize/2);
}