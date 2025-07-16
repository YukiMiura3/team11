class GameManager {

  Board  board;
  Player p1, p2;     // p1 = 先手（上側）, p2 = 後手（下側）
  Piece  selected;   // 現在選択中の駒（なければ null）
  boolean gameOver = false;

  /* ---------- 初期化 ---------- */
  void setup() {
    board = new Board(width);
    board.initialize();
    p1 = new Player(true);   // 先手からスタート
    p2 = new Player(false);
    selected = null;
    gameOver = false;
  }

  /* ---------- 描画 ---------- */
  void draw() {
    board.draw(selected);    // ★ Board.draw に選択駒を渡してハイライト
    if (gameOver) {
      // ゲーム終了時の表示
      fill(0, 150); // 半透明の黒
      rect(0, 0, width, height);
      fill(255);
      textSize(width * 0.1);
      textAlign(CENTER, CENTER);
      text("WIN!", width / 2, height / 2); // "WIN!"の表示
      textSize(width * 0.03);
      text("Click to restart", width / 2, height / 2 + width * 0.08); // 再起動メッセージ
    }
  }

  /* ---------- マウス入力 ---------- */
  void handleMouse(int mx, int my) {
    if (gameOver) {
      // ゲーム終了時はクリックでリスタート
      setup(); // ゲームをリセット
      return;
    }

    int x = int(mx / board.cellSize);
    int y = int(my / board.cellSize);

    Piece clicked        = board.getPiece(x, y);
    boolean player1Turn  = p1.isMyTurn;          // 今手番のプレイヤーを判定

    /* 1. 駒未選択 → 自軍駒をクリックしたら選択 */
    if (selected == null) {
      if (clicked != null && clicked.isMine == player1Turn) {
        selected = clicked;
      }
      return;                                  // ここで処理終了
    }

    /* 2. すでに駒を選択している状態 */

    // 2‑A. 同じ陣営の別駒をクリックしたら選択し直し
    if (clicked != null && clicked.isMine == player1Turn && clicked != selected) {
      selected = clicked;
      return;
    }

    // 2‑B. 移動先が合法かチェック
    if (selected.canMoveTo(x, y, board)) {
      // 自駒マスには置けない（↑で除外済み）、敵駒なら捕獲可
      board.movePiece(selected, x, y);

      // 駒を取った場合、それが幻王かチェック
      if (capturedPiece != null && capturedPiece.name.equals("幻王")) {
        gameOver = true; // 幻王が取られたらゲーム終了
      }

      selected = null;

      // ターン交代
      p1.toggleTurn();
      p2.toggleTurn();
    }
    // 2‑C. 不合法マスをクリックした場合は何もしない
  }
}
