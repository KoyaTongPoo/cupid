import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cupid/widgets/chat/message_bubble.dart';

class Messages extends StatelessWidget {
  Messages(this.cupidID, this.seekerID);

  final String cupidID;
  final String seekerID;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    // final userid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('request')
          .doc(seekerID + cupidID)
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index].data()['text'].toString(),
            chatDocs[index].data()['username'].toString(),
            chatDocs[index].data()['userId'] == user!.uid,
            key: ValueKey(chatDocs[index].id),
          ),
        );
      },
    );
  }
}

//chatDocs[index].data()['userImage'],
