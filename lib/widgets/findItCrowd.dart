import 'dart:math';
import 'package:indexed/indexed.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_application_1/widgets/findItPicture.dart';

class FindItCrowd extends StatefulWidget {
  final String uniqueCharacterImage;
  final Function(String) onCharacterTap;

  const FindItCrowd(
      {Key? key, this.uniqueCharacterImage = 'bluebaby', required this.onCharacterTap})
      : super(key: key);

  @override
  FindItCrowdState createState() => FindItCrowdState();
}

class FindItCrowdState extends State<FindItCrowd> {
  late final List<String> _charList = [
    'azazel',
    'bluebaby',
    'cain',
    'isaac',
    'lazarus',
    'lilith',
    'thelost'
  ];
  List<Image> _charListImage = [];
  final List<String> _displayedCharList = [];
  final List<Image> _displayedCharImageList = [];
  late List<Offset> _charPositions;
  late List<Offset> _charMovement;
  late Offset _uniqueCharacterPosition;
  late Offset _uniqueCharacterMovement;
  late int _numberOfCharacters;
  late final Ticker ticker;
  late final double width;
  late final double height;
  double opacity = 1;
  int _uniqueCharacterIndex = 0;

  @override
  void initState() {
    super.initState();
    createCharListImage();
    _createCharacters();
    _charPositions = List.filled(_numberOfCharacters, const Offset(0, 0));
    _charMovement = List.filled(_numberOfCharacters, const Offset(0, 0));
    _uniqueCharacterPosition = const Offset(0, 0);
    _uniqueCharacterMovement = const Offset(0, 0);
    _charMovement = List.generate(
      _numberOfCharacters,
      (index) => Offset(
        Random().nextInt(3) - 1, // mouvement horizontal entre -1, 0 et 1
        Random().nextInt(3) - 1, // mouvement vertical entre -1, 0 et 1
      ),
    );
    _uniqueCharacterMovement = Offset(
      Random().nextInt(1) * 2 - 1, // mouvement horizontal entre -1 et 1
      Random().nextInt(1) * 2 - 1, // mouvement vertical entre -1 et 1
    );

    ticker = Ticker((_) {
      for (int i = 0; i < _numberOfCharacters; i++) {
        _moveCharacter(i);
      }
      _moveCharacter(0, uniqueCharacter: true);
    });

    ticker.start();
  }

  void createCharListImage() {
    _charListImage = _charList.map((character) {
      return Image.asset(
        'assets/images/$character.png',
        width: 100,
        fit: BoxFit.fitWidth,
      );
    }).toList();
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        width = MediaQuery.of(context).size.width;
        height = MediaQuery.of(context).size.height;
        _charPositions = List.generate(
            _numberOfCharacters,
            (index) => Offset(
                (Random().nextDouble() - 0.1) * width, //between -0.1 & 0.9
                ((Random().nextInt(60) - 5) / 100) * height)); //between -0.05 & 0.55

        _uniqueCharacterPosition = Offset(
          ((Random().nextInt(120) - 20) / 100) * width, //between -0.3 & 1
          ((Random().nextInt(70) - 10) / 100) * height, //between -0.1 & 0.6
        );
      });
    });
  }

  void _moveCharacter(int index, {bool uniqueCharacter = false}) {
    double speed = 1.5;
    if (uniqueCharacter) {
      setState(() {
        double newX = _uniqueCharacterPosition.dx +
            _uniqueCharacterMovement.dx * speed; // déplacement horizontal
        double newY = _uniqueCharacterPosition.dy +
            _uniqueCharacterMovement.dy * speed; // déplacement horizontal
        if (newX < -0.3 * width) newX = width;
        if (newX > width) newX = -0.3 * width;
        if (newY < -0.15 * height) newY = 0.65 * height;
        if (newY > 0.65 * height) newY = -0.15 * height;
        _uniqueCharacterPosition = Offset(newX, newY);
      });
    } else {
      setState(() {
        double newX =
            _charPositions[index].dx + _charMovement[index].dx * speed; // déplacement horizontal
        double newY =
            _charPositions[index].dy + _charMovement[index].dy * speed; // déplacement horizontal
        if (newX < -0.3 * width) {
          newX = width;
        } else if (newX > width) {
          newX = -0.3 * width;
        }
        if (newY < -0.15 * height) {
          newY = 0.65 * height;
        } else if (newY > 0.65 * height) {
          newY = -0.15 * height;
        }
        _charPositions[index] = Offset(newX, newY);
      });
    }
  }

  void _createCharacters() {
    _numberOfCharacters = Random().nextInt(21) + 15; // entre 15 et 35 personnages
    String character = '';
    int index;
    for (var i = 0; i < _numberOfCharacters; i++) {
      do {
        index = Random().nextInt(_charList.length);
        character = _charList[index];
      } while (character == widget.uniqueCharacterImage);
      _displayedCharList.add(character);
      _displayedCharImageList.add(_charListImage[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Indexer(
          children: [
            for (int i = 0; i < _numberOfCharacters; i++)
              Indexed(
                index: 1,
                child: Positioned(
                  left: _charPositions[i].dx,
                  top: _charPositions[i].dy,
                  child: GestureDetector(
                    onTap: () {
                      onTap(_displayedCharList[i]);
                    },
                    child: FindItPicture(
                      opacity: opacity,
                      characterImage: _displayedCharImageList[i],
                    ),
                  ),
                ),
              ),
            Indexed(
              index: _uniqueCharacterIndex,
              child: Positioned(
                left: _uniqueCharacterPosition.dx,
                top: _uniqueCharacterPosition.dy,
                child: GestureDetector(
                    onTap: () {
                      onTap(widget.uniqueCharacterImage);
                    },
                    child: FindItPicture(
                      characterImage:
                          _charListImage[_charList.indexOf(widget.uniqueCharacterImage)],
                    )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void onTap(String character) {
    widget.onCharacterTap(character);
    ticker.dispose();
    setState(() {
      opacity = 0.1;
      _uniqueCharacterIndex = 2;
    });
  }
}
