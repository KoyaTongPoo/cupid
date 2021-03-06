import 'package:flutter/material.dart';

// import 'package:gallery/studies/rally/screens/chat_screen.dart';
import 'package:cupid/widgets/notification_badge.dart';
// import 'package:gallery/studies/rally/models/dummy_data.dart';
import 'package:cupid/routes.dart' as rally_route;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeReal extends StatefulWidget {
  @override
  _HomeRealState createState() => _HomeRealState();
}

class _HomeRealState extends State<HomeReal> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('irai')
          .where('seekerName',
              isEqualTo: FirebaseAuth.instance.currentUser!.displayName)
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
            usersDocs[index].data()['pairCupidName'].toString(),
            matchKey:
                ValueKey(usersDocs[index].data()['pairCupidID'].toString()),
          ),
        );
      },
    );
    // GridView(
    //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    //       maxCrossAxisExtent: 600,
    //       // maxCrossAxisExtent: ,
    //       childAspectRatio: 6,
    //       crossAxisSpacing: 10,
    //       mainAxisSpacing: 3,
    //     ),
    //     children: dummyCupidPreviews
    //         .map(
    //           (catData) => MatchListTile(
    //             catData.id,
    //             catData.name,
    //             catData.color,
    //           ),
    //         )
    //         .toList());
  }
}

class MatchListTile extends StatelessWidget {
  MatchListTile(this.name, {required this.matchKey});

  final Key matchKey;
  // final String id;
  final String name;

  void _selectMatchTile(BuildContext ctx) {
    Navigator.of(ctx).pushNamed<void>(
      rally_route.chatScreenRoute,
      arguments: {
        'matchKey': matchKey,
        'name': name,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            name,
            style: const TextStyle(fontSize: 18),
          ),
          // subtitle: const Text(
          //     'IT???????????????????????????????????????????????????????????????????????????????????????????????????'), //????????????????????????????????????????????????????????????
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
