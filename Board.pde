class Board {
  Piece[][] grid;
  final int COLS = 9;
  final int ROWS = 9;
  float cellSize;

  Board(float size) {
    cellSize = size / COLS;
    grid = new Piece[COLS][ROWS];
  }

  // 盤面初期化（駒をランダムに裏向き配置・王だけ表向き）
  void initialize() {
    String[] names = { "影狐", "幽騎", "残影", "夜叉", "霞鳥", "白狼", "鳴神" };  // 王は除く

    // 先手（上側）2段
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < 2; j++) {
        String name = names[int(random(names.length))];
        grid[i][j] = new Piece(name, true, i, j);
      }
    }

    // 後手（下側）2段
    for (int i = 0; i < COLS; i++) {
      for (int j = 7; j < 9; j++) {
        String name = names[int(random(names.length))];
        grid[i][j] = new Piece(name, false, i, j);
      }
    }

    // 幻王を中央列に固定して表向き
    grid[4][0] = new Piece("幻王", true, 4, 0);
    grid[4][8] = new Piece("幻王", false, 4, 8);
    grid[4][0].isRevealed = true;
    grid[4][8].isRevealed = true;
    
    // ★ 追加：全駒を強制的に表にする
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        if (grid[i][j] != null) {
          grid[i][j].isRevealed = true;
         }
        }
     }
  }

  // 盤描画
  void draw(Piece selected) {
  stroke(0);
  for (int i = 0; i < COLS; i++) {
    for (int j = 0; j < ROWS; j++) {
      // ★ 1. 選択中の駒がいて、そのマスが移動先として合法ならハイライト
      if (game.selected != null && game.selected.canMoveTo(i, j, this)) {
        fill(200, 255, 200);  // 薄緑
      } else {
        fill(255);            // 通常の白背景
      }

      rect(i * cellSize, j * cellSize, cellSize, cellSize);

      Piece p = grid[i][j];
      if (p != null) p.draw(cellSize);
    }
  }
}


  Piece getPiece(int x, int y) {
    if (x >= 0 && y >= 0 && x < COLS && y < ROWS) return grid[x][y];
    return null;
  }

  void movePiece(Piece p, int x, int y) {
    grid[p.x][p.y] = null;  // 元のマスを空に
    p.moveTo(x, y);
    grid[x][y] = p;         // 新しい位置に配置
  }
}