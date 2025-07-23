// Board.pde

class Board {
  Piece[][] grid;
  final int COLS = 9;
  final int ROWS = 9;
  float cellSize;

  Board(float size) {
    cellSize = size / COLS;
    grid = new Piece[COLS][ROWS];
  }

  // 盤面初期化（変更なし）
  void initialize() {
    String[] names = { "影狐", "幽騎", "残影", "夜叉", "霞鳥", "白狼", "鳴神" };

    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < 2; j++) {
        String name = names[int(random(names.length))];
        grid[i][j] = new Piece(name, true, i, j);
      }
    }

    for (int i = 0; i < COLS; i++) {
      for (int j = 7; j < 9; j++) {
        String name = names[int(random(names.length))];
        grid[i][j] = new Piece(name, false, i, j);
      }
    }

    grid[4][0] = new Piece("幻王", true, 4, 0);
    grid[4][8] = new Piece("幻王", false, 4, 8);
    grid[4][0].isRevealed = true;
    grid[4][8].isRevealed = true;
    
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        if (grid[i][j] != null) {
          grid[i][j].isRevealed = true;
        }
      }
    }
  }

  // 盤描画
  void draw(Piece selected) { // selected引数はGameManagerから渡される
    stroke(0);
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        Piece p = grid[i][j]; // そのマスに駒があるか確認

        // まずマス目の背景色を決定
        if (game.selected != null && game.selected.canMoveTo(i, j, this)) {
          fill(200, 255, 200);  // 合法な移動先は薄緑
        } else if (p != null && (p.isRevealed || p.name.equals("幻王"))) {
          // 駒が表向き（または幻王）の場合、駒のプレイヤー色で塗る
          fill(p.isMine ? color(230, 120, 120) : color(120, 120, 230));
        } else if (p != null) {
          // 裏向きの駒があるマスは灰色
          fill(160);
        } else {
          fill(255);            // 何もないマスは白
        }

        rect(i * cellSize, j * cellSize, cellSize, cellSize); // マス目の背景を描画
      }
    }

    // その後、全ての駒の名前を描画（背景は既にBoardで描画済み）
    for (int i = 0; i < COLS; i++) {
      for (int j = 0; j < ROWS; j++) {
        Piece p = grid[i][j];
        if (p != null && (p.isRevealed || p.name.equals("幻王"))) {
          fill(0); // 駒の文字色
          textSize(cellSize * 0.35);
          textAlign(CENTER, CENTER);
          text(p.name, i * cellSize + cellSize / 2, j * cellSize + cellSize / 2);
        }
      }
    }
  }

  Piece getPiece(int x, int y) {
    if (x >= 0 && y >= 0 && x < COLS && y < ROWS) return grid[x][y];
    return null;
  }

  void movePiece(Piece p, int x, int y) {
    grid[p.x][p.y] = null;
    p.moveTo(x, y);
    grid[x][y] = p;
  }
}