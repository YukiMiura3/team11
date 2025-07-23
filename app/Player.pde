class Player {
  int id;               // 0 = 先手 (S), 1 = 後手 (G)
  ArrayList<Piece> hand;

  Player(int id) {
    this.id = id;
    hand = new ArrayList<Piece>();
  }

  void drawHand(int x, int y, float cell) {
    textAlign(CENTER, CENTER);
    textSize(cell * 0.6);
    for (int i = 0; i < hand.size(); i++) {
      float px = x + (i % 8) * (cell + 4);
      float py = y + (i / 8) * (cell + 4);
      stroke(150);
      fill(id == 0 ? color(255,200,200) : color(200,200,255));
      rect(px, py, cell, cell, 4);
      hand.get(i).drawAt(px + cell/2, py + cell/2, cell * 0.8);
    }
  }
}
