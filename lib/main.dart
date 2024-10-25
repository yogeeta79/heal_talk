import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:heal_talk/build_confidence.dart';
import 'package:heal_talk/homescreen.dart';
import 'package:heal_talk/loginscreen.dart';
import 'package:heal_talk/registerscreen.dart';
import 'package:heal_talk/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:heal_talk/firebase_service.dart';
import 'package:heal_talk/meditation_screen.dart';
import 'package:heal_talk/journal_screen.dart';
import 'package:heal_talk/profile_screen.dart';
import 'package:heal_talk/mood_tracking_screen.dart';
import 'package:heal_talk/goals_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        Provider<FirebaseService>(create: (_) => FirebaseService()),
      ],
      child: HealTalkApp(),
    ),
  );
}


class HealTalkApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealTalk',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: AuthWrapper(),
      routes: {
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/goals': (context) => GoalsScreen(),
        '/journal': (context) => JournalScreen(),
        '/meditation': (context) => MeditationScreen(),
        '/mood_tracking': (context) => MoodTrackingScreen(),
        '/profile': (context) => ProfileScreen(),
        'Confidence':(context) => BuildConfidenceScreen(),
      },
    );
  }
}
  


class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return HomeScreen(); // User is logged in
        } else {
          return LoginScreen(); // User is NOT logged in
        }
      },
    );
  }
}




