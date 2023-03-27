import 'package:flutter/material.dart';

class SoloScreen extends StatelessWidget {
  const SoloScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text('CLASSIQUE'),
            ),
            SizedBox(height: 10), // Ajoute un espace vertical de 10 pixels
            ElevatedButton(
              onPressed: () {},
              child: Text('TRAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
