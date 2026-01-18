import 'package:flutter/material.dart';
import 'package:tic_tac/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          
          backgroundColor: Color.fromARGB(255, 0, 119, 255),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: Home(),
    );
  }
}