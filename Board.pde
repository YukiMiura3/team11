class Board{
    piece[][] grid;
    int cols = 9;
    int rows = 9;
    float cellSize;

    Board(float size){
        cellSize = size/cols;
        grid = new Piece[cols][rows];
    }
}

void initialize(){
    String[] names = {"影狐", "幽騎", "残影", "夜叉", "霞鳥", "白狼", "鳴神", "幻王"};
    for (int i = 0;i< cols;i++){
        for(int j = 0;j <2;j++){
            String name = names[int(random(names.length - 1))];
            grid[i][j] = new Piece(name, true, i, j);
        }
    }

    for (int j = 7; j < 9; j++) {
        String name = names[int(random(names.length - 1))];
        grid[i][j] = new Piece(name, false, i, j);
    }

     // 幻王を必ず中央に配置（例）
    grid[4][0] = new Piece("幻王", true, 4, 0);
    grid[4][8] = new Piece("幻王", false, 4, 8);
    grid[4][0].isRevealed = true;
    grid[4][8].isRevealed = true;
}

void draw() {
    stroke(0);
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        fill(255);
        rect(i * cellSize, j * cellSize, cellSize, cellSize);
        if (grid[i][j] != null) {
          grid[i][j].draw(cellSize);
        }
      }
    }

  Piece getPiece(int x, int y) {
    if (x >= 0 && y >= 0 && x < cols && y < rows) return grid[x][y];
    return null;
  }

  void movePiece(Piece p, int x, int y) {
    grid[p.x][p.y] = null;
    p.moveTo(x, y);
    grid[x][y] = p;
  }
}