ArrayList<Boid> boids;
Flock flock;
FlowField flow;

void setup(){
  size(1300,700);
  flock=new Flock();
  flow=new FlowField();
  boids=new ArrayList<Boid>(50);
  for(int i=0;i<50;i++){
    Boid b=new Boid(random(600,1000),random(300,400));
    flock.addBoid(b);
  }
}

void draw(){
  background(255);
  flock.run();
  flock.skip1();
}


class FlowField{
  PVector[][]field;
  int cols,rows;
  int resolution;
  
  FlowField(){
    resolution=10;
    cols=width/resolution;
    rows=height/resolution;
    field=new PVector[cols][rows];
    init();
  }
  void init(){
   float xoff=0;
   for(int i=0;i<cols;i++){
     float yoff=0;
     for(int j=0;j<rows;j++){
       float angle=map(noise(xoff,yoff),0,1,0,TWO_PI);
       field[i][j]=new PVector(cos(angle),sin(angle));
       yoff+=0.1;
     }
     xoff+=0.1;
   }
  }
  PVector lookup(PVector lookup){
    int column=int(constrain(lookup.x/resolution,0,cols-1));
    int row=int(constrain(lookup.y/resolution,0,rows-1));
    return field[column][row];
  }
}

class Flock{
  ArrayList<Boid> boids;
  
  Flock(){
    boids=new ArrayList<Boid>(); 
  }
  
  void run(){
    for(Boid b:boids){
     b.behave(boids); 
     b.update();
     b.display();
     b.checkedges();
    }
  }
  
  void addBoid(Boid b){
   boids.add(b); 
  }
  void skip1(){
    for(Boid b:boids){
      b.skip(new PVector(mouseX,mouseY));
    }
  }
}

class Boid{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxspeed;
  float maxforce;
  PVector target;
  
  Boid(float x,float y){
    acceleration=new PVector(0,0);
    velocity=new PVector(0,0);
    location=new PVector(x,y);
    target=new PVector(0,0);
    r=3.0;
    maxspeed=2.5;
    maxforce=0.05;
  }
  
void behave(ArrayList<Boid> boids){
   //ArrayList<Boid> boids;
   PVector sep=separate(boids);
   PVector ali=align(boids);
   PVector coh=cohesion(boids);
   PVector seek=seek(new PVector(mouseX,mouseY));
   
   sep.mult(0.3);
   ali.mult(0.2);
   coh.mult(0.1);
   seek.mult(0.4);
   
   applyForce(sep);
   applyForce(ali);
   applyForce(coh);
   applyForce(seek);
}

void follow(FlowField flow){
  PVector desired=flow.lookup(location);
  desired.mult(maxspeed);
  PVector steer=PVector.sub(desired,velocity);
  steer.limit(maxforce);
  steer.mult(0.5);
  applyForce(steer);
}
  
void applyForce(PVector force){
  acceleration.add(force);
}

PVector seek(PVector target){
  PVector desired=PVector.sub(target,location);
  desired.normalize();
  desired.mult(2*maxspeed);
  PVector steer=PVector.sub(desired,velocity);
  steer.limit(maxforce);
  return steer;
}

void skip(PVector target){
  PVector desired=PVector.sub(location,target);
  desired.normalize();
  desired.mult(2*maxspeed);
  PVector steer=PVector.add(velocity,desired);
  steer.limit(0.2);
  if (mousePressed){
  applyForce(steer);
  }
}

void update(){
  velocity.add(acceleration);
  velocity.limit(maxspeed);
  location.add(velocity);
  acceleration.mult(0);
}

void display(){
  float theta=atan2(velocity.y,velocity.x)+PI/2;
  //float theta=velocity.heading2D() +PI/2;
  fill(150);
  stroke(150);
  pushMatrix();
  translate(location.x,location.y);
  rotate(theta);
  ellipse(0,0,2*r,7*r);
  popMatrix();
}

void checkedges(){
  if(location.x<0){
    location.x=location.x+width;
  }
  if(location.x>width){
   location.x=location.x-width; 
  }
  if(location.y<0){
    location.y=location.y+height;
  }
  if(location.y>height){
    location.y=location.y-height;
  }
}

PVector separate(ArrayList<Boid> boids){
float desiredsepatation=25;
PVector sum=new PVector();
int count=0;
  
for(Boid other:boids){
  float d=PVector.dist(location,other.location);
  
  if((d>0)&&(d<desiredsepatation)){
   PVector diff=PVector.sub(location,other.location); 
   diff.normalize();
   diff.div(d);
   sum.add(diff);
   count++;
  }
}
  if(count>0){
  sum.div(count);
  sum.normalize();
  sum.mult(maxspeed);
  PVector steer=PVector.sub(sum,velocity);
  steer.limit(maxforce);
  return steer;
  }else{
    return new PVector(0,0);
  }
}

  PVector align(ArrayList<Boid> boids){
  PVector sum=new PVector(0,0);
  float neighbordist=50;
  int count=0;
  for(Boid other:boids){
    float d=PVector.dist(location,other.location);
    if((d>0)&&(d<neighbordist)){
       sum.add(other.velocity);
       count++;
    }
  }
  if(count>0){
     sum.div(100);
     sum.normalize();
     sum.mult(maxspeed);
     PVector steer=PVector.sub(sum,velocity);
     steer.limit(maxforce);
     return steer;
  }else{
   return new PVector(0,0); 
  }
}

  PVector cohesion(ArrayList<Boid> boids){
  float neighbordist=50;
  PVector sum=new PVector(0,0);
  int count=0;
  for(Boid other:boids){
    float d=PVector.dist(location,other.location);
    if((d>0)&&(d<neighbordist)){
     sum.add(other.location);
     count++;
    }
  }
  if(count>0){
    sum.div(count);
    return seek(sum);
  }else{
  return new PVector(0,0);
  }
 }
}