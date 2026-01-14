import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'data/questions_data.dart';

class Questions extends StatefulWidget {
  const Questions(this.onSelectedAnswer,{super.key});

  final void Function(String) onSelectedAnswer;



  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  int currentQuestionIndex = 0;

  void _nextQuestion() {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
    });
  }

  void _previousQuestion() {
    setState(() {
      currentQuestionIndex = (currentQuestionIndex - 1) % questions.length;
    });
  }

  void answerQuestion(String answer){
    setState(() {
      widget.onSelectedAnswer(answer);
      currentQuestionIndex = (currentQuestionIndex + 1) % questions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final current = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Questions page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              current.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...current.answers.map((answer) {
              return AnswerButton(answerText: answer, onPressed: () {
                answerQuestion(answer);
              });
            }),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _previousQuestion,
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment(0, 0),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Previous Question'),
                ),
                ElevatedButton(
                  onPressed: _nextQuestion,
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment(0, 0),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Next Question'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
