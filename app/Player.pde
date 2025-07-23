class Player {
  boolean isMyTurn;

  Player(boolean firstTurn) {
    isMyTurn = firstTurn;
  }

  void toggleTurn() {
    isMyTurn = !isMyTurn;
  }
}