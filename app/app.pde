PFont jpFont;
GameManager game;

void settings() {
  size(900, 700);
}

void setup() {
  // 日本語フォントを作成して設定
  jpFont = createFont("Meiryo", 32);
  textFont(jpFont);
  game = new GameManager();
  game.setup();
}

void draw() {
  background(230, 204, 178);
  game.draw();
}

void mousePressed() {
  game.mousePressed();
}
