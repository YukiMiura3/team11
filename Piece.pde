class Piece {
  String  name;
  boolean isPromoted;
  boolean isRevealed;
  boolean isMine;   // true = 先手
  int x, y;

  Piece(String name, boolean isMine, int x, int y) {
    this.name   = name;
    this.isMine = isMine;
    this.x      = x;
    this.y      = y;
    isPromoted  = false;
    isRevealed  = false;
  }

  /* ===== 描画 ===== */
  void draw(float cellSize) {
    if (isRevealed || name.equals("幻王")) {
      fill(isMine ? color(230, 120, 120) : color(120, 120, 230));
      rect(x * cellSize, y * cellSize, cellSize, cellSize);

      fill(0);
      textSize(cellSize * 0.35);
      textAlign(CENTER, CENTER);
      text(name, x * cellSize + cellSize / 2, y * cellSize + cellSize / 2);
    } else {
      fill(160);
      rect(x * cellSize, y * cellSize, cellSize, cellSize);
    }
  }

  /* ===== 位置更新 ===== */
  void moveTo(int nx, int ny) {
    x = nx;
    y = ny;
    isRevealed = true;
  }

  /* ===== 経路チェック（滑走系用） ===== */
  boolean pathClear(int tx, int ty, Board board) {
    int dx = tx - x;
    int dy = ty - y;
    int stepX = (dx == 0) ? 0 : (int) Math.signum(dx);
    int stepY = (dy == 0) ? 0 : (int) Math.signum(dy);

    int cx = x + stepX;
    int cy = y + stepY;
    while (cx != tx || cy != ty) {
      if (board.getPiece(cx, cy) != null) return false;
      cx += stepX;
      cy += stepY;
    }
    return true;
  }

  /* ===== 合法手判定 ===== */
  boolean canMoveTo(int tx, int ty, Board board) {
    if (tx == x && ty == y) return false;
    if (tx < 0 || tx >= board.COLS || ty < 0 || ty >= board.ROWS) return false;

    Piece dest = board.getPiece(tx, ty);
    if (dest != null && dest.isMine == this.isMine) return false;

    int dx  = tx - x;
    int dy  = ty - y;
    int adx = abs(dx);
    int ady = abs(dy);
    int fwd = isMine ? 1 : -1;           // 自分にとって前方の符号
    int rdy = dy * (isMine ? 1 : -1);    // 自分目線での dy

    switch (name) {
      /* 影狐／影神狐 */
      case "影狐":
        if (!isPromoted) {
          if ((adx == 0 && ady >= 1 && ady <= 2) ||
              (ady == 0 && adx >= 1 && adx <= 2)) {
            return pathClear(tx, ty, board);
          }
        } else {
          if (max(adx, ady) >= 1 && max(adx, ady) <= 2 &&
              (adx == 0 || ady == 0 || adx == ady)) {
            return pathClear(tx, ty, board);
          }
        }
        break;

      /* 幽騎／幽天騎 */
      case "幽騎":
        if (!isPromoted) {
          if ((adx == 1 && rdy == 1) || (adx == 0 && rdy == 2)) return true;
        } else {
          if (max(adx, ady) == 1) return true;
          if (adx == 0 && rdy == 2) return true;
        }
        break;

      /* 残影／真影 */
      case "残影":
        if (!isPromoted) {
          if ((adx == 0 && ady == 1) || (ady == 0 && adx == 1)) return true;
        } else {
          if ((adx == 0 && ady >= 1 && ady <= 2) ||
              (ady == 0 && adx >= 1 && adx <= 2)) {
            return pathClear(tx, ty, board);
          }
        }
        break;

      /* 夜叉／魔将夜叉 */
      case "夜叉":
        if (adx == 0 || ady == 0) {
          return pathClear(tx, ty, board);
        }
        if (isPromoted && adx == 1 && ady == 1) return true;
        break;

      /* 霞鳥／新鳥 */
      case "霞鳥":
        if (!isPromoted) {
          if (adx == 1 && ady == 1) return true;
        } else {
          if (adx == ady && adx >= 1 && adx <= 2) {
            return pathClear(tx, ty, board);
          }
        }
        break;

      /* 白狼／幻狼 */
      case "白狼":
        if (adx == 0) {
          if (rdy > 0) {                      // 前方無制限
            return pathClear(tx, ty, board);
          } else if (rdy < 0 && ady <= 2) {   // 後方 2
            return pathClear(tx, ty, board);
          }
        } else if (isPromoted && adx == 1 && ady == 0) {
          return true;                        // 横 1
        }
        break;

      /* 鳴神／雷王 */
      case "鳴神":
        if (adx == ady) {
          return pathClear(tx, ty, board);    // 斜め無制限
        }
        if (isPromoted && ((adx == 1 && ady == 0) || (adx == 0 && ady == 1))) {
          return true;                        // 縦横 1
        }
        break;

      /* 幻王 */
      case "幻王":
        if (max(adx, ady) == 1) return true;
        break;
    }
    return false;
  }
}