import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> _quizData =
      []; // The list of quiz questions and answers
  int _currentQuestionIndex = 0; // The index of the current quiz question
  final List<int> _alreadyAnsweredQuestionIndex = [];
  int?
      _selectedOptionIndex; // The index of the selected option (null means no option is selected)
  bool _isAnsweredCorrectly =
      false; // Whether the selected option is the correct answer
  int _score = 0;

  bool _isTapped = false;

  Future<void> _loadQuizData() async {
    final String jsonString =
        await rootBundle.loadString('assets/quiz_data.json');
    final List<dynamic> quizList = json.decode(jsonString);
    setState(() {
      _quizData = quizList.cast<Map<String, dynamic>>();
    });
    int length = _quizData.length;
    print("lenght : $length");
    _getRandomQuestion();
  }

  @override
  void initState() {
    super.initState();
    _loadQuizData();
  }

  void _selectOption(int? optionIndex) {
    setState(() {
      _isTapped = true;
      _selectedOptionIndex = optionIndex;
      _isAnsweredCorrectly =
          optionIndex == _quizData[_currentQuestionIndex]['answer'];
      if (_isAnsweredCorrectly) {
        _score++; // Increment the score if the answer is correct
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _getRandomQuestion();
      _selectedOptionIndex = null; // Reset the selected option index
      _isAnsweredCorrectly = false; // Reset the answer status
      _isTapped = false; // Reset the tapped status
    });
  }

  void _getRandomQuestion() {
    int randomInt = Random().nextInt(_quizData.length);
    while (_alreadyAnsweredQuestionIndex.contains(randomInt)) {
      randomInt = Random().nextInt(_quizData.length);
    }
    _currentQuestionIndex = randomInt;
    _alreadyAnsweredQuestionIndex.add(_currentQuestionIndex);
  }

  _QuizPageState() : super() {
    _score = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (_quizData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Game'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  'Score: $_score',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (_currentQuestionIndex > _quizData.length - 1) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Game'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  'Score: $_score',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
        body: Center(
            child: Text(
          _score >= 2 ? "You are a genius!" : "You are a noob!",
          style: const TextStyle(
            fontSize: 24.0,
          ),
        )),
      );
    } else {
      final currentQuestion = _quizData[_currentQuestionIndex];
      final questionText = currentQuestion['question'] as String;
      final options = currentQuestion['options'] as List<dynamic>;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Game'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: Text(
                  'Score: $_score',
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Question ${_currentQuestionIndex + 1}:',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                questionText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 30.0,
                  color: Color.fromARGB(255, 41, 7, 7),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.grey,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      if (!_isTapped) {
                        _selectOption(index);
                      }
                    },
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _selectedOptionIndex == index
                            ? _isAnsweredCorrectly
                                ? Colors.green
                                : Colors.red
                            : _isTapped &&
                                    index ==
                                        _quizData[_currentQuestionIndex]
                                            ['answer']
                                ? Colors.green
                                : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Text(
                          options[index],
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: _selectedOptionIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: _selectedOptionIndex == null ? null : _nextQuestion,
                child: const Text('Next Question'),
              ),
            ),
          ],
        ),
      );
    }
  }
}
