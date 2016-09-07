PImage img;
int scale=16;
int cols,rows;
String chars="LearningPassion Parametric Teamwork Hardworking Rhino InDesign Grasshopper ";
PFont f;
float fontSize;
void setup(){
  size(1400,725);
  img=loadImage("fengmian (2).jpg");
  background(255);
  smooth();
  cols=width/scale;
  rows=height/scale;
  f=createFont("AdobeDevanagari",10,true);
}

void draw(){
   int charcount=0;
  for(int j=0;j<rows;j++){
    for(int i=0;i<cols;i++){
      int x=i*scale;
      int y=j*scale;
      int loc=x+y*img.width;
      color c=img.pixels[x+y*img.width];
      float fontSize=(brightness(c)/255.0)*scale*0.8;
      float r=red(img.pixels[loc]);
      float g=green(img.pixels[loc]);
      float b=blue(img.pixels[loc]);
      fill(c);
      stroke(200);
      text(chars.charAt(charcount),x,y);
      charcount=(charcount+1) % chars.length();
      textFont(f,(1.2*fontSize+10));
    }
  }
}