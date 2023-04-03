import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/games.dart';
import 'package:flutter_application_1/screens/greenlight.dart';
import 'package:flutter_application_1/screens/solo_screen.dart';
import 'package:flutter_application_1/screens/target_game.dart';
import './screens/home_screen.dart';
import './screens/quiz_question.dart';
import './screens/multiplayer_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Best Games',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomeScreen(),
        '/solo': (context) => const SoloScreen(),
        '/multiplayer': (context) => const MultiplayerScreen(),
        '/games': (context) => const Games(),
        '/quiz': (context) => const QuizPage(),
        '/greenlight': (context) => const GreenLight(),
        '/target_game': (context) => TargetGame(),
      },
    );
  }
}
