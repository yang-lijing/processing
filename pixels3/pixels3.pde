PImage img;
int scale=4;
int cols,rows;

void setup(){
  size(658,439);
  img=loadImage("1.jpg");
  background(255);
  smooth();
  cols=width/scale;
  rows=height/scale;
}

void draw(){
  for(int i=0;i<cols;i++){
    for(int j=0;j<rows;j++){
      int x=i*scale;
      int y=j*scale;
      //int loc=x+y*img.width;
      color c=img.pixels[x+y*img.width];
      float sz=(brightness(c)/255.0)*scale;
      fill(c);
      noStroke();
      ellipse(x,y,sz,sz);
    }
  }
}