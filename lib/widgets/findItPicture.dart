import 'package:flutter/material.dart';

class FindItPicture extends StatelessWidget {
  final double size;
  final Image characterImage;

  FindItPicture({super.key, this.size = 100, String character = 'bluebaby'})
      : characterImage = Image.asset(
          'assets/images/$character.png',
          width: size,
          fit: BoxFit.fitWidth,
        );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: characterImage,
    );
  }
}
