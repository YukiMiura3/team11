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
>>>>>>> 486241c407ddac296dd913b9de50148bf2321dd8
