import 'package:flutter/material.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat-screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   final fbm = FirebaseMessaging.instance;
  //   fbm.requestPermission();
  //   FirebaseMessaging.onMessage.listen((message) {
  //     print(message);
  //     return;
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((message) {
  //      print(message);
  //     return;
  //   });
  //   fbm.subscribeToTopic('chat');
  // }

  @override
  Widget build(BuildContext context) {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    final cupidID = routeArgs['cupidID'].toString();
    final cupidName = routeArgs['cupidName'].toString();
    final seekerID = routeArgs['seekerID'].toString();
    final seekerName = routeArgs['seekerName'].toString();

    return Scaffold(
      appBar: AppBar(
          title: (userID == seekerID) ? Text(cupidName) : Text(seekerName)),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(cupidID, seekerID),
            ),
            NewMessage(cupidID, seekerID),
          ],
        ),
      ),
    );
  }
}

// actions: [
//   DropdownButton(
//     underline: Container(),
//     icon: Icon(
//       Icons.more_vert,
//       color: Theme.of(context).primaryIconTheme.color,
//     ),
//     items: [
//       DropdownMenuItem(
//         value: 'logout',
//         child: Container(
//           child: Row(
//             children: const <Widget>[
//               Icon(Icons.exit_to_app),
//               SizedBox(width: 8),
//               Text('Logout'),
//             ],
//           ),
//         ),
//       ),
//     ],
//     onChanged: (itemIdentifier) {
//       if (itemIdentifier == 'logout') {
//         FirebaseAuth.instance.signOut();
//       }
//     },
//   ),
// ],
