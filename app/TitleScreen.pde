void drawTitleScreen() {
  background(50, 100, 150);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(48);
  text("ブラウザ将棋 (王を取ったら勝ち)", width/2, height/2 - 80);

  // 「ゲーム開始」ボタン
  float bw = 200, bh = 60;
  float bx = width/2 - bw/2;
  float by = height/2;
  fill(255, 200);
  rect(bx, by, bw, bh, 10);
  fill(0);
  textSize(32);
  text("ゲーム開始", width/2, by + bh/2);
}

// マウス位置がボタン上かどうか
boolean overStartButton(float mx, float my) {
  float bw = 200, bh = 60;
  float bx = width/2 - bw/2;
  float by = height/2;
  return mx >= bx && mx <= bx + bw && my >= by && my <= by + bh;
}

// タイトル画面でのクリック処理
void titleMousePressed() {
  if (overStartButton(mouseX, mouseY)) {
    started = true;    // app.pde 側の started を切り替える
    game.setup();      // ゲーム初期化
  }
}