import 'package:chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong!'));
        }
        return ListView.builder(
          reverse: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final message = snapshot.data!.docs[index].data();
            final nextMessage = index + 1 < snapshot.data!.docs.length
                ? snapshot.data!.docs[index + 1].data()
                : null;

            final currentUser = message['userId'] is String ? message['userId'] : '';
            final nextUser = nextMessage != null && nextMessage['userId'] is String ? nextMessage['userId'] : null;

            final isSameUser = currentUser == nextUser;

            String safeText(Map m) => m['text'] is String ? m['text'] : '';

            if (isSameUser) {
              return MessageBubble.next(
                message: safeText(message),
                isMe: currentUser == FirebaseAuth.instance.currentUser!.uid,
              );
            }

            return MessageBubble.first(
              message: safeText(message),
              isMe: currentUser == FirebaseAuth.instance.currentUser!.uid,
            );
          },
        );
      },
    );
  }
}
