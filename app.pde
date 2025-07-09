GameManeger game;

void seup(){
    size(720,720);
    game = new GameManeger();
    game.setuo();
}

void draw(){
    background(255);
    game.draw();
}

void mousePressed(){
    game.handleMouse(mouseX,mouseY);
}