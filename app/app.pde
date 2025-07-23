GameManager game;

void setup() {
  size(720, 720);
  game = new GameManager();
  game.setup();
}

void draw() {
  background(255);
  game.draw();
}

void mousePressed() {
  game.handleMouse(mouseX, mouseY);
}
