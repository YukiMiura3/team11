// === app.pde ===

PFont jpFont;
GameManager game;
boolean started;  

void settings() {
  size(900, 700);
}

void setup() {
  // 日本語フォント設定
  jpFont = createFont("Meiryo UI", 32, true);
  textFont(jpFont);

  // ゲーム本体
  game = new GameManager();
  started = false;
}

void draw() {
  if (!started) {
    // タイトル or ルール画面の描画
    drawTitleScreenWrapper();
  } else {
    background(230, 204, 178);
    game.draw();
  }
}

void mousePressed() {
  if (!started) {
    // タイトル/ルール画面のクリック処理
    titleMousePressed();
  } else {
    game.mousePressed();
  }
}