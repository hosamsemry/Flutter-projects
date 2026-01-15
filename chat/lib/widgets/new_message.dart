import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  
  final _messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  void _sendMessage() async{
    final message = _messageController.text;
    if (message.trim().isEmpty) return;

    final user = FirebaseAuth.instance.currentUser!;

    await FirebaseFirestore.instance.collection('chat').add({
      'text': message,
      'createdAt': Timestamp.now(),
      'email': user.email!,
      'userId': user.uid,
    });
    if (!mounted) return;
    FocusScope.of(context).unfocus();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Send a message...',
              ),
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
              
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
             icon: Icon(Icons.send),
             color: Colors.blue,
             ),
        ],
      ),
    );
  }
}
