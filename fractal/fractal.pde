void setup(){
  size(400,200);
 
}
void draw(){
  background(255);
  stroke(0);
  line(0,0,200,200);
  line(200,200,400,0);
  branch(width/2,height);
}

void branch(float x,float y){
  line(x,0,x-y/2,y/2);
  line(x,0,x+y/2,y/2);
  if(y>10){
    branch(x-y/2,y/2);
    branch(x+y/2,y/2); 
  }
}