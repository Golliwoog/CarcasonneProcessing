public class ImgTile extends TileImpl{
    final PImage origImg;
    PImage img;
    
    public ImgTile(Pos p) {
        super(p);
        this.origImg = new PImage(0,0);
        this.img = origImg.copy();
    }
    
    public void draw(float x0, float y0, float scaleX, float scaleY){
      square(getPos().x*scaleX+x0,getPos().y*scaleY+y0,scaleX);  
      //image(img,getPos().x*scaleX+x0,getPos().y*scaleY+y0);
    }
    public void scaleImg(int w, int h){
        img = origImg.copy();
        img.resize(w,h);
    }
}

public class ImgMap extends MapImpl{
    private int x0,y0,w,h;
    private float res;
    private float tileWidth,tileHeight;
    private PVector cam00 = new PVector(0,0); 
    private PVector cam00saveBeforeDragged;
    
    ImgMap(int x0, int y0, int w, int h, float res){
        this.setDim(x0,y0,w,h);
        this.setRes(res);
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
        for(Tile t : this){
            ((ImgTile)t).draw(this.x0-this.cam00.x,this.y0-this.cam00.y,this.tileWidth,this.tileHeight);
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
      setRes(res*newRes);
    }
}
