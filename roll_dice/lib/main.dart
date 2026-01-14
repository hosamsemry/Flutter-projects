import 'package:flutter/material.dart';
import 'package:roll_dice/dice_roller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Roller Dice"),
          backgroundColor: const Color.fromARGB(255, 47, 167, 0),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentGeometry.directional(0, 1.75),
              end: AlignmentGeometry.directional(1.75, 0),
              colors: [
                const Color.fromARGB(255, 255, 0, 234),
                const Color.fromARGB(255, 90, 0, 0),
              ],
            ),
          ),

          child: DiceRoller(),
        ),
      ),
    );
  }
}
