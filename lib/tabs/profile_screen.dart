import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cupid/data/colors.dart';
import 'package:cupid/routes.dart' as rally_route;

import 'package:cupid/screens/profile_setting_screen.dart';
import 'package:cupid/widgets/nestedTabBarView.dart';
// import './home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
// import 'package:gallery/studies/rally/tabs/forum.dart';

import 'package:cupid/widgets/authentication.dart';
import 'package:cupid/screens/login.dart';

void SelectProfileSetting(BuildContext ctx) {
  Navigator.of(ctx).pushNamed(rally_route.profileSettingsRoute);
}

String? seakerNameInput;
String? introductionInput;

class ProfileScreen extends StatefulWidget {
  // final List<Map<String, String>> seakerProfile = [
  //   {'seakerName': 'takaya＠天才プログラマー', ''}
  // ];
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? name = FirebaseAuth.instance.currentUser?.displayName;
  // String introduction = '自己紹介文';

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: SingleChildScrollView(
        child: 
        // Consumer<ApplicationState>(
        //   builder: (context, appState, _) => 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // if (name == null)
              //   Card(
              //     child: Container(
              //       margin: const EdgeInsets.all(4),
              //       // width: 50,
              //       // height: 20,
              //       child: Text(
              //         'シーカー名',
              //         style: TextStyle(fontSize: 20),
              //       ),
              //     ),
              //   ),
              Consumer<ApplicationState>(
                builder: (context, appState, _) => Authentication(
                  email: appState.email,
                  loginState: appState.loginState,
                  startLoginFlow: appState.startLoginFlow,
                  verifyEmail: appState.verifyEmail,
                  signInWithEmailAndPassword:
                      appState.signInWithEmailAndPassword,
                  cancelRegistration: appState.cancelRegistration,
                  registerAccount: appState.registerAccount,
                  signOut: appState.signOut,
                ),
              ),
              Card(
                color: RallyColors.cardBackground,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  // width: 50,
                  // height: 20,
                  child: Text(
                    // nameController.text,
                    // 'takaya＠天才プログラマー',
                    name!,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(),
                  Container(
                    width: screenWidth * 0.6,
                    height: 100,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '信頼されてる',
                          // style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          '信頼している',
                          // style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              // if (introductionController == null)   //これ大丈夫？
              // Container(
              //   margin: const EdgeInsets.all(4),
              //   width: double.infinity,
              //   height: 100,
              //   child: const Text(
              //     '自己紹介文',
              //     style: TextStyle(fontSize: 20),
              //   ),
              // ),
              Card(
                color: RallyColors.cardBackground,
                child: Container(
                  margin: const EdgeInsets.all(4),
                  width: double.infinity,
                  height: 100,
                  child: Text(
                    // introduction,
                    introductionController.text.toString(),
                    // '自己紹介文',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .set(<String, dynamic>{
                          'username':
                              FirebaseAuth.instance.currentUser!.displayName
                        });
                      },
                      // _awaitReturnValueFromSecondScreen(context),
                      style: ButtonStyle(
                        // padding: EdgeInsets.symmetric(),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueGrey),
                      ),
                      child: const Text(
                        'ユーザー登録',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: screenWidth,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(rally_route.profileSetRoute);
                      },
                      // _awaitReturnValueFromSecondScreen(context),
                      style: ButtonStyle(
                        // padding: EdgeInsets.symmetric(),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blueGrey),
                      ),
                      child: const Text(
                        'プロフィールを編集',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              NestedTabBar(),
            ],
          ),
        ),);
  }

  // void _awaitReturnValueFromSecondScreen(BuildContext context) async {
  //   final String? nameInput = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ProfileSettingScreen(),
  //     ),
  //     // ModalRoute.withName(rally_route.profileSettingsRoute)
  //   );

  //   final String? introductionInput = await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ProfileSettingScreen(),
  //     ),
  //   );

  //   // after the SecondScreen result comes back update the Text widget with it
  //   setState(() {
  //     // name = nameInput;
  //     String? introduction = introductionInput;
  //   });
  // }
}

int _attendees = 0;
int get attendees => _attendees;
enum Attending { yes, no, unknown }
Attending _attending = Attending.unknown;
// StreamSubscription<DocumentSnapshot>? _attendingSubscription;
Attending get attending => _attending;
set attending(Attending attending) {
  final userDoc = FirebaseFirestore.instance
      .collection('attendees')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  if (attending == Attending.yes) {
    userDoc.set(<String, dynamic>{'attending': true});
  } else {
    userDoc.set(<String, dynamic>{'attending': false});
  }
}

Future<void> init() async {
  await Firebase.initializeApp();

  // Add from here
  FirebaseFirestore.instance
      .collection('attendees')
      .where('attending', isEqualTo: true)
      .snapshots()
      .listen((snapshot) {
    _attendees = snapshot.docs.length;
    notifyListeners();
  });
  // To here

//   FirebaseAuth.instance.userChanges().listen((user) {
//     if (user != null) {
//       _loginState = ApplicationLoginState.loggedIn;
//       // _guestBookSubscription = FirebaseFirestore.instance
//       //     .collection('guestbook')
//       //     .orderBy('timestamp', descending: true)
//       //     .snapshots()
//       //     .listen((snapshot) {
//       //   _guestBookMessages = [];
//       //   snapshot.docs.forEach((document) {
//       //     _guestBookMessages.add(
//       //       GuestBookMessage(
//       //         name: document.data()['name'],
//       //         message: document.data()['text'],
//       //       ),
//       //     );
//       //   });
//       //   notifyListeners();
//       // });
//       // Add from here
//       _attendingSubscription = FirebaseFirestore.instance
//           .collection('attendees')
//           .doc(user.uid)
//           .snapshots()
//           .listen((snapshot) {
//         if (snapshot.data() != null) {
//           if (snapshot.data()!['attending'] != false) {
//             _attending = Attending.yes;
//           } else {
//             _attending = Attending.no;
//           }
//         } else {
//           _attending = Attending.unknown;
//         }
//         // notifyListeners();
//       });
//       // to here
//     } else {
//       _loginState = ApplicationLoginState.loggedOut;
//       _guestBookMessages = [];
//       _guestBookSubscription?.cancel();
//       _attendingSubscription?.cancel(); // new
//     }
//     // notifyListeners();
//   });
}

void notifyListeners() {}

enum UserSubscription { uid, name, unknown }
// UserSubscription? _userSubscription = UserSubscription.unknown;
// StreamSubscription<DocumentSnapshot>? _userSubscriptionStream;
// UserSubscription? get userSubscription => _userSubscription;
set userSubscription(UserSubscription userSubscription) {
  final userDoc = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  userDoc.set(<String, dynamic>{
    'username': FirebaseAuth.instance.currentUser!.displayName
  });
}
