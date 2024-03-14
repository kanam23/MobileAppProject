import 'package:flutter/material.dart';

class TakeQuizScreen extends StatefulWidget {
  final List<Map<String, dynamic>> quizQuestions;

  const TakeQuizScreen({Key? key, required this.quizQuestions})
      : super(key: key);

  @override
  _TakeQuizScreenState createState() => _TakeQuizScreenState();
}

class _TakeQuizScreenState extends State<TakeQuizScreen> {
  int _currentIndex = 0;
  int _score = 0;

  String? _hoveredOption;

  void _checkAnswer(String selectedOption) {
    final correctOption = widget.quizQuestions[_currentIndex]['correctOption'];

    if (selectedOption == correctOption) {
      setState(() {
        _score++;
      });
    }

    _nextQuestion();
  }

  void _nextQuestion() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.quizQuestions.length;
      if (widget.quizQuestions.isEmpty) {
        _currentIndex = 0; // Reset _currentIndex if quizQuestions is empty
      }
      _hoveredOption =
          null; // Reset hovered option when moving to the next question
    });
    if (_currentIndex == 0 && widget.quizQuestions.isNotEmpty) {
      Navigator.pushReplacementNamed(
        context,
        '/congratulations',
        arguments: {
          'score': _score,
          'totalQuestions': widget.quizQuestions.length
        },
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
        child: widget.quizQuestions.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Question ${_currentIndex + 1}/${widget.quizQuestions.length}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.quizQuestions[_currentIndex]['question'],
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: <Widget>[
                      for (final option in widget.quizQuestions[_currentIndex]
                          ['options'])
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
