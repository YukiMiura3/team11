boolean showRules = false;

// タイトル画面描画
void drawTitleScreen() {
  background(50, 100, 150);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(48);
  text("影将棋", width/2, height/2 - 100);

  // ゲーム開始ボタン
  float bw = 200, bh = 60;
  float bx = width/2 - bw/2;
  float by = height/2 - 20;
  fill(255, 200);
  rect(bx, by, bw, bh, 10);
  fill(0);
  textSize(32);
  text("ゲーム開始", width/2, by + bh/2);

  // ルール説明ボタン
  float by2 = by + bh + 20;
  fill(255, 200);
  rect(bx, by2, bw, bh, 10);
  fill(0);
  textSize(32);
  text("ルール説明", width/2, by2 + bh/2);
}

// ルール画面描画
void drawRulesScreen() {
  background(240);
  fill(0);
  textAlign(LEFT, TOP);
  textSize(20);
  String[] lines = {
    "【ルール説明】",
    "・王を取ったら勝ちのシンプル将棋です。",
    "・王以外の駒はランダム配置、種類は見えません。",
    "・移動ルールは通常の将棋と同じです。",
    "・持ち駒は打つことができます。",
    "",
    "↓ 戻る場合は下のボタンをクリック ↓"
  };
  float tx = 50, ty = 80;
  for (int i = 0; i < lines.length; i++) {
    text(lines[i], tx, ty + i * 30);
  }
  // 戻るボタン
  float bw = 120, bh = 40;
  float bx = 20, by = height - bh - 20;
  fill(255, 200);
  rect(bx, by, bw, bh, 8);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(18);
  text("戻る", bx + bw/2, by + bh/2);
}

// タイトル／ルール画面切り替え
void drawTitleScreenWrapper() {
  if (!showRules) drawTitleScreen();
  else            drawRulesScreen();
}

// ボタン領域判定
boolean overStartButton(float mx, float my) {
  float bw = 200, bh = 60;
  float bx = width/2 - bw/2;
  float by = height/2 - 20;
  return mx>=bx && mx<=bx+bw && my>=by && my<=by+bh;
}
boolean overRulesButton(float mx, float my) {
  float bw = 200, bh = 60;
  float bx = width/2 - bw/2;
  float by = height/2 + 40;
  return mx>=bx && mx<=bx+bw && my>=by && my<=by+bh;
}
boolean overBackButton(float mx, float my) {
  float bw = 120, bh = 40;
  float bx = 20, by = height - bh - 20;
  return mx>=bx && mx<=bx+bw && my>=by && my<=by+bh;
}

// タイトル／ルール画面のクリック処理
void titleMousePressed() {
  if (!showRules) {
    if (overStartButton(mouseX, mouseY)) {
      started = true;
      game.setup();
    }
    else if (overRulesButton(mouseX, mouseY)) {
      showRules = true;
    }
  } else {
    if (overBackButton(mouseX, mouseY)) {
      showRules = false;
    }
  }
}
