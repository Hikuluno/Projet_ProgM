import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/BricksBall/ball.dart';
import 'package:flutter_application_1/screens/findItGame.dart';
import 'package:flutter_application_1/screens/multiplayer_screen.dart';
import 'package:flutter_application_1/screens/quiz_question.dart';
import 'package:flutter_application_1/screens/targetGame.dart';
import 'package:flutter_application_1/screens/textColorGuess.dart';
import 'package:flutter_application_1/widgets/target.dart';

class ClassicMultiplayer extends StatefulWidget {
  bool isHost;
  final GlobalKey<ClassicMultiplayerState> classicMultiplayerKey =
      GlobalKey<ClassicMultiplayerState>();

  ClassicMultiplayer({super.key, required this.isHost});

  @override
  ClassicMultiplayerState createState() => ClassicMultiplayerState();
}

class ClassicMultiplayerState extends State<ClassicMultiplayer> {
  List<Widget> listOfGames = [];
  List<String> listOfGamesString = [];
  int currentGameIndex = 0;
  int score = 0;
  bool isClassicModeFinished = false;
  int numberOfGames = 3;
  late bool isHost;
  late MultiplayerScreenState? multiplayerState;
  bool synchronized = false;
  Completer<void> synchronizationCompleter = Completer<void>();

  @override
  void initState() {
    super.initState();
    isHost = widget.isHost;

    MultiplayerScreenState? multiplayerState =
        context.findAncestorStateOfType<MultiplayerScreenState>();

    if (isHost) {
      initGamesString();
      multiplayerState?.sendMessage(msg: listOfGamesString.toString());
    }
    // waitForSynchronization();

    initGames(0);
  }

  void updateListOfGamesString(String value) {
    listOfGamesString = value.split(" ");
    print('listgameupdated by socket');
  }

  Future<void> waitForSynchronization() async {
    int i = 0;
    while (!synchronized || i < 10) {
      print('en attente synchronized');
      await Future.delayed(const Duration(milliseconds: 1000));
      i++;
    }
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

  void initGamesString() {
    listOfGamesString.add("quiz");
    if (Random().nextBool()) {
      listOfGamesString.add("targetGame");
    } else {
      listOfGamesString.add("textColorGuess");
    }
    if (Random().nextBool()) {
      listOfGamesString.add("findIt");
    } else {
      listOfGamesString.add("findIt");
      // listOfGamesString.add("ballGame");
    }
  }

  void initGames(int gameNumber) {
    if (gameNumber == 0) {
      // LE MODE CLASSIQUE COMMENCE TOUJOURS PAS LE QUIZZ
      listOfGames.add(const QuizPage(
        isClassicMode: true,
      ));
    } else if (gameNumber == 1) {
      // AJOUTE UN DES DEUX JEUX D'AGILITE
      if (listOfGamesString[gameNumber] == "targetGame") {
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
    } else if (gameNumber == 2) {
      // AJOUTE UN DES DEUX JEUX DE REFLEXION
      if (listOfGamesString[gameNumber] == "findIt") {
        listOfGames.add(FindItGame(
          isClassicMode: true,
          scoreClassicMode: score,
        ));
      } else {
        listOfGames.add(FindItGame(
          isClassicMode: true,
          scoreClassicMode: score,
        ));
        // listOfGames.add(BallGame());
      }
    }
    print("LIST OF GAMES : $listOfGames");
  }

  void switchToNextGame(int gameScore) {
    print("LE SCORE $gameScore");
    setState(() {
      score = gameScore;
      if (currentGameIndex < numberOfGames - 1) {
        currentGameIndex++;
        initGames(currentGameIndex);
      } else {
        isClassicModeFinished = true;
      }
    });
  }
}
