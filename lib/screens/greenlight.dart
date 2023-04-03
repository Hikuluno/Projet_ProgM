import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_application_1/score.dart';

class GreenLight extends StatefulWidget {
  const GreenLight({Key? key}) : super(key: key);

  @override
  _GreenLightState createState() => _GreenLightState();
}

class _GreenLightState extends State<GreenLight> {
  ScoreWidget _scoreWidget = ScoreWidget();

  bool _isStarted = false;
  late bool _isGreen;
  late bool _isRed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green Light'),
        actions: [
          _scoreWidget,
        ],
      ),
      body: !_isStarted
          ? GestureDetector(
              onTap: () {
                setState(() {
                  _isStarted = true;
                });
                _startGame();
              },
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Tap to start',
                      style: TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    SizedBox(height: 32),
                    Text(
                      'Swipe left when red',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Swipe right when green',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ],
                )),
              ),
            )
          : Expanded(
              child: GestureDetector(
                  onPanUpdate: (details) {
                    if (details.delta.dx > 0) {
                      // swipe to the right
                      if (_isGreen) {
                        // _scoreWidget.currentState
                        //     .increment(); // increment the score
                      }
                      _updateColor();
                    } else if (details.delta.dx < 0) {
                      // swipe to the left
                      if (_isRed) {
                        // _scoreWidget.currentState
                        //     .increment(); // increment the score
                      }
                      _updateColor();
                    }
                  },
                  child:
                      Container(color: _isGreen ? Colors.green : Colors.red)),
            ),
    );
  }

  void _startGame() async {
    _isGreen = Random().nextBool();
    _isRed = !_isGreen;
  }

  void _updateColor() {
    _isGreen = Random().nextBool();
    _isRed = !_isGreen;
  }
}
