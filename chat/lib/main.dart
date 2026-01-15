import 'package:chat/screens/auth.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: StreamBuilder(stream: _firebase.authStateChanges(), builder: (context, snapshot){
        if (snapshot.hasError){
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        }
        if (snapshot.hasData){
          return ChatScreen();
        }
        return AuthScreen();
      }),
    );
  }
}

