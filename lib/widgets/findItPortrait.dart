import 'package:flutter/material.dart';

class FindItPortrait extends StatelessWidget {
  final double size;
  final Color color;

  const FindItPortrait({super.key, this.size = 100, this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color.fromARGB(213, 252, 234, 234),
        shape: BoxShape.circle,
        border: Border.all(width: size / 20, color: color),
      ),
      child: Container(
        margin: EdgeInsets.all(size / 8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: size / 20, color: color),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          margin: EdgeInsets.all(size / 8),
        ),
      ),
    );
  }
}
