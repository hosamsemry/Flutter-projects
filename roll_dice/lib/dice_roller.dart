import 'package:flutter/material.dart';
import 'dart:math';

final random = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  int diceNumber = 1;
  

  void rollDice() {
    setState(() {
      setState(() {
        diceNumber = random.nextInt(6) + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 35),
        Image.asset('images/dice-$diceNumber.png', width: 150, height: 150),
        SizedBox(height: 20),
        MaterialButton(
          padding: EdgeInsets.all(15),
          color: const Color.fromARGB(255, 0, 0, 0),
          onPressed: rollDice,
          child: Text(
            "Roll Dice",
            style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
      ],
    );
  }
}
