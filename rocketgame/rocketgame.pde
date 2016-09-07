//press the "up""down""left""right""enter" key;
float r=0.001;
float angle=PI;
Mover mover;

void setup(){
  size(600,400);
  background(255);
  smooth();
  mover=new Mover();
}

void draw(){
  background(255);
  mover.update();
  mover.display();
  mover.checkedges();
}
void keyPressed(){
        if(key==CODED){
          if(keyCode==Z){
            mover.update2();
          }else if(keyCode==LEFT){
           angle=angle-0.05;
          }else if(keyCode==RIGHT){
            angle=angle+0.05;
          }
        }else{
           mover.update2();;
          }
  }
class Mover{
    PVector location;
    PVector velocity;
    PVector acceleration;
    float l;
    Mover(){
      acceleration=new PVector(0.0001*sin(PI),0,0001*cos(PI));
      velocity=new PVector(0,0);
      location=new PVector(width/2,height/2);
    }
    void update(){
            velocity.add(acceleration);
            location.add(velocity);
    }
    void update2(){
            velocity=new PVector(sin(-angle),cos(-angle));
            velocity.mult(2);
            acceleration=new PVector(r*sin(PI-angle),r*cos(PI-angle));
            velocity.add(acceleration);
            location.add(velocity);
    }
    void display(){
         stroke(0);
         fill(0);
         pushMatrix();
         translate(location.x,location.y);
         rotate(angle);
         beginShape();
         vertex(0,10);
         vertex(-10,-10);
         vertex(-8,-13);
         vertex(8,-13);
         vertex(10,-10);
         endShape();
         popMatrix();
    }
    void checkedges(){
      if(location.x>width){
        location.x=location.x-width;
      }
      if(location.x<0){
        location.x=location.x+width;
      }
      if(location.y>height){
        location.y=location.y-height;
      }
      if(location.y<0){
        location.y=location.y+height;
      }
    }
}