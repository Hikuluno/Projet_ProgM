import 'package:flutter/material.dart';

class FindItPicture extends StatelessWidget {
  final double size;
  late Image characterImage;
  final double opacity;

  FindItPicture(
      {super.key,
      this.size = 100,
      String character = 'bluebaby',
      this.opacity = 1,
      required this.characterImage});
  //     {
  //   if (image == null) {
  //     characterImage = Image.asset(
  //       'assets/images/$character.png',
  //       width: size,
  //       fit: BoxFit.fitWidth,
  //     );
  //   } else {
  //     characterImage = image!;
  //   }
  // }

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
