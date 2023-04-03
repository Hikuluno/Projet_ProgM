import 'package:flutter/material.dart';

class SoloScreen extends StatelessWidget {
  const SoloScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SOLO'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () {},
              child: const Text('CLASSIC'),
            ),
            const SizedBox(
                height: 10), // Ajoute un espace vertical de 10 pixels
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/games',
                );
              },
              child: const Text('TRAINING'),
            ),
          ],
        ),
      ),
    );
  }
}
