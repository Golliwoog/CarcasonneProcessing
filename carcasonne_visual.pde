class VisualMap extends Map{ // visual
  int x,y,w,h;
  float res;
  Map map;
  public VisualMap(Map map, int x, int y, int w, int h, float res){
    this.map = map;
    this.setDim(x,y,w,h);
    this.setRes(res);
  }
  public Tile getTileToBePlaced(){return this.map.getTileToBePlaced();}
  public void      placeTile(Tile t, PVector pos){this.map.placeTile(t,pos);}
  public GTile[]   getAllValidPositions(Tile t){return this.map.getAllValidPositions(t);}
  public Tile      getTile(PVector pos){return this.map.getTile();}
  public GTile[][] tileMap(){return this.map.tileMap();}

  public void setDim(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  public void setRes(float res){
    this.res = w/res;
  }

  public void draw(){
    // x=00,y=00,w=width,h=height,res=how many tiles in a row
    for(GTile[] row : this.tileMap()){
      for(GTile t : row){
        if(t != null)
          t.draw(x+w/2-res/2,y+h/2-res/2,int(res),int(res));
          //t.draw(res*this.tileMap()[0][0].gridPos.x,res*this.tileMap()[0][0].gridPos.y,int(res),int(res));
      }
    }
  }
  int pressedX=0;
  int pressedY=0;
  public GTile screenToGTile(float x, float y){
    int tx = (x-this.x)/this.res;
    int ty = (y-this.y)/this.res;
    return null;//this.getT
  }
  public void mousePressed(){
    if(!(mouseX>x&&mouseX<x+w && mouseY>y&& mouseY<y+h)) return;
    pressedX = int(mouseX/res);
    pressedY = int(mouseY/res);

  }
  public void mouseReleased(){
    if(!(mouseX>x&&mouseX<x+w && mouseY>y&& mouseY<y+h)) return;
    int x = int(mouseX/res);
    int y = int(mouseY/res);
    if(x==pressedX&&y==pressedY){
      this.mouseClickedEvent(x,y);
    }
  }
  public void mouseClickedEvent(int x, int y){

  }
}









GrassStreetUp g;
VisualMap myMap;
 static int screenW = 800;
 static int screenH = 600;
void setup(){
  size(800,600);
  myMap = new VisualMap();
  g = new GrassStreetUp();
  myMap.placeTile(g,new PVector(0,0));
  myMap.placeTile(g,new PVector(0,1));
  myMap.placeTile(g,new PVector(1,-1));
}

void draw(){
  myMap.draw(0,0,width,height,5);
}
