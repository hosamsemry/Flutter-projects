import 'dart:math';

class Player {
  static const x = 'X';
  static const o = 'O';
  static const empty = '';

  static List<int> playerX = [];
  static List<int> playerO = [];
}

extension ContainsAll on List<int> {
  bool containsAll(int x , int y , [z]) {
    if(z != null){
      return contains(x) && contains(y) && contains(z);
    }
    return contains(x) && contains(y);
  }
}

class Game {

  void playGame(int index, String activePlayer) {
    if (activePlayer == Player.x) {
      Player.playerX.add(index);
    } else {
      Player.playerO.add(index);
    }
  }

  checkWinner() {
    String winner = '';
    
    if (Player.playerX.containsAll(0, 1, 2) || Player.playerX.containsAll(3, 4, 5) || Player.playerX.containsAll(6, 7, 8) || Player.playerX.containsAll(0, 3, 6) || Player.playerX.containsAll(1, 4, 7) || Player.playerX.containsAll(2, 5, 8) || Player.playerX.containsAll(0, 4, 8) || Player.playerX.containsAll(2, 4, 6)) {
      winner = '${Player.x} is the winner';
    }else if (Player.playerO.containsAll(0, 1, 2) || Player.playerO.containsAll(3, 4, 5) || Player.playerO.containsAll(6, 7, 8) || Player.playerO.containsAll(0, 3, 6) || Player.playerO.containsAll(1, 4, 7) || Player.playerO.containsAll(2, 5, 8) || Player.playerO.containsAll(0, 4, 8) || Player.playerO.containsAll(2, 4, 6)) {
      winner = '${Player.o} is the winner';
    }else{
      winner = '';
    }

    return winner;
  }

  Future<void> autoPlay(String activePlayer) async {
    int index = 0;
    List<int> emptyCells = [];
    
    for (int i = 0; i < 9; i++) {
      if (!Player.playerX.contains(i) && !Player.playerO.contains(i)) {
        emptyCells.add(i);
      }
    }
    
      index = emptyCells[Random().nextInt(emptyCells.length)];
      playGame(index, activePlayer);
    
  }
}
