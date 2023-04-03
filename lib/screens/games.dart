import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                  '/greenlight',
                );
              },
              child: const Text('GREENLIGHT'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              child: const Text('GAME3'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              child: const Text('GAME4'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
