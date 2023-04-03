import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Games extends StatelessWidget {
  const Games({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TRAINING'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/quiz',
                );
              },
              child: Text('QUIZ'),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              child: Text('GAME2'),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              child: Text('GAME3'),
            ),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              child: Text('GAME4'),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
