import 'package:flutter/material.dart';

import 'package:cupid/home.dart';
import 'package:cupid/routes.dart' as routes;
import 'package:cupid/screens/login.dart';
import 'package:cupid/screens/profile_setting_screen.dart';


void main() {
  runApp(CupitterApp());
}

class CupitterApp extends StatelessWidget {
  static const String loginRoute = routes.loginRoute;
  static const String homeRoute = routes.homeRoute;
  static const String test2Route = routes.test2Route;
  static const String profileSettingsRoute = routes.profileSettingsRoute;
  static const String profileSetRoute = routes.profileSetRoute;
  // static const String profileScreenRoute = routes.profileScreenRoute;
  static const String chatScreenRoute = routes.chatScreenRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cupitter',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: HomePage(),
      initialRoute: loginRoute,
      routes: <String, WidgetBuilder>{
        homeRoute: (context) => const HomePage(),
        loginRoute: (context) => const LoginPage(),
        profileSettingsRoute: (context) => ProfileSettingScreen(),
        // profileSetRoute: (context) => ProfileSetView(),
        // profileScreenRoute: (context) => ProfileScreen()
        // chatScreenRoute: (context) => ChatScreen()
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cupitter'),
//       ),
//       body: Center(
//       ),
//     );
//   }
// }
