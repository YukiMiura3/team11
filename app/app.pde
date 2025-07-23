PFont jpFont;
GameManager game;
boolean started;  

void settings() {
  size(900, 700);
}

void setup() {
  // 日本語フォントの設定
  jpFont = createFont("Meiryo UI", 32, true);
  textFont(jpFont);

  // ゲーム本体初期化
  game = new GameManager();
  started = false;  // タイトル画面からスタート
}

void draw() {
  if (!started) {
    drawTitleScreen();
  } else {
    background(230, 204, 178);
    game.draw();
  }
}

void mousePressed() {
  if (!started) {
    titleMousePressed();
  } else {
    game.mousePressed();
  }
}

