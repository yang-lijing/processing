float xtime=0.0;
float ytime=100.0;
float increment=0.01;

void setup(){
  size(200,200);
  smooth();
}
void draw(){
  background(0);
  float x=noise(xtime)*width;
  float y=noise(ytime)*height;
  xtime+=increment;
  ytime+=increment;
  
  fill(200);
  ellipse(x,y,10,10);
}