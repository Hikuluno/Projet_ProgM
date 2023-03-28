import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/games.dart';
import 'package:flutter_application_1/screens/solo_screen.dart';
import './screens/home_screen.dart';
import './screens/quiz_question.dart';

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
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/solo': (context) => const SoloScreen(),
        '/games': (context) => const Games(),
        '/quiz': (context) => QuizPage(),
      },
    );
  }
}
