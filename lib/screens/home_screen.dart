import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            SizedBox(height: 10), // Ajoute un espace vertical de 10 pixels
            ElevatedButton(
              onPressed: () {},
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
