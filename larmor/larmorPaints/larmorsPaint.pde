final float mag=10;

String lin;
int ln;
String lines[];

void setup() {
  ln = 0;
  lines = loadStrings("larmorMxy.txt");
  background(255);
  size(1000,800, P3D);
  colorMode(RGB,255);
  frameRate(200);
}

void draw() {
  background(255);
  translate(width/2, height/2, 0);
  
  
  //////////////////////////
  //larmorMxy.txt
  
  
  rotateY(PI/2.0); 
  //////////////////////////
  //larmorM.txt
  
  //rotateY(PI*3.0/4.0);
  //rotateX(PI/4.0);
  ///////////////////////////
  pushMatrix();
  
  textSize(24);
  stroke(255,0,0); //red
  line(0,0,0,200,0,0); // x axis
  fill(255,0,0);
  text("x",200,0,0);
  stroke(0,255,0); //green
  line(0,0,0,0,200,0); // y axis
  fill(0,255,0);
  text("y",0,200,0);
  stroke(0,0,255); // blue
  line(0,0,0,0,0,200); // z axis
  fill(0,0,255);
  text("z",0,0,200);
  popMatrix();
  
  
  
  
  lin = lines[ln];
  String[] co=split(lin," ");
    float t = float(co[0]);
    for(int i=0;i<29;i++){
      pushMatrix();
      float x=float(co[i*3])*mag;
      float y = float(co[i*3+1])*mag;
      float z = float(co[i*3+2])*mag;
      translate(x,y,z);
      fill(255,0,0);
      noStroke();
      sphere(2);
      popMatrix();
    }
  
    
  
  ln++;
  
  if(ln == lines.length) noLoop();
  
}
