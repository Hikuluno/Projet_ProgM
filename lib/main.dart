import 'package:flutter/material.dart';
import 'package:flutter_application_1/BricksBall/ball.dart';
import 'package:flutter_application_1/screens/classic.dart';
import 'package:flutter_application_1/screens/findItGame.dart';
import 'package:flutter_application_1/screens/games.dart';
import 'package:flutter_application_1/screens/solo_screen.dart';
import 'package:flutter_application_1/screens/targetGame.dart';
import 'package:flutter_application_1/screens/textColorGuess.dart';
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
        '/classic': (context) => const Classic(),
        '/quiz': (context) => const QuizPage(),
        '/textColorGuess': (context) => const TextColorGuess(),
        '/targetGame': (context) => const TargetGame(),
        '/findItGame': (context) => const FindItGame(),
        '/ballgame': (context) => const BallGame(),
      },
    );
  }
}
