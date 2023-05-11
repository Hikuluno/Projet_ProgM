import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/BricksBall/ball.dart';
import 'package:flutter_application_1/screens/findItGame.dart';
import 'package:flutter_application_1/screens/quiz_question.dart';
import 'package:flutter_application_1/screens/targetGame.dart';
import 'package:flutter_application_1/screens/textColorGuess.dart';
import 'package:flutter_application_1/widgets/target.dart';

class Classic extends StatefulWidget {
  const Classic({Key? key}) : super(key: key);

  @override
  ClassicState createState() => ClassicState();
}

class ClassicState extends State<Classic> {
  List<Widget> listOfGames = [];
  int currentGameIndex = 0;
  int score = 2;
  bool isClassicModeFinished = false;

  @override
  void initState() {
    super.initState();
    initGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isClassicModeFinished
            ? Center(
                child: Text(
                "Your score : $score",
                style:
                    const TextStyle(fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold),
              ))
            : listOfGames[currentGameIndex]);
  }

  void initGames() {
    // LE MODE CLASSIQUE COMMENCE TOUJOURS PAS LE QUIZZ
    listOfGames.add(const QuizPage(
      isClassicMode: true,
    ));

    // AJOUTE UN DES DEUX JEUX D'AGILITE
    if (Random().nextBool()) {
      listOfGames.add(TargetGame(
        isClassicMode: true,
        scoreClassicMode: score,
      ));
    } else {
      listOfGames.add(TextColorGuess(
        isClassicMode: true,
        scoreClassicMode: score,
      ));
    }

    // AJOUTE UN DES DEUX JEUX DE REFLEXION
    if (Random().nextBool()) {
      listOfGames.add(FindItGame(
        isClassicMode: true,
        scoreClassicMode: score,
      ));
    } else {
      // listOfGames.add(BallGame());
    }
    print("LIST OF GAMES : $listOfGames");
  }

  void switchToNextGame(int gameScore) {
    print("LE SCORE $gameScore");
    setState(() {
      score = gameScore;
      if (currentGameIndex < listOfGames.length - 1) {
        currentGameIndex++;
      } else {
        isClassicModeFinished = true;
      }
    });
  }
}
