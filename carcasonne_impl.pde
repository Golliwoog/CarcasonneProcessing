class Bot1 extends Player{
    Bot1(){super(color(0,0,0));}
    public PVector placeTile(Tile t, Map m){
        return new PVector(1,1);
    }
}

class HumanPlayer extends Player{
  HumanPlayer(){super(color(255,0,0));}
    public PVector placeTile(Tile t, Map m){
        return new PVector(1,1);
    }
}

class StandardTileSet extends TileSet{
    public Tile nextTile(){
        yield Tile.SteetUp;
        yield Tile.StreetUpLeft;
    }
}
class StanardGameManager extends GameManger{
    public Player nextPlayer(){
        return this.players[0];
    }
}


class GTileImpl extends GTile{
  GTileImpl(PVector pos){super(pos);}
  public  boolean placable(Tile t){return true;} // returns true if GTile can be Tile t
  public  Tile[] placable(){return new Tile[]{Tile.StreetUpLeft};}// returns all Tiles that can be placed on it
  public  GTile[] neighbours(PVector[] poss){return new GTile[0];} // returns in GTile[i] the GTile at poss[i] relative to the current GTile 
}
class MapImpl extends Map{
  GTile[][] map;
  MapImpl(){
    map = new GTile[9][9];
    for(int i=0;i<9;i++){
      for(int u=0;u<9;u++){
        map[i][u] = new GTileImpl(new PVector(i-5,u-5));
      }
    }
  }
  public Tile getTileToBePlaced(){return new GrassStreetUp();} // returns the current Tile to be placed
  public void placeTile(Tile t, PVector pos){this.map[int(pos.x+5)][int(pos.y+5)].setTile(t);} // places the Tile t at position pos.x,y
  public GTile[] getAllValidPositions(Tile t){return new GTile[0];} // returns all GTiles on which you can place Tile t
  public GTile getTile(PVector pos){return null;} // returns the Tile t at pos.x,y, if there is none, return null
  public GTile[][] tileMap(){return this.map;} // returns a matrix of all tiles in the game
}
