import gifAnimation.*;
GifMaker gifExport;

int n=30; //number of particles
float brownV=0.5; //per deltaTime
float density=3.0; //larger, stronger
float initialV=0.5; //per deltaTime
float initialWidth=10.0;  //relic of square initialization
float circleSize=2.0; //diameter
float paintCircleSize=2.0; // diameter
float time=0.0;
float deltaTime=0.1;
float tau=0.1; // tau should > deltaTime (collision time)
final int displaySize=1000;
ArrayList<Particle> particleTable=new ArrayList<Particle>();
Particle temp;
IntList nums=new IntList(n*n);
int[] order=new int[n*n];

class Particle{
  float x,y,v,theta;
  Particle(float x, float y, float v, float theta){
    this.x=x;
    this.y=y;
    this.v=v;
    this.theta=theta;
  }
}
    

void settings(){
  size(displaySize,displaySize);
}

void setup(){
  /*
  
  frameRate(50); // 50fps animation

  // GIF animation config
  gifExport = new GifMaker(this, "export.gif"); //making GifMaker object
  gifExport.setRepeat(0); // endless play
  gifExport.setQuality(10); // quality(default: 10)
  gifExport.setDelay(20); // animation interval 20ms(50fps)
  */
  
  
  
  
  for(int i=0;i<n*n;i++){
    nums.append(i);
  }
  nums.shuffle();
  order=nums.array();
  for(float i=0;i<n*initialWidth;i=i+initialWidth){
    for(float j=0;j<n*initialWidth;j=j+initialWidth){      
      //particleTable.add(new Particle(i+height/2-n/2*initialWidth,j+width/2-n/2*initialWidth, randomGaussian()*initialV,random(PI*2.0)));
      float newR=sqrt(random(sq(n*circleSize/density)));
      float newTheta=random(PI*2.0);
      particleTable.add(new Particle(
      height/2+newR*cos(newTheta),
      width/2+newR*sin(newTheta),
      randomGaussian()*initialV,
      random(PI*2.0)));
      
    }
  }
  smooth();
  noStroke();
  colorMode(RGB,255);
}

void draw(){
  background(255,255,255);
  fill(0,0,0);
  textSize(24);
  text(time,0,50);
  for(Particle temp : particleTable){
    fill(255,0,0);
    ellipse(temp.x,temp.y,paintCircleSize,paintCircleSize);
  }
  
  brown();
  
  for(Particle temp : particleTable){
    temp.x+=temp.v*cos(temp.theta);
    temp.y+=temp.v*sin(temp.theta);  
  }
  
  collision();
  
  //delay(1000);
  
  time+=deltaTime;
  
  /*
  
  // 50fps * 5 as 5 seconds recording
  if(frameCount <= 50*5){
    gifExport.addFrame(); // add frame
  } else {
    gifExport.finish(); // exit and save file
  }
  */
  
}

void brown(){
  for(Particle temp : particleTable){
    if(random(1)<deltaTime/tau){
        //Brown Collision
      float newVX, newVY;
      newVX=temp.v*cos(temp.theta)+brownV*cos(random(PI*2.0));
      newVY=temp.v*sin(temp.theta)+brownV*sin(random(PI*2.0));
      temp.v=dist(0,0,newVX,newVY);
      temp.theta=atan2(newVY,newVX);
    }
  }
}

    
    
    
void collision(){
  nums.shuffle();
  order=nums.array();
  int countCollision=0;
  for(int k=0;k<n*n;k++){
    int i=order[k];
    for(int l=0;l<i;l++){
      int j=order[l];
      float distance=dist(particleTable.get(i).x,particleTable.get(i).y,particleTable.get(j).x,particleTable.get(j).y);
      float nextDistance=dist(particleTable.get(i).x+0.01*particleTable.get(i).v*cos(particleTable.get(i).theta)
      ,particleTable.get(i).y+0.01*particleTable.get(i).v*sin(particleTable.get(i).theta)
      ,particleTable.get(j).x+0.01*particleTable.get(j).v*cos(particleTable.get(j).theta)
      ,particleTable.get(j).y+0.01*particleTable.get(j).v*sin(particleTable.get(j).theta));
      
      if(distance<circleSize && nextDistance < distance){
        fill(0,0,0);
        ellipse(particleTable.get(i).x,particleTable.get(i).y,circleSize,circleSize);
        ellipse(particleTable.get(j).x,particleTable.get(j).y,circleSize,circleSize);
        fill(255,0,0);
        
        countCollision++;
        
        Particle centV=centerV(particleTable.get(i),particleTable.get(j));
        Particle vAdd=minusParticleV(particleTable.get(i),particleTable.get(j));
        vAdd.v/=2.0;
        
        
        float vAddTheta_a=-PI/2.0+atan2(particleTable.get(j).y-particleTable.get(i).y,particleTable.get(j).x-particleTable.get(i).x);
        float vAddTheta_b=vAddTheta_a-PI;

        float vAddTheta=random(vAddTheta_b,vAddTheta_a);
        vAdd.theta=vAddTheta;
        //float vAddTheta=(vAddTheta_a+vAddTheta_b)/2.0;
        
        Particle newI=plusParticleV(centV, vAdd);
        newI.x=particleTable.get(i).x;
        newI.y=particleTable.get(i).y;
        Particle newJ=minusParticleV(centV, vAdd);
        newJ.x=particleTable.get(j).x;
        newJ.y=particleTable.get(j).y;
        
        
        particleTable.set(i,newI);
        particleTable.set(j,newJ);
       
      }
    }
  }
  
  /*
  print("countCollision ");
  println(countCollision);
  */
}
        
        
Particle plusParticleV(Particle A, Particle B){
  Particle C=new Particle(-1,-1,
  dist(A.v*cos(A.theta),A.v*sin(A.theta),-B.v*cos(B.theta),-B.v*sin(B.theta)),
  atan2(A.v*sin(A.theta)+B.v*sin(B.theta),A.v*cos(A.theta)+B.v*cos(B.theta)));
  return C;
}

Particle minusParticleV(Particle A, Particle B){
  Particle C=new Particle(-1,-1,
  dist(A.v*cos(A.theta),A.v*sin(A.theta),B.v*cos(B.theta),B.v*sin(B.theta)),
  atan2(A.v*sin(A.theta)-B.v*sin(B.theta),A.v*cos(A.theta)-B.v*cos(B.theta)));
  return C;
}

Particle centerV(Particle A, Particle B){
  Particle V=plusParticleV(A,B);
  V.v/=2.0;
  return V;
}
  
  
