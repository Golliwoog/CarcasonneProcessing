import java.util.Iterator; // Import for Iterator

public class Pos{ // basically an Vec2D<int>
    int x, y;

  Pos(int x, int y) {
    this.x = x;
    this.y = y;
  }

  // Add another vector to this one
  void add(Pos other) {
    this.x += other.x;
    this.y += other.y;
  }

  // Subtract another vector from this one
  void sub(Pos other) {
    this.x -= other.x;
    this.y -= other.y;
  }

  // Multiply this vector by a scalar
  void mult(int scalar) {
    this.x *= scalar;
    this.y *= scalar;
  }

  // Divide this vector by a scalar
  void div(int scalar) {
    if (scalar != 0) {
      this.x /= scalar;
      this.y /= scalar;
    } else {
      println("Division by zero is not allowed.");
    }
  }

  // Calculate the magnitude (length) of this vector
  int mag() {
    return (int) sqrt(this.x * this.x + this.y * this.y);
  }

  // Normalize this vector
  void normalize() {
    int m = mag();
    if (m != 0) {
      div(m);
    
    }
  }
}

enum Edge{
    Street(),
    Grass(),
    Castle();
}

interface Tile{
    public Edge edge(int dir); // 0=up, 1=right, 2=down, 3=left returns which edge there is

    public Pos getPos(); // returns the position of the Tile
    public void setPos(Pos p); // sets the Position of the Tile
}

public interface Map extends Iterable<Tile>{
    public boolean placeTile(Tile t); // returns false if not placed, true if it placed
    public Tile getTile(Pos p); // returns null if there is no Tile, else the Tile at pos p
    public Tile[][] mapMatrix(); // null at the positions where there is no Tile

    @Override
    public Iterator<Tile> iterator(); // iterates trough all Tiles on the map
}