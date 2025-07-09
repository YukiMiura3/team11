class Piece {
  String name;
  boolean isPromoted;
  boolean isRevealed;
  boolean isMine;
  int x, y;

  Piece(String name, boolean isMine, int x, int y) {
    this.name = name;
    this.isMine = isMine;
    this.x = x;
    this.y = y;
    this.isPromoted = false;
    this.isRevealed = false;
  }

  void draw(float cellSize) {
    if (isRevealed || name.equals("幻王")) {
      fill(isMine ? color(200, 100, 100) : color(100, 100, 200));
      rect(x * cellSize, y * cellSize, cellSize, cellSize);
      fill(0);
      textAlign(CENTER, CENTER);
      text(name, x * cellSize + cellSize / 2, y * cellSize + cellSize / 2);
    } else {
      fill(150);
      rect(x * cellSize, y * cellSize, cellSize, cellSize);
    }
  }

  void moveTo(int newX, int newY) {
    x = newX;
    y = newY;
    isRevealed = true;
  }

  void promote() {
    isPromoted = true;
  }
}