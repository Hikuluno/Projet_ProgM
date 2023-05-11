import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/score.dart';
import '../widgets/target.dart';
import 'classic.dart';

class TargetGame extends StatefulWidget {
  final int scoreClassicMode;
  final bool isMultiplayer;
  final bool isClassicMode;
  const TargetGame(
      {super.key,
      this.scoreClassicMode = 0,
      this.isMultiplayer = false,
      this.isClassicMode = false});
  @override
  TargetGameState createState() => TargetGameState();
}

class TargetGameState extends State<TargetGame> {
  final GlobalKey<ScoreWidgetState> _scoreKey = GlobalKey();
  late ScoreWidget _scoreWidget;
  late Timer _timer;
  double size = 100;
  bool _isGameRunning = false;
  bool _isGameFinished = false;
  late double _targetXPosition;
  late double _targetYPosition;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _scoreWidget = ScoreWidget(
      key: _scoreKey,
      score: widget.scoreClassicMode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tap the target'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _scoreWidget,
            ),
          ],
        ),
        body: _isGameRunning
            ? GestureDetector(
                onTap: _onTapTarget,
                child: Stack(
                  children: [
                    Positioned(
                      left: _targetXPosition,
                      bottom: _targetYPosition,
                      child: Container(
                        width: size,
                        height: size,
                        color: Colors.transparent,
                        child: const Target(),
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
                      spawnTarget();
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
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Duration of the game
      int duration = 15;
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

  void spawnTarget() {
    setState(() {
      _targetXPosition = _random.nextDouble() * (MediaQuery.of(context).size.width - size);
      _targetYPosition = _random.nextDouble() * 0.85 * (MediaQuery.of(context).size.height - size);
    });
  }

  void _onTapTarget() {
    _scoreKey.currentState?.increment();
    spawnTarget();
  }
}
