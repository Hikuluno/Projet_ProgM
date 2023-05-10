import 'package:flutter/material.dart';

class ScoreWidget extends StatefulWidget {
  ScoreWidget({Key? key}) : super(key: key);

  @override
  ScoreWidgetState createState() => ScoreWidgetState();
}

class ScoreWidgetState extends State<ScoreWidget> {
  late int _score;

  @override
  void initState() {
    super.initState();
    _score = 0;
  }

  resetScore() {
    setState(() {
      _score = 0;
    });
  }

  int getScore() {
    return _score;
  }

  set value(int newValue) {
    setState(() {
      _score = newValue;
    });
  }

  increment() {
    setState(() {
      _score++;
    });
  }

  void decrement() {
    if (_score > 0) {
      setState(() {
        _score--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Score: $_score',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
