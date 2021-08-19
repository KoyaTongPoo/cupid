import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cupid/widgets/authentication.dart';
import 'package:cupid/widgets/widgets.dart';

class ProfileSetView extends StatelessWidget {
  ProfileSetView({Key? key}) : super(key: key);
  static const routeName = '/profile-set-view';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール編集'),
      ),
      body: ListView(
        children: <Widget>[
          // Image.asset('assets/codelab.png'),
          // const SizedBox(height: 8),
          // const IconAndDetail(Icons.calendar_today, 'October 30'),
          // const IconAndDetail(Icons.location_city, 'San Francisco'),
          // Consumer<ApplicationState>(
          //   builder: (context, appState, _) => Authentication(
          //     email: appState.email,
          //     loginState: appState.loginState,
          //     startLoginFlow: appState.startLoginFlow,
          //     verifyEmail: appState.verifyEmail,
          //     signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
          //     cancelRegistration: appState.cancelRegistration,
          //     registerAccount: appState.registerAccount,
          //     signOut: appState.signOut,
          //   ),
          // ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header('あなたの性別は？'),
          const Paragraph(
            '男性か女性かを選択してください',
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add from here
                // if (appState.genders >= 2)
                //   Paragraph('${appState.genders} people going')
                // else if (appState.genders == 1)
                //   const Paragraph('1 person going')
                // else
                //   const Paragraph('No one going'),
                // To here.
                if (appState.loginState == ApplicationLoginState.loggedIn) ...[
                  // Add from here
                  GenderSelection(
                    state: appState.gender,
                    onSelection: (gender) => appState.gender = gender,
                  ),
                  // To here.
                  // const Header('Discussion'),
                  // GuestBook(
                  //   addMessage: (message) =>
                  //       appState.addMessageToGuestBook(message),
                  //   messages: appState.guestBookMessages,
                  // ),
                ],
              ],
            ),
          ),
          const Header('あなたの性別は2？'),
          const Paragraph(
            '男性か女性かを選択してください2',
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add from here
                // if (appState.genders >= 2)
                //   Paragraph('${appState.genders} people going')
                // else if (appState.genders == 1)
                //   const Paragraph('1 person going')
                // else
                //   const Paragraph('No one going'),
                // To here.
                if (appState.loginState == ApplicationLoginState.loggedIn) ...[
                  // Add from here
                  AgeSelection(
                    state: appState.age,
                    onSelection: (age) => appState.age = age,
                  ),
                  // To here.
                  // const Header('Discussion'),
                  // GuestBook(
                  //   addMessage: (message) =>
                  //       appState.addMessageToGuestBook(message),
                  //   messages: appState.guestBookMessages,
                  // ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
    init2();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseFirestore.instance
        .collection('gender')
        .where('gender', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _genders = snapshot.docs.length;
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        // _guestBookSubscription = FirebaseFirestore.instance
        //     .collection('guestbook')
        //     .orderBy('timestamp', descending: true)
        //     .snapshots()
        //     .listen((snapshot) {
        //   _guestBookMessages = [];
        //   for (final document in snapshot.docs) {
        //     _guestBookMessages.add(
        //       GuestBookMessage(
        //         name: document.data()['name'] as String,
        //         message: document.data()['text'] as String,
        //       ),
        //     );
        //   }
        //   notifyListeners();
        // });
        // Add from here
        _genderSubscription = FirebaseFirestore.instance
            .collection('genders')
            .doc(user.uid)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.data() != null) {
            if (snapshot.data()!['gender'] as bool) {
              _gender = Gender.men;
            } else {
              _gender = Gender.women;
            }
          } else {
            _gender = Gender.unknown;
          }
          notifyListeners();
        });
        // to here
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        // _guestBookMessages = [];
        // _guestBookSubscription?.cancel();
        _genderSubscription?.cancel(); // new
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  // String? _email;
  // String? get email => _email;

  // StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  // List<GuestBookMessage> _guestBookMessages = [];
  // List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  int _genders = 0;
  int get genders => _genders;

  Gender _gender = Gender.unknown;
  StreamSubscription<DocumentSnapshot>? _genderSubscription;
  Gender get gender => _gender;
  set gender(Gender gender) {
    final userDoc = FirebaseFirestore.instance
        .collection('genders')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    if (gender == Gender.men) {
      userDoc.set(<String, dynamic>{'gender': true});
    } else {
      userDoc.set(<String, dynamic>{'gender': false});
    }
  }

  // void startLoginFlow() {
  //   _loginState = ApplicationLoginState.emailAddress;
  //   notifyListeners();
  // }

  // Future<void> verifyEmail(
  //   String email,
  //   void Function(FirebaseAuthException e) errorCallback,
  // ) async {
  //   try {
  //     var methods =
  //         await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
  //     if (methods.contains('password')) {
  //       _loginState = ApplicationLoginState.password;
  //     } else {
  //       _loginState = ApplicationLoginState.register;
  //     }
  //     _email = email;
  //     notifyListeners();
  //   } on FirebaseAuthException catch (e) {
  //     errorCallback(e);
  //   }
  // }

  // Future<void> signInWithEmailAndPassword(
  //   String email,
  //   String password,
  //   void Function(FirebaseAuthException e) errorCallback,
  // ) async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     errorCallback(e);
  //   }
  // }

  // void cancelRegistration() {
  //   _loginState = ApplicationLoginState.emailAddress;
  //   notifyListeners();
  // }

  // Future<void> registerAccount(
  //     String email,
  //     String displayName,
  //     String password,
  //     void Function(FirebaseAuthException e) errorCallback) async {
  //   try {
  //     var credential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     await credential.user!.updateProfile(displayName: displayName);
  //   } on FirebaseAuthException catch (e) {
  //     errorCallback(e);
  //   }
  // }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  // Future<DocumentReference> addMessageToGuestBook(String message) {
  //   if (_loginState != ApplicationLoginState.loggedIn) {
  //     throw Exception('Must be logged in');
  //   }

  //   return FirebaseFirestore.instance
  //       .collection('guestbook')
  //       .add(<String, dynamic>{
  //     'text': message,
  //     'timestamp': DateTime.now().millisecondsSinceEpoch,
  //     'name': FirebaseAuth.instance.currentUser!.displayName,
  //     'userId': FirebaseAuth.instance.currentUser!.uid,
  //   });
  // }

//age age age
  Future<void> init2() async {
    await Firebase.initializeApp();

    FirebaseFirestore.instance
        .collection('age')
        .where('age', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _ages = snapshot.docs.length;
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;

        _ageSubscription = FirebaseFirestore.instance
            .collection('age')
            .doc(user.uid)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.data() != null) {
            if (snapshot.data() != null) {
              _age = Age.men;
            } else {
              _age = Age.women;
            }
          } else {
            _age = Age.unknown;
          }
          notifyListeners();
        });
      } else {
        _loginState = ApplicationLoginState.loggedOut;

        _ageSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  int _ages = 0;
  int get ages => _ages;
  Age _age = Age.unknown;
  StreamSubscription<DocumentSnapshot>? _ageSubscription;
  Age get age => _age;
  set age(Age age) {
    final userDoc = FirebaseFirestore.instance
        .collection('ages')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    if (age == Age.men) {
      userDoc.set(<String, dynamic>{'age': 1});
    } else {
      userDoc.set(<String, dynamic>{'age': 2});
    }
  }
}
//age age age

// class GuestBookMessage {
//   GuestBookMessage({required this.name, required this.message});
//   final String name;
//   final String message;
// }

enum Gender { men, women, unknown }

// class GuestBook extends StatefulWidget {
//   const GuestBook({required this.addMessage, required this.messages});
//   final FutureOr<void> Function(String message) addMessage;
//   final List<GuestBookMessage> messages;

//   @override
//   _GuestBookState createState() => _GuestBookState();
// }

// class _GuestBookState extends State<GuestBook> {
//   final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
//   final _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Form(
//             key: _formKey,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextFormField(
//                     controller: _controller,
//                     decoration: const InputDecoration(
//                       hintText: 'Leave a message',
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Enter your message to continue';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 StyledButton(
//                   onPressed: () async {
//                     if (_formKey.currentState!.validate()) {
//                       await widget.addMessage(_controller.text);
//                       _controller.clear();
//                     }
//                   },
//                   child: Row(
//                     children: const [
//                       Icon(Icons.send),
//                       SizedBox(width: 4),
//                       Text('SEND'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 8),
//         for (var message in widget.messages)
//           Paragraph('${message.name}: ${message.message}'),
//         const SizedBox(height: 8),
//       ],
//     );
//   }
// }

class GenderSelection extends StatelessWidget {
  const GenderSelection({required this.state, required this.onSelection});
  final Gender state;
  final void Function(Gender selection) onSelection;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case Gender.men:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () => onSelection(Gender.men),
                child: const Text('男性'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () => onSelection(Gender.women),
                child: const Text('女性'),
              ),
            ],
          ),
        );
      case Gender.women:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              TextButton(
                onPressed: () => onSelection(Gender.men),
                child: const Text('男性'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () => onSelection(Gender.women),
                child: const Text('女性'),
              ),
            ],
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              StyledButton(
                onPressed: () => onSelection(Gender.men),
                child: const Text('男性'),
              ),
              const SizedBox(width: 8),
              StyledButton(
                onPressed: () => onSelection(Gender.women),
                child: const Text('女性'),
              ),
            ],
          ),
        );
    }
  }
}

/////////////
///
///

enum Age { men, women, unknown }

class AgeSelection extends StatelessWidget {
  const AgeSelection({required this.state, required this.onSelection});
  final Age state;
  final void Function(Age selection) onSelection;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case Age.men:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () => onSelection(Age.men),
                child: const Text('男性'),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () => onSelection(Age.women),
                child: const Text('女性'),
              ),
            ],
          ),
        );
      case Age.women:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              TextButton(
                onPressed: () => onSelection(Age.men),
                child: const Text('男性'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () => onSelection(Age.women),
                child: const Text('女性'),
              ),
            ],
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              StyledButton(
                onPressed: () => onSelection(Age.men),
                child: const Text('男性'),
              ),
              const SizedBox(width: 8),
              StyledButton(
                onPressed: () => onSelection(Age.women),
                child: const Text('女性'),
              ),
            ],
          ),
        );
    }
  }
}
