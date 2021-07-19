import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CupidListScreen extends StatefulWidget {
  @override
  _CupidListScreenState createState() => _CupidListScreenState();
}

class _CupidListScreenState extends State<CupidListScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .where('username',
              isNotEqualTo: FirebaseAuth.instance.currentUser!.displayName)
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
            itemBuilder: (ctx, index) =>
                CupidListTile(
                  usersDocs[index].data()['username'].toString(),
                  usersDocs[index].id,
                )
            // return const Text('Error');
            );
      },
    );
  }
}

class CupidListTile extends StatelessWidget {
  void _setRequest(String cupidName, String cupidID) async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('request').doc(user!.uid + cupidID).set(<String, dynamic>{
      'seekerName': user.displayName,
      'seekerID': user.uid,
      'pairCupidName': cupidName,
      'pairCupidID': cupidID,
      // 'chatID': FirebaseFirestore.instance.collection('request').doc().id
    });
  }

  CupidListTile(
    this.cupidName,
    this.id,
  );

  final String id;
  final String cupidName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: const Icon(
        CupertinoIcons.person_crop_circle,
      ),
      title: Text(cupidName),
      trailing: ElevatedButton(
        onPressed: () {
          _setRequest(cupidName, id);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
        ),
        child: const Text(
          '依頼',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
