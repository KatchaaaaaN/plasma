final float mag=10;

String lin;
int ln;
String lines[];

void setup() {
  ln = 0;
  lines = loadStrings("larmor0.txt");
  background(0);
  size(1000,800, P3D);
  colorMode(RGB,255);
}

void draw() {
  
  lin = lines[ln];
  String[] co=split(lin," ");
  if(co.length==4){
    
    float t = float(co[0]);
    float x = float(co[1])*mag;
    float y = float(co[2])*mag;
    float z = float(co[3])*mag;
    translate(width/2+x,height/2+y,z);
    
    
    fill(255,0,0);
    noStroke();
    sphere(3);
  }
    
  
  ln++;
  
  if(ln == lines.length) noLoop();
  
}
