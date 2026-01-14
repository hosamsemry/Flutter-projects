import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home(this.switchScreen, {super.key});

  final void Function() switchScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz App', style: TextStyle(fontWeight: FontWeight.bold),)),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,

        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset('images/quiz-logo.png', width: 300),
            SizedBox(height: 40),
            Text(
              'Learn Flutter!',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            SizedBox(height: 20),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
              ),
              onPressed: switchScreen,
              child: Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
