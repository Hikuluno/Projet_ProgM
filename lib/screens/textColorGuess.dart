import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '../widgets/score.dart';
import '../widgets/textColor.dart';

class TextColorGuess extends StatefulWidget {
  const TextColorGuess({super.key});
  @override
  TextColorGuessState createState() => TextColorGuessState();
}

class TextColorGuessState extends State<TextColorGuess> {
  final GlobalKey<ScoreWidgetState> _scoreKey = GlobalKey();
  late ScoreWidget _scoreWidget;
  late Timer _timer;
  bool _isGameRunning = false;
  bool _isGameFinished = false;
  bool singleTap = true;
  final _random = Random();
  List<ColorInfo> colorList = [
    ColorInfo(Colors.purple, "purple"),
    ColorInfo(Colors.yellow, "yellow"),
    ColorInfo(Colors.greenAccent, "green"),
    ColorInfo(Colors.blueAccent, "blue"),
  ];

  // TextColor parameters
  late double size;
  late Color textColor;
  late Color bgColor;
  late String text;

  @override
  void initState() {
    super.initState();
    _scoreWidget = ScoreWidget(key: _scoreKey);
    spawnTextColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Guess text color'),
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
                          child: TextColor(
                              size: size,
                              textColor: textColor,
                              bgColor: bgColor,
                              text: text))),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _onTap("purple");
                                },
                                child: const Text('purple'),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _onTap("yellow");
                                },
                                child: const Text('yellow'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _onTap("green");
                                },
                                child: const Text('green'),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _onTap("blue");
                                },
                                child: const Text('blue'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : _isGameFinished
                ? GestureDetector(
                    onTap: () async {
                      await Future.delayed(const Duration(seconds: 1));

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

  void spawnTextColor() {
    int randomIndex;
    setState(() {
      size = _random.nextInt(150) + 50;
      randomIndex = _random.nextInt(colorList.length);
      textColor = colorList[randomIndex].color;
      randomIndex = _random.nextInt(colorList.length);
      bgColor = colorList[randomIndex].color;
      randomIndex = _random.nextInt(colorList.length);
      text = colorList[randomIndex].name;
    });
  }

  void _onTap(String color) {
    if (singleTap) {
      singleTap = false;
      Timer(const Duration(milliseconds: 500), () {
        if (_isGameRunning && color.toLowerCase() == text.toLowerCase()) {
          _scoreKey.currentState?.increment();
          setState(() {
            // Disable buttons for 0.5 seconds after each correct guess
          });
        }
        spawnTextColor();
        singleTap = true;
      });
    }
  }
}

class ColorInfo {
  final Color color;
  final String name;

  ColorInfo(this.color, this.name);
}
