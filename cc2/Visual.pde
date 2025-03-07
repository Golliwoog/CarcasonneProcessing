public class ImgTile implements Tile{
    final Tile t;
    final PImage origImg;
    PImage img;
    
    public ImgTile(PImage img, Tile t) {
        this.origImg = new PImage(0,0);
        this.img = origImg.copy();
        this.t=t;
    }
    public ImgTile(PImage img, Pos p) {
        this.origImg = new PImage(0,0);
        this.img = origImg.copy();
        this.t= new TileImpl(p);
    }
    
    public void draw(float x0, float y0, float scaleX, float scaleY){
      fill(255);
      if(t.getPos().x==0 && t.getPos().y==0)
        fill(color(255,0,0));
      square(t.getPos().x*scaleX+x0,t.getPos().y*scaleY+y0,scaleX);  

      //image(img,getPos().x*scaleX+x0,getPos().y*scaleY+y0);
    }
    public void scaleImg(int w, int h){
        img = origImg.copy();
        img.resize(w,h);
    }
    public Edge edge(int dir){return t.edge(dir);}

    public Pos getPos(){return t.getPos();}
    public void setPos(Pos p){t.setPos(p);}
}

public class ImgMap implements Map{
    final Map m;
    private int x0,y0,w,h;
    private float res;
    private float tileWidth,tileHeight;
    private PVector cam00 = new PVector(0,0); 
    private PVector cam00saveBeforeDragged;
    
    ImgMap(Map m, int x0, int y0, int w, int h, float res){
        this.setDim(x0,y0,w,h);
        this.setRes(res);
        this.m = m;
    }
    public void setDim(int x0, int y0, int w, int h){
        this.x0 = x0;
        this.y0 = y0;
        this.w = w;
        this.h = h;
    }
    public void setRes(float res){
        this.res = res;
        this.tileWidth = w/res;
        this.tileHeight = h/res;
    }
    public void draw(){
        final float centerX = this.w/2-this.tileWidth/2;
        final float centerY = this.h/2-this.tileHeight/2;
        for(float i=-cam00.x %tileWidth + ((res+1)%2)*tileWidth/2;i<h;i+=tileWidth){
          stroke(144);
          line(i,y0,i,h);
        }
        for(float i=-cam00.y %tileHeight + ((res+1)%2)*tileHeight/2;i<h;i+=tileHeight){
          stroke(144);
          line(x0,i,w,i);
        }
        for(Tile t : this){
            ((ImgTile)t).draw(this.x0+centerX-this.cam00.x,this.y0+centerY-this.cam00.y,this.tileWidth,this.tileHeight);
        }
    }
    public void beginnDragg(){
      cam00saveBeforeDragged = cam00.copy();
    }
    public void dragg(PVector dir){
      cam00 = PVector.add(cam00saveBeforeDragged,dir);
    }
    public void endDragg(){
      
    }
    public void zoom(float newRes){ // relative to old one
      float oldRes = res; 
      setRes(res*newRes);
      cam00.x *= oldRes/res;
      cam00.y *= oldRes/res;
    }
    public void zoom(int newRes){ // relative to old one
      float oldRes = res; 
      setRes(res+newRes);
      cam00.x *= oldRes/res;
      cam00.y *= oldRes/res;
    }
    
    public boolean placeTile(Tile t){return m.placeTile(t);}
    public Tile getTile(Pos p){return m.getTile(p);}
    public Tile[][] mapMatrix(){return m.mapMatrix();}

    @Override
    public Iterator<Tile> iterator(){return m.iterator();}
}
