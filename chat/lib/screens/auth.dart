import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoggedin = false;
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _enteredEmail;
  var _enteredPassword;
  var _enteredUsername;

  void _submit() async {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid){
      return;
    }if (_isLoggedin){
      try{
        setState(() {
          _isLoading = true;
        });
      final userCredential = await _firebase.signInWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);

      }on FirebaseAuthException catch(e){
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message.toString()))
        );
      }finally{
        setState(() {
          _isLoading = false;
        });
      }

    }else{
      try{
      final userCredential = await _firebase.createUserWithEmailAndPassword(email: _enteredEmail, password: _enteredPassword);

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': _enteredEmail,
        'username': _enteredUsername,
        'createdAt': Timestamp.now(),
      });
        

      }on FirebaseAuthException catch(e){
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message.toString()))
        );
      }
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 30, right: 20, left: 20),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            onSaved: (value)=> _enteredEmail = value,
                            decoration: InputDecoration(
                              label: Text('Email'),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 12),
                          if (!_isLoggedin)
                          TextFormField(
                            onSaved: (value)=> _enteredUsername = value,
                            decoration: InputDecoration(
                              label: Text('Username'),
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            onSaved: (value)=> _enteredPassword = value,
                            decoration: InputDecoration(
                              label: Text('Password'),
                              border: OutlineInputBorder(),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              _formKey.currentState?.save();
                              _submit();
                            },                          
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Colors.black,
                              ),
                              foregroundColor: WidgetStatePropertyAll(
                                Colors.white,
                              ),
                            ),
                            child: Text(_isLoggedin?'Login':'Register'),
                          ),
                          SizedBox(height: 10),
                          TextButton(onPressed: (){
                            
                            setState(() {
                              _isLoggedin = !_isLoggedin;
                            });
                          },
                          child: Text(_isLoggedin?'Create an account':'I already have an account', style: TextStyle(color: Colors.blue),),
                          
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
