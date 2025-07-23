// Piece.pde

class Piece {
  String  name;
  boolean isPromoted;
  boolean isRevealed;
  boolean isMine;    // true = 先手
  int x, y;

  Piece(String name, boolean isMine, int x, int y) {
    this.name    = name;
    this.isMine = isMine;
    this.x      = x;
    this.y      = y;
    isPromoted  = false;
    isRevealed  = false;
  }

  /* ===== 描画 ===== */
  void draw(float cellSize) {
    if (isRevealed || name.equals("幻王")) {
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
    int fwd = isMine ? 1 : -1;
    int rdy = dy * (isMine ? 1 : -1);

    switch (name) {
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

      case "幽騎":
        if (!isPromoted) {
          if ((adx == 1 && rdy == 1) || (adx == 0 && rdy == 2)) return true;
        } else {
          if (max(adx, ady) == 1) return true;
          if (adx == 0 && rdy == 2) return true;
        }
        break;

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

      case "夜叉":
        if (adx == 0 || ady == 0) {
          return pathClear(tx, ty, board);
        }
        if (isPromoted && adx == 1 && ady == 1) return true;
        break;

      case "霞鳥":
        if (!isPromoted) {
          if (adx == 1 && ady == 1) return true;
        } else {
          if (adx == ady && adx >= 1 && adx <= 2) {
            return pathClear(tx, ty, board);
          }
        }
        break;

      case "白狼":
        if (adx == 0) {
          if (rdy > 0) {
            return pathClear(tx, ty, board);
          } else if (rdy < 0 && ady <= 2) {
            return pathClear(tx, ty, board);
          }
        } else if (isPromoted && adx == 1 && ady == 0) {
          return true;
        }
        break;

      case "鳴神":
        if (adx == ady) {
          return pathClear(tx, ty, board);
        }
        if (isPromoted && ((adx == 1 && ady == 0) || (adx == 0 && ady == 1))) {
          return true;
        }
        break;

      case "幻王":
        if (max(adx, ady) == 1) return true;
        break;
    }
    return false;
  }
}