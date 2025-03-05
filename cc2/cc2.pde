ImgMap m;

void setup(){
  size(500,500);
  m = new ImgMap(0,0,width,height,5);
}

void draw(){
  background(0);
  m.draw();
  if(dragging){
    PVector p = new PVector(mouseX,mouseY);
    m.dragg(PVector.sub(start,p));
  }  
}

PVector start = null;
boolean dragging = false;
void mousePressed(){
  start = new PVector(mouseX,mouseY);
  dragging = true;
  m.beginnDragg();
}

void mouseReleased(){
  dragging = false;
  m.endDragg();
} 

void keyPressed(){
  if(key == '-'){
    m.zoom(1.5);
  }
  else if(key == '+'){
    m.zoom(0.5);
  }
  
}
