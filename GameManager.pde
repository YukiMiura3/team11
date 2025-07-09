class GameManager {
  Board board;
  Player p1, p2;
  Piece selected;

  void setup() {
    board = new Board(width);
    board.initialize();
    p1 = new Player(true);
    p2 = new Player(false);
    selected = null;
  }

  void draw() {
    board.draw();
  }

  void handleMouse(int mx, int my) {
    int x = int(mx / board.cellSize);
    int y = int(my / board.cellSize);
    Piece clicked = board.getPiece(x, y);
    if (selected != null && clicked == null) {
      board.movePiece(selected, x, y);
      selected = null;
      p1.toggleTurn();
      p2.toggleTurn();
    } else if (clicked != null && clicked.isMine == p1.isMyTurn) {
      selected = clicked;
    }
  }
}