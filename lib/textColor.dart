import 'package:flutter/material.dart';

class TextColor extends StatelessWidget {
  final double size;
  final Color textColor;
  final Color bgColor;
  final String text;

  const TextColor(
      {super.key,
      this.size = 100,
      this.textColor = Colors.red,
      this.bgColor = Colors.yellow,
      this.text = "Blue"});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: bgColor,
      child: Center(child: Text(text, style: TextStyle(color: textColor))),
    );
  }
}
