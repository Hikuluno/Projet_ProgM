import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/solo',
                );
              },
              child: const Text('SOLO'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/multiplayer',
                );
              },
              child: const Text('MULTIPLAYER'),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: const Text('EXIT'),
            ),
          ],
        ),
      ),
    );
  }
}
