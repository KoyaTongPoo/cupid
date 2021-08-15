import 'package:cupid/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import 'package:cupid/widgets/notification_badge.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeReal extends StatefulWidget {
  @override
  _HomeRealState createState() => _HomeRealState();
}

class _HomeRealState extends State<HomeReal> {
  @override
  Widget build(BuildContext context) {
    // final seekerNameSnapshot = FirebaseFirestore.instance
    //     .collection('request')
    //     .where('seekerName',
    //         isEqualTo: FirebaseAuth.instance.currentUser!.displayName)
    //     .get();
    // final cupidNameSnapshot = FirebaseFirestore.instance
    //       .collection('request')
    //       .where('pairCupidName',
    //           isEqualTo: FirebaseAuth.instance.currentUser!.displayName)
    //       .get();
    // final bothSnapshots = seekerNameSnapshot  cupidNameSnapshot;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('request')
          .where(
            'chatID',
            arrayContains: FirebaseAuth.instance.currentUser!.uid,
          )
          .snapshots(),
      builder:
          (ctx, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final usersDocs = snapshot.data!.docs;
        return ListView.builder(
          reverse: false,
          itemCount: usersDocs.length,
          itemBuilder: (ctx, index) => MatchListTile(
              usersDocs[index].data()['pairCupidID'].toString(),
              usersDocs[index].data()['pairCupidName'].toString(),
              usersDocs[index].data()['seekerID'].toString(),
              usersDocs[index].data()['seekerName'].toString()),
        );
      },
    );
  }
}

class MatchListTile extends StatelessWidget {
  MatchListTile(
    this.cupidID,
    this.cupidName,
    this.seekerID,
    this.seekerName,
  );

  final String cupidID;
  final String cupidName;
  final String seekerID;
  final String seekerName;

  void _selectMatchTile(BuildContext ctx) {
    Navigator.of(ctx).pushNamed<void>(
      ChatScreen.routeName,
      arguments: {
        'cupidID': cupidID,
        'cupidName': cupidName,
        'seekerID': seekerID,
        'seekerName': seekerName,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black45),
          ),
        ),
        child: ListTile(
          // minVerticalPadding: 10,
          // tileColor: color,
          horizontalTitleGap: 13,
          onTap: () {
            _selectMatchTile(context);
          },
          onLongPress: () {},
          leading: ClipOval(
            child: Image.asset(
              'images/pic4.png',
            ),
          ),
          title: (seekerID == userid) ?
          Text(cupidName, style: const TextStyle(fontSize: 18)) : Text(seekerName, style: const TextStyle(fontSize: 18)),
          // subtitle: const Text(
          //     'ITで過去の依頼データを利用してあなたにピッタリなマッチを提供します。'), //現役のエンジニアでプログラミング経験豊富
          // isThreeLine: false,
          dense: true,
          trailing: NotificationNumberBadge(),
        ),
      ),
    );
  }
}

// Navigator.push<void>(
//   context,
//   MaterialPageRoute<dynamic>(
//     builder: (context) => ChatScreen(),
//   ),
// );

// Column(
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     Container(
//       child: TextButton(
//         onPressed: () {
//           Navigator.push<void>(
//             context,
//             MaterialPageRoute<dynamic>(
//               builder: (context) => ChatScreen(),
//             ),
//           );
//         },
//         child: const Text('chat'),
//       ),
//     ),
//   ],
// );
