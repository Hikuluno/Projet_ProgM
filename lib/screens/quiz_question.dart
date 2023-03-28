import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> _quizData =
      []; // The list of quiz questions and answers
  int _currentQuestionIndex = 0; // The index of the current quiz question
  int?
      _selectedOptionIndex; // The index of the selected option (null means no option is selected)
  bool _isAnsweredCorrectly =
      false; // Whether the selected option is the correct answer

  Future<void> _loadQuizData() async {
    final String jsonString =
        await rootBundle.loadString('assets/quiz_data.json');
    final List<dynamic> quizList = json.decode(jsonString);
    setState(() {
      _quizData = quizList.cast<Map<String, dynamic>>();
    });
  }

  @override
  void initState() {
    super.initState();
    _loadQuizData();
  }

  void _selectOption(int? optionIndex) {
    setState(() {
      _selectedOptionIndex = optionIndex;
      _isAnsweredCorrectly =
          optionIndex == _quizData[_currentQuestionIndex]['answer'];
    });
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedOptionIndex = null; // Reset the selected option index
      _isAnsweredCorrectly = false; // Reset the answer status
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_quizData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz Game'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      final currentQuestion = _quizData[_currentQuestionIndex];
      final questionText = currentQuestion['question'] as String;
      final options = currentQuestion['options'] as List<dynamic>;
      return Scaffold(
        appBar: AppBar(
          title: Text('Quiz Game'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Question ${_currentQuestionIndex + 1}:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                questionText,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () => _selectOption(index),
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: _selectedOptionIndex == index
                            ? _isAnsweredCorrectly
                                ? Colors.green
                                : Colors.red
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
            SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: _selectedOptionIndex == null ? null : _nextQuestion,
                child: Text('Next Question'),
              ),
            ),
          ],
        ),
      );
    }
  }
}
