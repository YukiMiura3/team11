class Board {
  int N = 9;
  float x0, y0, cell;
  Piece[][] grid;

  Board(float x0, float y0, float cell) {
    this.x0 = x0; this.y0 = y0; this.cell = cell;
    grid = new Piece[N][N];
  }

  void draw() {
    stroke(160, 120, 60);
    for (int r = 0; r <= N; r++) line(x0, y0 + r*cell, x0 + N*cell, y0 + r*cell);
    for (int c = 0; c <= N; c++) line(x0 + c*cell, y0, x0 + c*cell, y0 + N*cell);

    for (int r = 0; r < N; r++) {
      for (int c = 0; c < N; c++) {
        Piece p = grid[r][c];
        if (p != null) {
          p.drawAt(x0 + c*cell + cell/2, y0 + r*cell + cell/2, cell * 0.8);
        }
      }
    }
  }

  void showMoves(Piece p) {
    noStroke();
    fill(180, 255, 180, 150);
    for (PVector mv : p.getMoves(this)) {
      rect(x0 + mv.y*cell, y0 + mv.x*cell, cell, cell);
    }
  }

  void highlightCell(int row, int col) {
    noFill();
    stroke(255, 120, 80);
    strokeWeight(3);
    rect(x0 + col*cell, y0 + row*cell, cell, cell);
    strokeWeight(1);
  }

  boolean inBoard(float mx, float my) {
    return mx>=x0&&mx<x0+N*cell&&my>=y0&&my<y0+N*cell;
  }

  PVector cellFromMouse(float mx, float my) {
    int col = int((mx - x0) / cell);
    int row = int((my - y0) / cell);
    return new PVector(row, col);
  }
}
