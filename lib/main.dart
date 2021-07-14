import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:cupid/home.dart';
import 'package:cupid/routes.dart' as routes;
import 'package:cupid/screens/login.dart';
import 'package:cupid/screens/profile_setting_screen.dart';
import 'package:cupid/screens/chat_screen.dart';
// import 'package:cupid/screens/profile_set.dart';
// import 'package:cupid/screens/splash_screen.dart';
import 'package:cupid/data/colors.dart';

import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class CupitterAppProvider extends StatefulWidget {
//   @override
//   _CupitterAppProviderState createState() => _CupitterAppProviderState();
// }

// class _CupitterAppProviderState extends State<CupitterAppProvider> {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(providers: [
//       ChangeNotifierProvider(
//         create: (context) => ApplicationState(),
//       builder: (context, _) => CupitterApp(),
//       )
//     ],
//     // child: CupitterApp(),
//     );
//   }
// }

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => CupitterApp(),
    ),
  );
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
    // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    // return FutureBuilder(
    //   // Initialize FlutterFire:
    //   future: _initialization,
    //   builder: (context, appSnapshot) {
        return MaterialApp(
          title: 'Cupitter',
          theme: _buildRallyTheme(),
          debugShowCheckedModeBanner: false,
          home: HomePage(),
          initialRoute: loginRoute,
          routes: <String, WidgetBuilder>{
            homeRoute: (context) => const HomePage(),
            loginRoute: (context) => const LoginPage(),
            profileSettingsRoute: (context) => ProfileSettingScreen(),
            // profileSetRoute: (context) => ProfileSetView(),
            // profileScreenRoute: (context) => ProfileScreen()
            chatScreenRoute: (context) => ChatScreen()
          },
        );
      }

}


  ThemeData _buildRallyTheme() {
    final base = ThemeData.dark();
    return ThemeData(
      appBarTheme: const AppBarTheme(brightness: Brightness.dark, elevation: 0),
      scaffoldBackgroundColor: RallyColors.primaryBackground,
      primaryColor: RallyColors.primaryBackground,
      focusColor: RallyColors.focusColor,
      textTheme: _buildRallyTextTheme(base.textTheme),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(
          color: RallyColors.gray,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: RallyColors.inputBackground,
        focusedBorder: InputBorder.none,
      ),
      visualDensity: VisualDensity.standard,
    );
  }

  TextTheme _buildRallyTextTheme(TextTheme base) {
    return base
        .copyWith(
          bodyText2: GoogleFonts.mPlus1p(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            // letterSpacing: letterSpacingOrNone(0.5),
          ),
          bodyText1: GoogleFonts.mPlus1p(
            fontSize: 40,
            fontWeight: FontWeight.w400,
            // letterSpacing: letterSpacingOrNone(1.4),
          ),
          button: GoogleFonts.mPlus1p(
            fontWeight: FontWeight.w500,
            // letterSpacing: letterSpacingOrNone(2.8),
          ),
          headline5: GoogleFonts.mPlus1p(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            // letterSpacing: letterSpacingOrNone(1.4),
          ),
        )
        .apply(
          displayColor: Colors.white,
          bodyColor: Colors.white,
        );
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


// appSnapshot.connectionState != ConnectionState.done ? SplashScreen() : StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (ctx, userSnapshot) {
//           if (userSnapshot.connectionState == ConnectionState.waiting) {
//             return SplashScreen();
//           }
//           if (userSnapshot.hasData) {
//             return HomePage();
//           }
//           return LoginPage();
//         }),