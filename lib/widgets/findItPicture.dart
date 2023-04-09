import 'package:flutter/material.dart';

class FindItPicture extends StatelessWidget {
  final double size;
  final Image characterImage;
  final double opacity;

  FindItPicture({super.key, this.size = 100, String character = 'bluebaby', this.opacity = 1})
      : characterImage = Image.asset(
          'assets/images/$character.png',
          width: size,
          fit: BoxFit.fitWidth,
        );

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: SizedBox(
        width: size,
        height: size,
        child: characterImage,
      ),
    );
  }
}
