import 'package:flutter/material.dart';

class Games extends StatelessWidget {
  const Games({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TRAINING'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/quiz',
                );
              },
              child: const Text('QUIZ'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/textColorGuess',
                );
              },
              child: const Text('GUESS TEXT COLOR'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/targetGame',
                );
              },
              child: const Text('TAP THE TARGET'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/findItGame',
                );
              },
              child: const Text('FIND IT!'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/ballgame',
                );
              },
              child: const Text('BALL'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
