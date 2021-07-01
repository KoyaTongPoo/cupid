import 'package:flutter/material.dart';
// import 'package:gallery/studies/rally/tabs/profile_screen.dart';

// import 'package:gallery/studies/rally/routes.dart' as rally_route;

class ProfileSettingScreen extends StatefulWidget {
  @override
  _ProfileSettingScreenState createState() => _ProfileSettingScreenState();
}

final nameController = TextEditingController();
final introductionController = TextEditingController();

class _ProfileSettingScreenState extends State<ProfileSettingScreen> {
  @override
  Widget build(BuildContext context) {
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
          const SizedBox(height: 30),
          TextFormField(
            decoration: const InputDecoration(
              labelText: '自己紹介文を設定する',
              border: OutlineInputBorder(),
            ),
            controller: introductionController,
            // onFieldSubmitted: null,
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.purple),
            ),
            onPressed: () {
              //Navigator.of(context).pushNamed(rally_route.profileScreenRoute);
              _sendDataBack(context);
            },
            child: const Text('編集を保存'),
          ),
        ],
      ),
    );
  }

  // get the text in the TextField and send it back to the FirstScreen
  void _sendDataBack(BuildContext context) {
    var nameToSendBack = nameController.text;
    // String introductionToSendBack = introductionController.text;
    Navigator.pop(context, nameToSendBack);
  }
}
