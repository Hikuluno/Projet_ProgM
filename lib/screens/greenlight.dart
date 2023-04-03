import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';

class GreenLight extends StatefulWidget {
  const GreenLight({Key? key}) : super(key: key);

  @override
  _GreenLightState createState() => _GreenLightState();
}

class _GreenLightState extends State<GreenLight> {
  bool _isStarted = false;
  bool _isGreen = false;
  bool _isRed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Green Light'),
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
          : GestureDetector(
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  // drag vers la droite
                } else if (details.delta.dx < 0) {
                  // drag vers la gauche
                }
              },
              child: Container(color: _isGreen ? Colors.green : Colors.red)),
    );
  }

  void _startGame() async {
    _isGreen = Random().nextBool();
    _isRed = !_isGreen;
    while (_isStarted) {
      await Future.delayed(const Duration(seconds: 2));
      if (_isStarted) {
        setState(() {
          _isGreen = Random().nextBool();
          _isRed = !_isGreen;
        });
      }
    }
  }
}
