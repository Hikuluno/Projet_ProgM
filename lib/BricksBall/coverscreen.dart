import 'package:flutter/material.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;

  CoverScreen({required this.hasGameStarted});

  @override
  Widget build(BuildContext context) {
    return hasGameStarted
        ? Container()
        : Container(
            alignment: Alignment(0, -0.1),
            child: Text(
              'tap to play',
              style: TextStyle(color: Colors.deepOrange[400]),
            ),
          );
  }
}
