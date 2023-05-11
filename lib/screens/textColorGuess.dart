import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import '../widgets/score.dart';
import '../widgets/textColor.dart';
import 'classic.dart';

class TextColorGuess extends StatefulWidget {
  final int scoreClassicMode;
  final bool isMultiplayer;
  final bool isClassicMode;
  const TextColorGuess(
      {super.key,
      this.scoreClassicMode = 0,
      this.isMultiplayer = false,
      this.isClassicMode = true});
  @override
  TextColorGuessState createState() => TextColorGuessState();
}

class TextColorGuessState extends State<TextColorGuess> {
  final GlobalKey<ScoreWidgetState> _scoreKey = GlobalKey();
  late ScoreWidget _scoreWidget;
  late Timer _timer;
  int timerSeconds = 0;
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
  late bool bold;
  late bool isRounded;
  late double fontSize;

  @override
  void initState() {
    super.initState();
    _scoreWidget = ScoreWidget(
      key: _scoreKey,
      score: widget.scoreClassicMode,
    );

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
              child: Column(
                children: [
                  _scoreWidget,
                  Text(
                    'Timer: $timerSeconds',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  )
                ],
              ),
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
                    text: text,
                    bold: bold,
                    fontSize: fontSize,
                    isRounded: isRounded,
                  ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _onTap(colorList[0].color);
                                },
                                child: const Text('purple'),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _onTap(colorList[1].color);
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
                                  _onTap(colorList[2].color);
                                },
                                child: const Text('green'),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _onTap(colorList[3].color);
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
                      if (!widget.isClassicMode) {
                        _scoreKey.currentState!.resetScore();
                      }
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
    // Duration of the game
    int duration = 15;
    timerSeconds = duration;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timerSeconds = duration - timer.tick;
      });
      if (timer.tick >= duration) {
        timer.cancel();
        // MODE CLASSIQUE
        if (widget.isClassicMode) {
          ClassicState? classicState = context.findAncestorStateOfType<ClassicState>();
          classicState?.switchToNextGame(_scoreKey.currentState!.getScore());
        }
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
    int randomIndex2;
    setState(() {
      size = _random.nextInt(200) + 60;
      randomIndex = _random.nextInt(colorList.length);
      textColor = colorList[randomIndex].color;
      randomIndex2 = _random.nextInt(colorList.length);
      while (randomIndex2 == randomIndex) {
        randomIndex2 = _random.nextInt(colorList.length);
      }
      bgColor = colorList[randomIndex2].color;
      randomIndex = _random.nextInt(colorList.length);
      text = colorList[randomIndex].name;
      bold = _random.nextBool();
      isRounded = _random.nextBool();
      fontSize = _random.nextDouble() * 20 + 10;
    });
  }

  void _onTap(Color color) {
    if (singleTap) {
      singleTap = false;
      Timer(const Duration(milliseconds: 500), () {
        print("yeye : ${textColor.toString()}");
        if (_isGameRunning && color == textColor) {
          _scoreKey.currentState?.increment();
          // Disable buttons for 0.5 seconds after each correct guess
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
