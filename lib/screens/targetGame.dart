import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/score.dart';
import '../widgets/target.dart';

class TargetGame extends StatefulWidget {
  const TargetGame({super.key});
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
  double _targetXPosition = 0;
  double _targetYPosition = 0;
  final _random = Random();

  @override
  void initState() {
    super.initState();
    _scoreWidget = ScoreWidget(key: _scoreKey);
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
    spawnTarget();
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

  void spawnTarget() {
    if (_isGameRunning) {
      setState(() {
        _targetXPosition =
            _random.nextDouble() * (MediaQuery.of(context).size.width - size);
        _targetYPosition =
            _random.nextDouble() * (MediaQuery.of(context).size.height - size);
      });
    }
  }

  void _onTapTarget() {
    _scoreKey.currentState?.increment();
    spawnTarget();
  }
}
