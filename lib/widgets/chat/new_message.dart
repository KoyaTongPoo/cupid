import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  NewMessage(this.cupidID);

  @override
  _NewMessageState createState() => _NewMessageState(this.cupidID);
  final String cupidID;
}

class _NewMessageState extends State<NewMessage> {
  _NewMessageState(this.cupidID);

  final _controller = TextEditingController();
  var _enteredMessage = '';
  final String cupidID;

  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();
    final userid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('request')
        .doc(userid + cupidID)
        .collection('chat')
        .add(
      <String, dynamic>{
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'username': FirebaseAuth.instance.currentUser?.displayName,
      },
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).accentColor,
            icon: const Icon(
              Icons.send,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}

//'userImage': userData.data()['image_url']
