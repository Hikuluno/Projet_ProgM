import 'package:flutter/material.dart';

class FindItPicture extends StatelessWidget {
  final double size;
  final Image characterImage;
  final double opacity;

  const FindItPicture({super.key, this.size = 100, this.opacity = 1, required this.characterImage});

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
