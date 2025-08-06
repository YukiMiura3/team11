class GameManager {
  Board board;
  Player S, G, current;
  Piece selectedPiece;
  boolean fromHand;
  int handIdx;
  ArrayList<PVector> possible;
  boolean gameOver;

  void setup() {
    board = new Board(225, 100, 50);
    S = new Player(0);
    G = new Player(1);
    current = S;
    selectedPiece = null;
    fromHand = false;
    handIdx = -1;
    possible = new ArrayList<PVector>();
    gameOver = false;
    initBoard();
  }

  // 王以外を「元の駒があったマス」にランダム配置（コードのみをシャッフル）
  void initBoard() {
    
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        board.grid[r][c] = null;
      }
    }

    
    String[][] init = {
      {"G-KY","G-KE","G-GI","G-KI","G-OU","G-KI","G-GI","G-KE","G-KY"},
      {"","G-HI","","","","","","G-KA",""},
      {"G-FU","G-FU","G-FU","G-FU","G-FU","G-FU","G-FU","G-FU","G-FU"},
      {"","","","","","","","",""},
      {"","","","","","","","",""},
      {"","","","","","","","",""},
      {"S-FU","S-FU","S-FU","S-FU","S-FU","S-FU","S-FU","S-FU","S-FU"},
      {"","S-KA","","","","","","S-HI",""},
      {"S-KY","S-KE","S-GI","S-KI","S-OU","S-KI","S-GI","S-KE","S-KY"}
    };

    
    ArrayList<String> Gcodes = new ArrayList<String>();
    ArrayList<PVector> Gpos   = new ArrayList<PVector>();
    
    ArrayList<String> Scodes = new ArrayList<String>();
    ArrayList<PVector> Spos   = new ArrayList<PVector>();

    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        String v = init[r][c];
        if (v != null && !v.trim().equals("")) {
          if (v.equals("G-OU") || v.equals("S-OU")) {
            // 王は後で固定
          } else if (v.startsWith("G-")) {
            Gcodes.add(v);
            Gpos.add(new PVector(r, c));
          } else {  // S-*
            Scodes.add(v);
            Spos.add(new PVector(r, c));
          }
        }
      }
    }

    for (int i = Gcodes.size() - 1; i > 0; i--) {
      int j = (int)random(i + 1);
      String tmp = Gcodes.get(i);
      Gcodes.set(i, Gcodes.get(j));
      Gcodes.set(j, tmp);
    }
    for (int i = Scodes.size() - 1; i > 0; i--) {
      int j = (int)random(i + 1);
      String tmp = Scodes.get(i);
      Scodes.set(i, Scodes.get(j));
      Scodes.set(j, tmp);
    }

    for (int i = 0; i < Gcodes.size(); i++) {
      PVector p = Gpos.get(i);
      board.grid[(int)p.x][(int)p.y] = new Piece(Gcodes.get(i), (int)p.x, (int)p.y);
    }
    for (int i = 0; i < Scodes.size(); i++) {
      PVector p = Spos.get(i);
      board.grid[(int)p.x][(int)p.y] = new Piece(Scodes.get(i), (int)p.x, (int)p.y);
    }

    board.grid[0][4] = new Piece("G-OU", 0, 4);
    board.grid[8][4] = new Piece("S-OU", 8, 4);
  }

  void draw() {
    board.draw();
    if (selectedPiece != null && !gameOver) {
      board.showMoves(selectedPiece);
      board.highlightCell(selectedPiece.row, selectedPiece.col);
    }
    S.drawHand(50, 600, 40);
    G.drawHand(50, 20, 40);
    fill(0);
    textSize(24);
    textAlign(LEFT, TOP);
    text((current == S ? "先手(S)" : "後手(G)") + " の番", 50, 530);

    if (gameOver) {
      fill(0, 0, 0, 180);
      rect(0, 0, width, height);
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(36);
      text((current == S ? "先手(S)" : "後手(G)") + "の勝ち！", width/2, height/2);
    }
  }

  void mousePressed() {
    if (gameOver) return;
    if (board.inBoard(mouseX, mouseY)) {
      PVector rc = board.cellFromMouse(mouseX, mouseY);
      int r = int(rc.x), c = int(rc.y);
      Piece p = board.grid[r][c];
      if (fromHand) {
        for (PVector mv : possible) {
          if (mv.x == r && mv.y == c) {
            String code = (current == S ? "S-" : "G-") + current.hand.get(handIdx).type;
            board.grid[r][c] = new Piece(code, r, c);
            current.hand.remove(handIdx);
            endTurn();
            return;
          }
        }
        clearSelection();
        return;
      }
      if (selectedPiece == null) {
        if (p != null && p.owner == current.id) {
          selectedPiece = p;
          possible = p.getMoves(board);
        }
        return;
      }
      for (PVector mv : possible) {
        if (mv.x == r && mv.y == c) {
          Piece tgt = board.grid[r][c];
          if (tgt != null && tgt.owner != current.id) {
            String base = tgt.demoteType(tgt.type);
            if (!base.equals("OU")) current.hand.add(new Piece((current == S ? "S-" : "G-") + base, -1, -1));
          }
          board.grid[selectedPiece.row][selectedPiece.col] = null;
          selectedPiece.row = r;
          selectedPiece.col = c;
          board.grid[r][c] = selectedPiece;
          selectedPiece.tryPromote();
          endTurn();
          return;
        }
      }
      clearSelection();
    }
    // 先手持ち駒
    if (mouseY >= 600 && mouseY < 640) {
      int idx = (mouseX - 50) / 44;
      if (idx >= 0 && idx < S.hand.size()) {
        fromHand = true;
        handIdx = idx;
        selectedPiece = null;
        possible = getDrops(S);
      }
      return;
    }
    // 後手持ち駒
    if (mouseY >= 20 && mouseY < 60) {
      int idx = (mouseX - 50) / 44;
      if (idx >= 0 && idx < G.hand.size()) {
        fromHand = true;
        handIdx = idx;
        selectedPiece = null;
        possible = getDrops(G);
      }
      return;
    }
    // リセット
    if (mouseX > width - 150 && mouseY > height - 50) {
      setup();
    }
  }

  void endTurn() {
    boolean sK = false, gK = false;
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        Piece p = board.grid[r][c];
        if (p != null && p.type.equals("OU")) {
          if (p.owner == 0) sK = true; else gK = true;
        }
      }
    }
    if (!sK || !gK) {
      gameOver = true;
      return;
    }
    current = (current == S ? G : S);
    clearSelection();
  }

  void clearSelection() {
    selectedPiece = null;
    fromHand = false;
    handIdx = -1;
    possible.clear();
  }

  ArrayList<PVector> getDrops(Player pl) {
    ArrayList<PVector> ds = new ArrayList<PVector>();
    for (int r = 0; r < 9; r++) {
      for (int c = 0; c < 9; c++) {
        if (board.grid[r][c] == null) ds.add(new PVector(r, c));
      }
    }
    return ds;
  }
}
