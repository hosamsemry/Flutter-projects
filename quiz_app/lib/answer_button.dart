import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton( {super.key, required this.answerText, required this.onPressed});

  final String answerText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
           onPressed: onPressed,
           style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurple[900],
           ),
           child: Text(answerText, textAlign: TextAlign.center,)
          ),
          SizedBox(height: 20,)
      ],
    );
  }
}
