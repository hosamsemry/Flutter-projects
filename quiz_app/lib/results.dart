import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions_data.dart';

class Results extends StatelessWidget {
  const Results(this.selectedAnswers, this.restart, {super.key});
  final List<String> selectedAnswers;
  final void Function() restart;

  List<Map<String, Object>> getSummaryData() {

    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < selectedAnswers.length; i++) {
      summary.add({
        'question_index': i + 1,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': selectedAnswers[i],
      });
    }
    return summary;
  }

  int get numOfCorrectAnswers {
    var count = 0;
    for(var i = 0; i < getSummaryData().length; i++){
      if(getSummaryData()[i]['user_answer']==getSummaryData()[i]['correct_answer']){
        count++;
      }
    }
    return count;
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: DefaultTextStyle.merge(
          style: const TextStyle(decoration: TextDecoration.none),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 10),
            ...getSummaryData().map(
              (e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${e['question_index'].toString()}. ${e['question'].toString()}',
                    style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    e['user_answer'].toString(),
                    style: TextStyle(color: e['user_answer'] == e['correct_answer']? const Color.fromARGB(255, 2, 243, 2): const Color.fromARGB(255, 92, 6, 0), fontSize: 14),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Correct answer: ${e['correct_answer'].toString()}',
                    style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255), fontSize: 14),
                  ),
                  Text('-------------------', style: TextStyle(color: Colors.black),),
                  SizedBox(height: 10,),
                ],
              ),
            ),
            Text('Total Correct Answers: ${numOfCorrectAnswers}', style: TextStyle(color: Colors.black, fontSize: 20),),
            SizedBox(height: 20,),
              TextButton(
              onPressed: restart,
              style: TextButton.styleFrom(
                textStyle: const TextStyle(decoration: TextDecoration.none),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: Text("Home",),
            ),
          ],
        ),
      ),

      )
    );
  }
}
