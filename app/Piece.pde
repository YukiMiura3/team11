class Piece {
  String type;  // "FU","KY","KE","GI","KI","KA","HI","OU","TO","NY","NK","NG","UM","RY"
  int owner;    // 0 = S, 1 = G
  int row, col;

  // code 例: "S-FU" / "G-OU"
  Piece(String code, int row, int col) {
    String[] sp = code.split("-");
    owner = sp[0].equals("S") ? 0 : 1;
    this.type = sp[1];
    this.row = row;
    this.col = col;
  }

  // 盤上に駒を描画
  void drawAt(float x, float y, float dia) {
    textAlign(CENTER, CENTER);
    textSize(dia * 0.6);
    fill(owner == 0 ? color(200,50,50) : color(50,50,200));
    pushMatrix();
    translate(x, y);
    if (owner == 1) rotate(PI);
    text(symbol(), 0, 0);
    popMatrix();
  }

  // 駒文字を返す
  String symbol() {
    if      (type.equals("FU")) return "歩";
    else if (type.equals("KY")) return "香";
    else if (type.equals("KE")) return "桂";
    else if (type.equals("GI")) return "銀";
    else if (type.equals("KI")) return "金";
    else if (type.equals("KA")) return "角";
    else if (type.equals("HI")) return "飛";
    else if (type.equals("OU")) return "王";
    else if (type.equals("TO")) return "と";
    else if (type.equals("NY")) return "成香";
    else if (type.equals("NK")) return "成桂";
    else if (type.equals("NG")) return "成銀";
    else if (type.equals("UM")) return "馬";
    else if (type.equals("RY")) return "龍";
    return type;
  }

  // 自動成り（対話なし）
  boolean tryPromote() {
    boolean canPromote = (type.equals("FU")||type.equals("KY")||type.equals("KE")
                       ||type.equals("GI")||type.equals("KA")||type.equals("HI"));
    if (!canPromote) return false;
    if ((owner == 0 && row > 2) || (owner == 1 && row < 6)) return false;
    type = promoteType(type);
    return true;
  }

  String promoteType(String t) {
    if      (t.equals("FU")) return "TO";
    else if (t.equals("KY")) return "NY";
    else if (t.equals("KE")) return "NK";
    else if (t.equals("GI")) return "NG";
    else if (t.equals("KA")) return "UM";
    else if (t.equals("HI")) return "RY";
    return t;
  }

  String demoteType(String t) {
    if      (t.equals("TO")) return "FU";
    else if (t.equals("NY")) return "KY";
    else if (t.equals("NK")) return "KE";
    else if (t.equals("NG")) return "GI";
    else if (t.equals("UM")) return "KA";
    else if (t.equals("RY")) return "HI";
    return t;
  }

  // 全駒種をカバーした移動ロジック
  ArrayList<PVector> getMoves(Board b) {
    ArrayList<PVector> moves = new ArrayList<PVector>();
    int dir = (owner == 0) ? -1 : 1;

    // 歩
    if (type.equals("FU")) {
      int r2 = row + dir, c2 = col;
      if (r2>=0&&r2<9) {
        Piece t = b.grid[r2][c2];
        if (t==null||t.owner!=owner) moves.add(new PVector(r2,c2));
      }
    }
    // 香
    else if (type.equals("KY")) {
      for (int r2=row+dir; r2>=0&&r2<9; r2+=dir) {
        Piece t=b.grid[r2][col];
        if (t==null) moves.add(new PVector(r2,col));
        else { if (t.owner!=owner) moves.add(new PVector(r2,col)); break; }
      }
    }
    // 桂
    else if (type.equals("KE")) {
      int[][] offs = (owner==0) ? new int[][]{{-2,-1},{-2,1}} : new int[][]{{2,-1},{2,1}};
      for (int[] d: offs) {
        int r2=row+d[0], c2=col+d[1];
        if (r2>=0&&r2<9&&c2>=0&&c2<9) {
          Piece t=b.grid[r2][c2];
          if (t==null||t.owner!=owner) moves.add(new PVector(r2,c2));
        }
      }
    }
    // 銀
    else if (type.equals("GI")) {
      int[][] dirs = (owner==0) ? new int[][]{{-1,0},{-1,-1},{-1,1},{1,-1},{1,1}} : new int[][]{{1,0},{1,-1},{1,1},{-1,-1},{-1,1}};
      for (int[] d: dirs) {
        int r2=row+d[0], c2=col+d[1];
        if (r2>=0&&r2<9&&c2>=0&&c2<9) {
          Piece t=b.grid[r2][c2];
          if (t==null||t.owner!=owner) moves.add(new PVector(r2,c2));
        }
      }
    }
    // 金・と金・成香・成桂・成銀
    else if (type.equals("KI")||type.equals("TO")||type.equals("NY")
          || type.equals("NK")||type.equals("NG")) {
      int[][] dirs = (owner==0) ? new int[][]{{-1,0},{-1,-1},{-1,1},{0,-1},{0,1},{1,0}} : new int[][]{{1,0},{1,-1},{1,1},{0,-1},{0,1},{-1,0}};
      for (int[] d: dirs) {
        int r2=row+d[0], c2=col+d[1];
        if (r2>=0&&r2<9&&c2>=0&&c2<9) {
          Piece t=b.grid[r2][c2];
          if (t==null||t.owner!=owner) moves.add(new PVector(r2,c2));
        }
      }
    }
    // 角・馬
    else if (type.equals("KA")||type.equals("UM")) {
      int[][] bdirs = {{1,1},{1,-1},{-1,1},{-1,-1}};
      for (int[] d: bdirs) {
        for (int r2=row+d[0],c2=col+d[1]; r2>=0&&r2<9&&c2>=0&&c2<9; r2+=d[0],c2+=d[1]) {
          Piece t=b.grid[r2][c2];
          if (t==null) moves.add(new PVector(r2,c2));
          else { if (t.owner!=owner) moves.add(new PVector(r2,c2)); break; }
        }
      }
      if (type.equals("UM")) {
        for (int[] d: new int[][]{{-1,0},{1,0},{0,-1},{0,1}}) {
          int r2=row+d[0], c2=col+d[1];
          if (r2>=0&&r2<9&&c2>=0&&c2<9) {
            Piece t=b.grid[r2][c2];
            if (t==null||t.owner!=owner) moves.add(new PVector(r2,c2));
          }
        }
      }
    }
    // 飛・龍
    else if (type.equals("HI")||type.equals("RY")) {
      int[][] rdirs = {{1,0},{-1,0},{0,1},{0,-1}};
      for (int[] d: rdirs) {
        for (int r2=row+d[0],c2=col+d[1]; r2>=0&&r2<9&&c2>=0&&c2<9; r2+=d[0],c2+=d[1]) {
          Piece t=b.grid[r2][c2];
          if (t==null) moves.add(new PVector(r2,c2));
          else { if (t.owner!=owner) moves.add(new PVector(r2,c2)); break; }
        }
      }
      if (type.equals("RY")) {
        for (int[] d: new int[][]{{-1,-1},{-1,1},{1,-1},{1,1}}) {
          int r2=row+d[0], c2=col+d[1];
          if (r2>=0&&r2<9&&c2>=0&&c2<9) {
            Piece t=b.grid[r2][c2];
            if (t==null||t.owner!=owner) moves.add(new PVector(r2,c2));
          }
        }
      }
    }
    // 王
    else if (type.equals("OU")) {
      for (int dr=-1; dr<=1; dr++) {
        for (int dc=-1; dc<=1; dc++) {
          if (dr==0&&dc==0) continue;
          int r2=row+dr, c2=col+dc;
          if (r2>=0&&r2<9&&c2>=0&&c2<9) {
            Piece t=b.grid[r2][c2];
            if (t==null||t.owner!=owner) moves.add(new PVector(r2,c2));
          }
        }
      }
    }

    return moves;
  }
}
