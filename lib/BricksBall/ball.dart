import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/BricksBall/brick.dart';
import 'package:flutter_application_1/BricksBall/gameoverscreen.dart';
import 'package:flutter_application_1/BricksBall/player.dart';
import 'package:sensors_plus/sensors_plus.dart';

import ' ballon.dart';
import 'coverscreen.dart';

class BallGame extends StatefulWidget {
  const BallGame({Key? key}) : super(key: key);

  @override
  _BallGameState createState() => _BallGameState();
}

class _BallGameState extends State<BallGame> {
  // ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXIncrement = 0.02;
  double ballYIncrement = 0.005;
  var ballYDirection = "DOWN";
  var ballXDirection = "LEFT";

  // player variables
  double playerX = 0.2;
  double playerWidth = 0.4;

  //brick variables
  static double firstBrickX = -1.5 + wallGap;
  static double firstbrickY = -0.9;
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double bricksGap = 0.1;
  static int numberOfBricksInRow = 2;
  static double wallGap = 0.5 *
      (2 -
          numberOfBricksInRow * brickWidth -
          (numberOfBricksInRow - 1) * bricksGap);
  bool brickBroken = false;
  bool allBricksBroken = false;

  List myBricks = [
    [firstBrickX + 0 * (brickWidth + bricksGap), firstbrickY, false],
    [firstBrickX + 1 * (brickWidth + bricksGap), firstbrickY, false],
    [firstBrickX + 2 * (brickWidth + bricksGap), firstbrickY, false],
    [firstBrickX + 3 * (brickWidth + bricksGap), firstbrickY, false]
  ];

  //game settings
  bool hasGameStarted = false;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
    startListening();
  }

  @override
  void dispose() {
    stopListening();
    super.dispose();
  }

  void startListening() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        // Scale the gyroscope values to match the screen width
        playerX += event.y * 0.2;
        if (playerX < -1) {
          playerX = -1;
        } else if (playerX + playerWidth > 1) {
          playerX = 1 - playerWidth;
        }
      });
    });
  }

  void stopListening() {
    gyroscopeEvents.drain();
  }

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      //update direction
      updateDirection();

      //move ball
      moveBall();

      //check game over
      if (isPlayerDead()) {
        timer.cancel();
        isGameOver = true;
      }

      //check if brick is hit
      checkForBrokenBricks();
    });
  }

  //check for broken bricks
  void checkForBrokenBricks() {
    allBricksBroken = myBricks[0][2];
    for (int i = 0; i < myBricks.length; i++) {
      if (ballX >= myBricks[i][0] &&
          ballX <= myBricks[i][0] + brickWidth &&
          ballY < myBricks[i][1] + brickHeight &&
          myBricks[i][2] == false) {
        setState(() {
          myBricks[i][2] = true;
          allBricksBroken = allBricksBroken && myBricks[i][2];

          ////////////////////////////////////////
          double leftSideDist = (myBricks[i][0] - ballX).abs();
          double rightSideDist = (myBricks[i][0] + brickWidth - ballX).abs();
          double topSideDist = (myBricks[i][1] - ballY).abs();
          double bottomSideDist = (myBricks[i][1] - brickHeight - ballY).abs();

          String min =
              findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);

          switch (min) {
            case 'left':
              ballXDirection = "LEFT";
              break;
            case 'right':
              ballXDirection = "RIGHT";
              break;
            case 'up':
              ballYDirection = "UP";
              break;
            case 'down':
              ballYDirection = "DOWN";
              break;
          }
        });
      }
    }
  }

  String findMin(double a, double b, double c, double d) {
    List<double> myList = [
      a,
      b,
      c,
      d,
    ];

    double currentMin = a;
    for (int i = 0; i < myList.length; i++) {
      if (myList[i] < currentMin) {
        currentMin = myList[i];
      }
    }

    if ((currentMin - a).abs() < 0.01) {
      return 'left';
    } else if ((currentMin - b).abs() < 0.01) {
      return 'right';
    } else if ((currentMin - c).abs() < 0.01) {
      return 'top';
    } else if ((currentMin - c).abs() < 0.01) {
      return 'bottom';
    }

    return '';
  }

  //is player dead
  bool isPlayerDead() {
    if (ballY >= 1) {
      return true;
    }
    return false;
  }

  //move ball
  void moveBall() {
    setState(() {
      //move horizontally
      if (ballXDirection == "LEFT") {
        ballX -= ballXIncrement;
      } else if (ballXDirection == "RIGHT") {
        ballX += ballXIncrement;
      }
      //move vertically
      if (ballYDirection == "DOWN") {
        ballY += ballYIncrement;
      } else if (ballYDirection == "UP") {
        ballY -= ballYIncrement;
      }
    });
  }

  //update direction of the ball
  void updateDirection() {
    setState(() {
      //up after player
      if (ballY >= 0.88 && ballX >= playerX && ballX <= playerX + playerWidth) {
        ballYDirection = "UP";
      }
      //down after top screen
      else if (ballY <= -1) {
        ballYDirection = "DOWN";
      }

      //left after right screen
      if (ballX >= 1) {
        ballXDirection = 'LEFT';
      }
      //right after left screen
      else if (ballX <= -1) {
        ballXDirection = 'RIGHT';
      }
    });
  }

  //rest game
  void resetGame() {
    setState(() {
      playerX = -0.2;
      ballX = 0;
      ballY = 0;
      hasGameStarted = false;
      isGameOver = false;
      myBricks = [
        [firstBrickX + 0 * (brickWidth + bricksGap), firstbrickY, false],
        [firstBrickX + 1 * (brickWidth + bricksGap), firstbrickY, false],
        [firstBrickX + 2 * (brickWidth + bricksGap), firstbrickY, false],
        [firstBrickX + 3 * (brickWidth + bricksGap), firstbrickY, false],
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrange[100],
        body: Center(
          child: Stack(
            children: [
              //tap to play
              GestureDetector(
                onTap: () {
                  if (!hasGameStarted) {
                    startGame();
                  }
                },
                child: CoverScreen(hasGameStarted: hasGameStarted),
              ),

              // game over screen
              GameOverScreen(
                isGameOver: isGameOver,
                function: resetGame,
              ),

              //ball
              MyBall(
                ballX: ballX,
                ballY: ballY,
              ),

              //player
              MyPlayer(
                playerX: playerX,
                playerWidth: playerWidth,
              ),

              //bricks
              MyBrick(
                brickX: myBricks[0][0],
                brickY: myBricks[0][1],
                brickHeight: brickHeight,
                brickWidth: brickWidth,
                brickBroken: myBricks[0][2],
              ),
              MyBrick(
                brickX: myBricks[1][0],
                brickY: myBricks[1][1],
                brickHeight: brickHeight,
                brickWidth: brickWidth,
                brickBroken: myBricks[1][2],
              ),
              MyBrick(
                brickX: myBricks[2][0],
                brickY: myBricks[2][1],
                brickHeight: brickHeight,
                brickWidth: brickWidth,
                brickBroken: myBricks[2][2],
              ),
              MyBrick(
                brickX: myBricks[3][0],
                brickY: myBricks[3][1],
                brickHeight: brickHeight,
                brickWidth: brickWidth,
                brickBroken: myBricks[3][2],
              )
            ],
          ),
        ));
  }
}
