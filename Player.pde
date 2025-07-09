class Player {
  boolean isMyTurn;

  Player(boolean turn) {
    isMyTurn = turn;
  }

  void toggleTurn() {
    isMyTurn = !isMyTurn;
  }
}