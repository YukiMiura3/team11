PFont jpFont;
GameManager game;
boolean started;
PImage komaImage, ouImage;

void settings() {
  size(900, 700);
}

void setup() {
  jpFont = createFont("Meiryo UI", 32, true);
  textFont(jpFont);

  komaImage = loadImage("koma.jpg");
  ouImage   = loadImage("ou.jpg");

  game = new GameManager();
  started = false;
<<<<<<< HEAD
=======

>>>>>>> 12aeecf95e058783b38a43eecdf824c00bcea9a4
}

void draw() {
  if (!started) {
    drawTitleScreenWrapper();
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
