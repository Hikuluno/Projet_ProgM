import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/findItPicture.dart';

class FindItCrowd extends StatefulWidget {
  final String uniqueCharacterImage;

  const FindItCrowd({Key? key, this.uniqueCharacterImage = 'bluebaby'}) : super(key: key);

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
  final List<String> _displayedCharList = [];
  late List<Offset> _charPositions;
  late List<Offset> _charMovement;
  late Offset _uniqueCharacterPosition;
  late Offset _uniqueCharacterMovement;
  late int _numberOfCharacters;

  @override
  void initState() {
    super.initState();
    _createCharacters();
    _charPositions = List.filled(_numberOfCharacters, const Offset(0, 0));
    _charMovement = List.filled(_numberOfCharacters, const Offset(0, 0));
    _uniqueCharacterPosition = const Offset(0, 0);
    _uniqueCharacterMovement = const Offset(0, 0);
    _charMovement = List.generate(
      _numberOfCharacters,
      (index) => Offset(
        Random().nextInt(3) - 1, // mouvement horizontal entre -1 et 1
        Random().nextInt(3) - 1, // mouvement vertical entre -1 et 1
      ),
    );
    _uniqueCharacterMovement = Offset(
      Random().nextInt(3) - 1, // mouvement horizontal entre -1 et 1
      Random().nextInt(3) - 1,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _charPositions = List.generate(
          _numberOfCharacters,
          (index) => Offset(
            (Random().nextDouble() - 0.1) * MediaQuery.of(context).size.width, //between -0.1 & 0.9
            ((Random().nextInt(60) - 5) / 100) *
                MediaQuery.of(context).size.height, //between -0.05 & 0.55
          ),
        );

        _uniqueCharacterPosition = Offset(
          Random().nextDouble() * MediaQuery.of(context).size.width,
          Random().nextDouble() * MediaQuery.of(context).size.height,
        );
      });
    });
  }

  void _moveCharacter(int index, {bool uniqueCharacter = false}) {
    if (uniqueCharacter) {
      setState(() {
        double newX =
            _uniqueCharacterPosition.dx + _uniqueCharacterMovement.dx; // déplacement horizontal
        double newY =
            _uniqueCharacterPosition.dy + _uniqueCharacterMovement.dy; // déplacement horizontal
        if (newX < 0) newX = MediaQuery.of(context).size.width;
        if (newX > MediaQuery.of(context).size.width) newX = 0;
        if (newY < 0) newY = MediaQuery.of(context).size.height;
        if (newY > MediaQuery.of(context).size.height) newY = 0;
        _uniqueCharacterPosition = Offset(newX, newY);
      });
    } else {
      setState(() {
        double newX = _charPositions[index].dx + _charMovement[index].dx; // déplacement horizontal
        double newY = _charPositions[index].dy + _charMovement[index].dy; // déplacement horizontal
        if (newX < 0) newX = MediaQuery.of(context).size.width;
        if (newX > MediaQuery.of(context).size.width) newX = 0;
        if (newY < 0) newY = MediaQuery.of(context).size.height;
        if (newY > MediaQuery.of(context).size.height) newY = 0;
        _charPositions[index] = Offset(newX, newY);
      });
    }
  }

  void _createCharacters() {
    _numberOfCharacters = Random().nextInt(21) + 20; // entre 20 et 40 personnages
    String character = '';
    int index;
    for (var i = 0; i < _numberOfCharacters; i++) {
      do {
        index = Random().nextInt(_charList.length);
        character = _charList[index];
      } while (character == widget.uniqueCharacterImage);
      _displayedCharList.add(character);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        for (int i = 0; i < _numberOfCharacters; i++)
          Positioned(
            left: _charPositions[i].dx,
            top: _charPositions[i].dy,
            child: FindItPicture(
              character: _displayedCharList[i],
            ),
          ),
        Positioned(
          left: _uniqueCharacterPosition.dx,
          top: _uniqueCharacterPosition.dy,
          child: FindItPicture(character: widget.uniqueCharacterImage),
        ),
      ],
    );
  }
}
