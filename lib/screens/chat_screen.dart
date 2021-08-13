import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'package:gallery/studies/rally/authentication.dart';

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
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    final cupidID = routeArgs['cupidId'].toString();
    final matchName = routeArgs['name'].toString();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(matchName),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(cupidID),
            ),
            NewMessage(cupidID),
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
