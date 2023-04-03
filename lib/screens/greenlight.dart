import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_application_1/score.dart';

class GreenLight extends StatefulWidget {
  const GreenLight({Key? key}) : super(key: key);

  @override
  _GreenLightState createState() => _GreenLightState();
}

class _GreenLightState extends State<GreenLight> {
  final GlobalKey<ScoreWidgetState> _scoreKey = GlobalKey();
  late ScoreWidget _scoreWidget;
  bool _isStarted = false;
  bool _isWaiting = false;
  late bool _isGreen;
  late bool _isRed;

  @override
  void initState() {
    super.initState();
    _scoreWidget = ScoreWidget(key: _scoreKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green Light'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _scoreWidget,
          ),
        ],
      ),
      body: !_isStarted
          ? GestureDetector(
              onTap: () {
                setState(() {
                  _isStarted = true;
                });
                _updateColor();
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
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Swipe right when green',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
              ),
            )
          : _isWaiting
              ? Container(
                  color: Theme.of(context).primaryColor,
                  child: const Center(child: Text("Is waiting")))
              : GestureDetector(
                  onPanUpdate: (details) {
                    int sensitivity = 12;
                    print("iswaiting : $_isWaiting");
                    if (details.delta.dx > sensitivity && !_isWaiting) {
                      // swipe to the right
                      if (_isGreen) {
                        setState(() {
                          _scoreKey.currentState
                              ?.increment(); // increment the score
                        });
                      }
                      _updateColor();
                    } else if (details.delta.dx < sensitivity) {
                      // swipe to the left
                      if (_isRed) {
                        setState(() {
                          _scoreKey.currentState
                              ?.increment(); // increment the score
                        });
                      }
                      _updateColor();
                    }
                  },
                  child:
                      Container(color: _isGreen ? Colors.green : Colors.red)),
    );
  }

  Future<void> _updateColor() async {
    setState(() {
      _isGreen = Random().nextBool();
      _isRed = !_isGreen;
    });
  }
}
