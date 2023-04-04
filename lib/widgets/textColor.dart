import 'package:flutter/material.dart';

class TextColor extends StatelessWidget {
  final double size;
  final Color textColor;
  final Color bgColor;
  final String text;
  final bool bold;
  final bool isRounded;
  final double fontSize;

  const TextColor(
      {super.key,
      this.size = 100,
      this.textColor = Colors.red,
      this.bgColor = Colors.yellow,
      this.text = "Blue",
      this.bold = false,
      this.fontSize = 14,
      this.isRounded = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Center(
          child: Text(text,
              style: TextStyle(
                  color: textColor,
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                  fontSize: fontSize))),
    );
  }
}
