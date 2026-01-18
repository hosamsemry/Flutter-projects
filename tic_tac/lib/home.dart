import 'package:flutter/material.dart';
import 'package:tic_tac/game_logic.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = '-----';
  Game game = Game();
  bool isSwitched = false;

  Future<void> _onTap(int index) async {
  if ((Player.playerX.isEmpty || !Player.playerX.contains(index)) &&
      (Player.playerO.isEmpty || !Player.playerO.contains(index))) {
    game.playGame(index, activePlayer);
    updateState();
    if (!isSwitched && !gameOver) {
      await game.autoPlay(activePlayer);
      updateState();
    }
  }
}

  void updateState() {
    if(!mounted){
      return;
    }

    setState(() {
      activePlayer = activePlayer == 'X' ? 'O' : 'X';
      turn++;
      String winner = game.checkWinner();
      if(winner.isNotEmpty){
        result = winner;
        gameOver = true;
      }else if(!gameOver && turn == 9){
        result = 'Draw';
        gameOver = true;
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SwitchListTile.adaptive(
                activeThumbColor: Colors.lightGreenAccent,
                title: const Text('Two Player', textAlign: TextAlign.center),
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
              const SizedBox(height: 15),
              Text(
                textAlign: TextAlign.center,
                'Player $activePlayer Turn',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              SizedBox(
                height: 400,
                width: 400,
                child: GridView.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: List.generate(9, (index) {
                    return InkWell(
                      onTap: () {
                        gameOver ? null : _onTap(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromARGB(255, 219, 219, 219),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            Player.playerX.contains(index)
                                ? Player.x
                                : Player.playerO.contains(index)
                                ? Player.o
                                : Player.empty,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Player.playerX.contains(index)
                                  ? Colors.red
                                  : Player.playerO.contains(index)
                                  ? Colors.blue
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 25),
              Text(
                'Result: $result',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    Player.playerX.clear();
                    Player.playerO.clear();
                    activePlayer = 'X';
                    gameOver = false;
                    turn = 0;
                    result = '';
                  });
                },
                icon: const Icon(Icons.refresh),
                label: const Text(
                  'Reset',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
