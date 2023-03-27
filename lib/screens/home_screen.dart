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
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/solo',
                );
              },
              child: Text('SOLO'),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              child: Text('MULTIJOUEUR'),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text('EXIT'),
            ),
          ],
        ),
      ),
    );
  }
}
