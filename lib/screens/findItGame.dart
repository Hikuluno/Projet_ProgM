import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
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

  // Characters list
  List<String> charList = [
    'azazel',
    'bluebaby',
    'cain',
    'isaac',
    'lazarus',
    'lilith',
    'thelost'
  ];

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
            ? Column(
                children: [
                  Expanded(
                      child: Center(
                    child: FindItPicture(size: 100, character: "bluebaby"),
                  )),
                ],
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
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
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
      int duration = 15;
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
}
