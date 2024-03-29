import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/findItCrowd.dart';
import 'package:flutter_application_1/widgets/findItPicture.dart';
import '../widgets/score.dart';
import '../widgets/textColor.dart';
import 'classic.dart';
import 'classic_multiplayer.dart';

class FindItGame extends StatefulWidget {
  final int scoreClassicMode;
  final bool isMultiplayer;
  final bool isClassicMode;
  const FindItGame(
      {super.key,
      this.scoreClassicMode = 0,
      this.isMultiplayer = false,
      this.isClassicMode = false});
  @override
  FindItGameState createState() => FindItGameState();
}

class FindItGameState extends State<FindItGame> {
  final GlobalKey<ScoreWidgetState> _scoreKey = GlobalKey();
  late ScoreWidget _scoreWidget;
  late Timer _timer;
  int timerSeconds = 0;
  bool _isGameRunning = false;
  bool _isGameFinished = false;
  bool reload = false;
  final _random = Random();

  bool singleTap = true;

  Color borderColor = const Color.fromARGB(235, 221, 212, 221);
  late String characterToFind;
  late Image characterToFindImage;
  // Characters list
  final List<String> _charList = [
    'azazel',
    'bluebaby',
    'cain',
    'isaac',
    'lazarus',
    'lilith',
    'thelost'
  ];
  List<Image> _charListImage = [];

  late int numberOfDisplayedCharacter;

  @override
  void initState() {
    super.initState();
    _createCharListImage();
    _scoreWidget = ScoreWidget(
      key: _scoreKey,
      score: widget.scoreClassicMode,
    );

    characterToFind = _charList[_random.nextInt(_charList.length)];
    characterToFindImage = charStringToImage(characterToFind);
  }

  void _createCharListImage() {
    _charListImage = _charList.map((character) {
      return charStringToImage(character);
    }).toList();
  }

  Image charStringToImage(String character) {
    return Image.asset(
      'assets/images/$character.png',
      width: 100,
      fit: BoxFit.fitWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Find it!'),
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
            ? reload
                ?
                // JEU EN COURS D'EXECUTION
                Container(
                    color: Colors.black87,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: borderColor, width: 4)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FindItPicture(
                                          size: 100, characterImage: characterToFindImage),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: borderColor,
                          thickness: 4,
                        ),
                      ],
                    ),
                  )
                : Container(
                    color: Colors.black87,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: borderColor, width: 4)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FindItPicture(
                                        size: 100,
                                        characterImage: characterToFindImage,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: borderColor,
                          thickness: 4,
                        ),
                        Expanded(
                          child: FindItCrowd(
                            uniqueCharacterImage: characterToFind,
                            onCharacterTap: onCharacterTap,
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
                          // SizedBox(
                          //   height: 32,
                          // ),
                          // Padding(
                          //   padding: EdgeInsets.all(24),
                          //   child: Text(
                          //     'Tap on the character in the crowd that matches the character displayed on top of the screen!',
                          //     textAlign: TextAlign.center,
                          //     style: TextStyle(
                          //       fontSize: 22,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
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
    spawnHead();
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
        print("ueeifuhe");
        // MODE CLASSIQUE MULTIJOUEUR
        if (widget.isClassicMode && widget.isMultiplayer) {
          print("stop");
          ClassicMultiplayerState? classicState =
              context.findAncestorStateOfType<ClassicMultiplayerState>();
          classicState?.switchToNextGame(_scoreKey.currentState!.getScore());
        }
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

  void spawnHead() {
    setState(() {
      characterToFind = _charList[_random.nextInt(_charList.length)];
      characterToFindImage = charStringToImage(characterToFind);
    });
  }

  void onCharacterTap(String character) {
    if (singleTap) {
      singleTap = false;
      Timer(const Duration(milliseconds: 1000), () {
        if (character == characterToFind) {
          _scoreKey.currentState!.increment();
        }
        spawnHead();
        singleTap = true;
        setState(() {
          reload = true;
        });
        Timer(const Duration(milliseconds: 50), () {
          setState(() {
            reload = false;
          });
        });
      });
    }
  }
}
