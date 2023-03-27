import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _questionNumber = 1; // The current question number
  List<String> _options = [
    'Option A',
    'Option B',
    'Option C',
    'Option D'
  ]; // The four answer options for each question
  int?
      _selectedOptionIndex; // The index of the selected option (null means no option is selected)
  bool _isAnsweredCorrectly =
      false; // Whether the selected option is the correct answer

  void _selectOption(int? optionIndex) {
    setState(() {
      _selectedOptionIndex = optionIndex;
      _isAnsweredCorrectly =
          optionIndex == 1; // Replace 1 with the index of the correct answer
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionNumber++;
      _selectedOptionIndex = null; // Reset the selected option index
      _isAnsweredCorrectly = false; // Reset the answer status
    });
  }

  @override
  Widget build(BuildContext context) {
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
              'Question $_questionNumber:',
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
              'What is the capital of France?',
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _options.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                        _options[index],
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
