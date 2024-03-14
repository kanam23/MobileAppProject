// take_quiz.dart

import 'package:flutter/material.dart';
import 'database_helper.dart';

class TakeQuizScreen extends StatefulWidget {
  const TakeQuizScreen({Key? key}) : super(key: key);

  @override
  _TakeQuizScreenState createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends State<TakeQuizScreen> {
  int _currentIndex = 0;
  int _score = 0;

  String? _hoveredOption;

  List<Map<String, dynamic>> _quizQuestions = [];

  @override
  void initState() {
    super.initState();
    _loadQuizQuestions();
  }

  Future<void> _loadQuizQuestions() async {
    _quizQuestions = await FlashcardDatabaseHelper.instance.getAllFlashcards();
    setState(() {
      _currentIndex = 0;
    });
  }

  void _checkAnswer(String selectedOption) {
    final correctOption = _quizQuestions[_currentIndex]['correctOption'];

    if (selectedOption == correctOption) {
      setState(() {
        _score++;
      });
    }

    _nextQuestion();
  }

  void _nextQuestion() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _quizQuestions.length;
      _hoveredOption = null;
    });
    if (_currentIndex == 0 && _quizQuestions.isNotEmpty) {
      Navigator.pushReplacementNamed(
        context,
        '/congratulations',
        arguments: {'score': _score, 'totalQuestions': _quizQuestions.length},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Quiz'),
      ),
      body: Center(
        child: _quizQuestions.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Question ${_currentIndex + 1}/${_quizQuestions.length}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _quizQuestions[_currentIndex]['question'],
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      for (final option in _quizQuestions[_currentIndex]
                              ['options']
                          .split(','))
                        MouseRegion(
                          onHover: (event) {
                            setState(() {
                              _hoveredOption = option;
                            });
                          },
                          onExit: (event) {
                            setState(() {
                              _hoveredOption = null;
                            });
                          },
                          child: ElevatedButton(
                            onPressed: () {
                              _checkAnswer(option);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _hoveredOption == option
                                  ? Colors.green
                                  : null,
                            ),
                            child: Text(option),
                          ),
                        ),
                    ],
                  ),
                ],
              )
            : const Text('No flash cards to take quiz'),
      ),
    );
  }
}
