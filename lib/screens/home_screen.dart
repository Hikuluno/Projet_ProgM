import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10), // Ajoute un espace vertical de 10 pixels
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/solo',
                );
              },
              child: Text('SOLO'),
            ),
            SizedBox(height: 10), // Ajoute un espace vertical de 10 pixels
            ElevatedButton(
              onPressed: () {},
              child: Text('MULTIJOUEUR'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text('EXIT'),
            ),
          ],
        ),
      ),
    );
  }
}
