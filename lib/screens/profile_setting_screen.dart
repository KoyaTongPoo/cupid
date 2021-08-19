import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileSettingScreen extends StatefulWidget {
  static const routeName = '/profile-setting-screen';
  @override
  _ProfileSettingScreenState createState() => _ProfileSettingScreenState();
}

final nameController = TextEditingController();
final introductionController = TextEditingController();
final ageController = TextEditingController();

final genders = <String>['女', '男', 'その他'];
String _selectedGender = '　';

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
    void _cupertinoPicker(BuildContext context) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 4,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: CupertinoPicker(
                itemExtent: 40,
                children: genders.map((numbar) => new Text(numbar)).toList(),
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedGender = genders[index];
                  });
                },
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール編集'),
        backgroundColor: Colors.pink.shade200,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'シーカー名',
              border: OutlineInputBorder(),
            ),
            controller: nameController,
            // onSubmitted: null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: '自己紹介文を設定する',
              border: OutlineInputBorder(),
            ),
            controller: introductionController,
            // onFieldSubmitted: null,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              labelText: '年齢を入力してください',
              border: OutlineInputBorder(),
            ),
            controller: ageController,
          ),
          const SizedBox(height: 20),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _cupertinoPicker(context);
                },
                child: const Text('Select Gender'),
              ),
              SizedBox(width: 20),
              Text(':  $_selectedGender')
            ],
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.purple),
            ),
            onPressed: () {
              Navigator.pop(context);
              // _sendDataBack(context);
            },
            child: const Text('編集を保存'),
          ),
          SaveProfile(introductionController.toString())
          // うまくいかない。変なのが格納される
        ],
      ),
    );
  }
}

class SaveProfile extends StatelessWidget {
  final String age;

  SaveProfile(
    this.age,
  );

  @override
  Widget build(BuildContext context) {
    CollectionReference profile =
        FirebaseFirestore.instance.collection('profile');
    final userID = FirebaseAuth.instance.currentUser!.uid;

    Future<void> saveProfile() {
      return profile.doc(userID).set(
        <String, dynamic>{
          'age': age,
        },
      );
    }

    return TextButton(
      onPressed: saveProfile,
      child: Text(
        "Save Profile",
      ),
    );
  }
}
