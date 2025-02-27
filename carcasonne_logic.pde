enum ttype{ // what kind of connections between tiles exist. E.g. Grass,Street,InnerCastle,CastleBorder,River,etc...
  GTile(),
  Street(),
  Grass();
}
enum Tile{ // what kind of tiles exist and their connections.
  GTile("GTile",loadImage("GTile.png"),ttype.GTile,ttype.GTile,ttype.GTile,ttype.GTile),
  StreetUp("StreetUp",loadImage("Street_up.png"),ttype.Street,ttype.Grass,ttype.Street,ttype.Grass),
  StreetUpLeft("StreetUpLeft",loadImage("Street_up_left.png"),ttype.Grass,ttype.Grass,ttype.Street,ttype.Street);
  final String ID;
  final String up,right,down,left; // up right down left
  Tile(String id, PImage img, ttype up, ttype right, ttype down, ttype left){
    this.ID = id;
    this.img = img;
    this.up=up;
    this.right=right;
    this.down=down;
    this.left=left;
  }
  void draw(float x, float y, int w, int h){image(this.img,x,y,w,h);}
}
abstract class GTile{
  final PVector gridPos;
  Tile tile = Tile.GTile;
  GTile(PVector pos){this.gridPos=pos;}
  public boolean  isFree(){return tile == Tile.GTile;} // if a tile is on the GTile
  public Tile     getTile(){return this.tile;}
  public void     setTile(Tile t){this.tile = t;}
  public abstract boolean placable(Tile t); // true, if Tile t can be placed on this
  public abstract Tile[]  placable(); // returns all Tiles that can be placed on this
  public abstract GTile[] neighbours(PVector[] poss); // returns in GTile[i] the GTile at pos poss[i] relative to this
}
abstract class Map{
  // in carcasonne, there is always the same starting-tile. For us, it is the center, e.g. Pos(0,0).
  public abstract void      placeTile(Tile t, PVector pos); // places the Tile t at position pos.x,y
  public abstract GTile[]   getAllValidPositions(Tile t); // returns all GTiles on which you can place Tile t
  public abstract Tile      getTile(PVector pos); // returns the Tile t at pos.x,y, if there is none, return null
  public abstract GTile[][] tileMap(); // returns a matrix of the currently explored map
}
abstract class Player{
  final color col; // basically Player-Group-ID
  Player(color col){this.col = col;}
  public abstract PVector placeTile(Tile t, Map m); // returns the position where Tile t should be placed on Map m
}
abstract class TileSet{ // e.g. der Beutel mit allen Plättchen
  public Tile nextTile(); // returns null, if there is no Tile left
}
abstract class GameManger{ // player1&player2
  final Map m;
  final Player[] players;
  final TileSet tileSet;
  GameManger(Map m, Player[] players, TileSet tS){
    this.m = m;
    this.players = players;
    this.tileSet = tS; 
  }
  public void finish(){println("End the Game!");}
  public Player nextPlayer(); // returns the next player to move
  public void step(){ // 1 step of the game
    Tile t = this.tileSet.nextTile();
    if(t == null){
      this.finish();
      return;
    }
    this.nextPlayer().placeTile(t,this.m);
  }
}
