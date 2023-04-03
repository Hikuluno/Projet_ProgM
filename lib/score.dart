import 'package:flutter/material.dart';

class ScoreWidget extends StatefulWidget {
  const ScoreWidget({Key? key}) : super(key: key);

  @override
  _ScoreWidgetState createState() => _ScoreWidgetState();

  // final GlobalKey<_ScoreWidgetState> _key = GlobalKey();

  // Function() get onIncrement => _onIncrement;
  // Function() get onDecrement => _onDecrement;

  // void _onIncrement() {
  //   _ScoreWidgetState? state = key?.currentState as _ScoreWidgetState?;
  //   state?.increment();
  // }

  // void _onDecrement() {
  //   _ScoreWidgetState? state = _key.currentState as _ScoreWidgetState?;
  //   state?.decrement();
  // }
}

class _ScoreWidgetState extends State<ScoreWidget> {
  late int _score;

  @override
  void initState() {
    super.initState();
    _score = 0;
  }

  set value(int newValue) {
    _score = newValue;
  }

  void increment() {
    _score++;
  }

  void decrement() {
    if (_score > 0) {
      _score--;
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
