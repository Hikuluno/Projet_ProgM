import 'package:flutter/material.dart';

class Score {
  int _value;

  Score(this._value);

  set value(int newValue) {
    _value = newValue;
  }

  void increment() {
    _value++;
  }

  void decrement() {
    if (_value > 0) {
      _value--;
    }
  }

  Widget build() {
    return Text(
      'Score: $_value',
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
