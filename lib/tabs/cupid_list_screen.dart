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
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
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
          // if (usersDocs[index].data()['username'].toString() ==
          //       FirebaseAuth.instance.currentUser!.displayName) 
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
  void _setIrai(String cupidName, String cupidID) async {
    final user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance.collection('irai').add(<String, dynamic>{
      'seekerName': user!.displayName,
      'seekerID': user.uid,
      'pairCupidName': cupidName,
      'pairCupidID': cupidID,
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
          _setIrai(cupidName, id);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
        ),
        child: const Text(
          '??????',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
