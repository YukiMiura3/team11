<<<<<<< HEAD
PFont jpFont;
=======
<<<<<<< HEAD
GameManager game;

void seup(){
    size(720,720);
    game = new GameManager();
    game.setuo();
}

void draw(){
    background(255);
    game.draw();
}

void mousePressed(){
    game.handleMouse(mouseX,mouseY);
}
=======
>>>>>>> 37958a1897f3961061beb1c6d470fbffbf19b448
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
<<<<<<< HEAD

=======
>>>>>>> 486241c407ddac296dd913b9de50148bf2321dd8
>>>>>>> 37958a1897f3961061beb1c6d470fbffbf19b448
