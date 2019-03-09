String lin;
int ln;
String lines[];

void setup() {
  ln = 0;
  lines = loadStrings("run1_g");
  background(0);
  size(1000,800);
  colorMode(RGB,255);
}

void draw() {
  
  lin = lines[ln];
  
  float x = ln;
  float y = float(lin);
  fill(255,0,0);
  noStroke();
  ellipse(x/5,y*5,5,5);
    
  
  ln++;
  
  if(ln == lines.length) noLoop();
  
}
