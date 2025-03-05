public class TileImpl implements Tile{
  Pos p;
  TileImpl(Pos p){this.p=p;}
  public Edge edge(int dir){return Edge.Street;}
  public Pos getPos(){return p;}
  public void setPos(Pos p){this.p=p;}
}
public class MapImpl implements Map{
    public boolean placeTile(Tile t){return true;}
    public Tile getTile(Pos p){return null;}
    public Tile[][] mapMatrix(){return new Tile[0][0];}

    public Iterator<Tile> iterator(){
        return new MapImplIterator();
    }
    private class MapImplIterator implements Iterator<Tile> { // Changed to implements
        private int currentIndex = 0;

        @Override
        public boolean hasNext() {
            return currentIndex < 5;
        }

        @Override
        public Tile next() {
            if (!hasNext()) {
                throw new Error();
            }
            return getTileAtIndex(currentIndex++);
        }

        private Tile getTileAtIndex(int i) {
            // Corrected the typo and removed unnecessary break statements
            switch (i) {
                case 0: return new ImgTile(new Pos(0, 0)); 
                case 1: return new ImgTile(new Pos(0, 1));
                case 2: return new ImgTile(new Pos(1, 0));
                case 3: return new ImgTile(new Pos(2, 2));
                case 4: return new ImgTile(new Pos(-1, -1));
                default: return null;
            }
        }
    }
}
