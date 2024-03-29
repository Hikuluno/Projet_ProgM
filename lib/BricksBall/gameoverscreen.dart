import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreen extends StatelessWidget {
  final bool isGameOver;
  final function;

  //font
  static var gameFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
          color: Colors.deepOrange[600], letterSpacing: 0, fontSize: 28));

  GameOverScreen({required this.isGameOver, this.function});

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
            children: [
              Container(
                alignment: Alignment(0, -0.3),
                child: Text(
                  'GAME OVER',
                  style: gameFont,
                ),
              ),
              Container(
                alignment: Alignment(0, 0),
                child: GestureDetector(
                    onTap: function,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Container(
                        color: Colors.deepOrange,
                        child: Text(
                          'PLAY AGAIN',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
              )
            ],
          )
        : Container();
  }
}
