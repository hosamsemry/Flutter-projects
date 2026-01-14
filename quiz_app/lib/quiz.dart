import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions_data.dart';
import 'package:quiz_app/home.dart';
import 'package:quiz_app/questions.dart';
import 'package:quiz_app/results.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});


  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {

  List<String> selectedAnsers = [];

  void chooseAnser(String answer){
    selectedAnsers.add(answer);

    if(selectedAnsers.length == questions.length){
      setState(() {
        activeScreen= Results(selectedAnsers, restart);        
        selectedAnsers = [];
      });

    }
  }

  Widget? activeScreen;

  @override
  void initState() {
    activeScreen = Home(switchScreen);
    super.initState();
  }

  void switchScreen(){
    setState(() {
      activeScreen = Questions(chooseAnser);
    });
  }

  void restart(){
    setState(() {
        selectedAnsers = [];
      activeScreen= Home(switchScreen);        
    });
  }

  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 3, 109, 196),
          foregroundColor: Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
        ),
      ),
      home: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 0, 130, 236),
              Color.fromARGB(255, 190, 0, 207),
            ],
          ),
        ),
        child: activeScreen ?? SizedBox.shrink(),
      ),
    );
  }
}