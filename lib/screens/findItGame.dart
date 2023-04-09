import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/findItCrowd.dart';
import 'package:flutter_application_1/widgets/findItPicture.dart';
import '../widgets/score.dart';
import '../widgets/textColor.dart';

class FindItGame extends StatefulWidget {
  const FindItGame({super.key});
  @override
  FindItGameState createState() => FindItGameState();
}

class FindItGameState extends State<FindItGame> {
  final GlobalKey<ScoreWidgetState> _scoreKey = GlobalKey();
  late ScoreWidget _scoreWidget;
  late Timer _timer;
  bool _isGameRunning = false;
  bool _isGameFinished = false;
  final _random = Random();

  // bool singleTap = true;

  Color borderColor = const Color.fromARGB(235, 221, 212, 221);
  late String characterToFind;
  // Characters list
  List<String> charList = ['azazel', 'bluebaby', 'cain', 'isaac', 'lazarus', 'lilith', 'thelost'];

  late int numberOfDisplayedCharacter;

  @override
  void initState() {
    super.initState();
    _scoreWidget = ScoreWidget(key: _scoreKey);
    // spawnTextColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Find it!'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _scoreWidget,
            ),
          ],
        ),
        body: _isGameRunning
            ? Container(
                color: Colors.black87,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                                decoration:
                                    BoxDecoration(border: Border.all(color: borderColor, width: 4)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FindItPicture(size: 100, character: "azazel"),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: borderColor,
                      thickness: 4,
                    ),
                    const Expanded(
                      child: FindItCrowd(
                        uniqueCharacterImage: 'azazel',
                      ),
                    ),
                  ],
                ),
              )
            : _isGameFinished
                ? GestureDetector(
                    onTap: () async {
                      await Future.delayed(const Duration(milliseconds: 500));

                      setState(() {
                        _isGameFinished = false;
                      });
                    },
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Replay ?',
                            style: TextStyle(
                                fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      startGame();
                    },
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Tap to play',
                            style: TextStyle(
                                fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              'Tap on the character in the crowd as the upscreen one',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )),
                    ),
                  ));
  }

  @override
  void dispose() {
    super.dispose();
    if (_isGameRunning) {
      _timer.cancel();
    }
  }

  void startGame() {
    setState(() {
      _isGameRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Duration of the game
      int duration = 30;
      if (timer.tick >= duration) {
        timer.cancel();
        setState(() {
          _isGameRunning = false;
          _isGameFinished = true;
        });
        return;
      }
    });
  }

  void spawnHead() {
    setState(() {
      characterToFind = charList[_random.nextInt(charList.length)];
    });
  }

  void checkAnswer(String character) {
    if (character == characterToFind) {
      _scoreKey.currentState!.increment();
    }
  }
}
