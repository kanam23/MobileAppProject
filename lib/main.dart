import 'package:flutter/material.dart';

void main() => runApp(const FlashCardApp());

class FlashCardApp extends StatelessWidget {
  const FlashCardApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> flashCards = [
      {
        'question':
            'Which of the following animals can sleep with one eye open?',
        'options': ['A. Giraffe', 'B. Elephant', 'C. Dolphin', 'D. Penguin'],
        'correctOption': 'C. Dolphin',
      },
      {
        'question': 'How many bones does an adult human have?',
        'options': ['A. 206', 'B. 212', 'C. 196', 'D. 220'],
        'correctOption': 'A. 206',
      },
      {
        'question': 'What is the tallest building in the world?',
        'options': [
          'A. Burj Khalifa',
          'B. Shanghai Tower',
          'C. Abraj Al Bait Clock Tower',
          'D. Taipei 101'
        ],
        'correctOption': 'A. Burj Khalifa',
      },
      {
        'question': 'What is the capital of France?',
        'options': ['A. Madrid', 'B. London', 'C. Rome', 'D. Paris'],
        'correctOption': 'D. Paris',
      },
      {
        'question': 'Who is known as the father of modern physics?',
        'options': [
          'A. Isaac Newton',
          'B. Albert Einstein',
          'C. Galileo Galilei',
          'D. Nikola Tesla'
        ],
        'correctOption': 'B. Albert Einstein',
      },
    ];

    return MaterialApp(
      title: 'Flash Card App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/viewFlashCards': (context) =>
            ViewFlashCardsScreen(flashCards: flashCards),
        '/createFlashCards': (context) =>
            CreateFlashCardsScreen(flashCards: flashCards),
        '/takeQuiz': (context) => TakeQuizScreen(
              quizQuestions: flashCards,
            ),
        '/congratulations': (context) => const CongratulationsScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/viewFlashCards');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('View Flash Cards'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/createFlashCards');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Create Flash Cards'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/takeQuiz');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Take Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewFlashCardsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> flashCards;
  const ViewFlashCardsScreen({Key? key, required this.flashCards});

  @override
  _ViewFlashCardsScreenState createState() => _ViewFlashCardsScreenState();
}

class _ViewFlashCardsScreenState extends State<ViewFlashCardsScreen> {
  int _currentIndex = 0;

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.flashCards.length;
    });
  }

  void _deleteCurrentCard() {
    setState(() {
      widget.flashCards.removeAt(_currentIndex);
      if (_currentIndex >= widget.flashCards.length) {
        _currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Flash Cards'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Front of the flash card
            Container(
              width: 350,
              height: 250,
              padding: const EdgeInsets.all(20.0),
              color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Fun Fact:',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.flashCards[_currentIndex]['question'],
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            // Back of the flash card with answer choices
            Container(
              width: 350,
              height: 250,
              padding: const EdgeInsets.all(20.0),
              color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (final option in widget.flashCards[_currentIndex]
                      ['options'])
                    ElevatedButton(
                      onPressed: () {},
                      style: option ==
                              widget.flashCards[_currentIndex]['correctOption']
                          ? ElevatedButton.styleFrom(
                              backgroundColor: Colors.green)
                          : null,
                      child: Text(option),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _nextCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Next'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _deleteCurrentCard,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CreateFlashCardsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> flashCards;
  const CreateFlashCardsScreen({Key? key, required this.flashCards})
      : super(key: key);

  @override
  _CreateFlashCardsScreenState createState() => _CreateFlashCardsScreenState();
}

class _CreateFlashCardsScreenState extends State<CreateFlashCardsScreen> {
  final TextEditingController _frontController = TextEditingController();
  final TextEditingController _backController1 = TextEditingController();
  final TextEditingController _backController2 = TextEditingController();
  final TextEditingController _backController3 = TextEditingController();
  final TextEditingController _backController4 = TextEditingController();

  int _correctAnswerIndex = 0; // Initialize correct answer index to 0

  void _saveFlashCard() {
    final List<String> options = [
      _backController1.text,
      _backController2.text,
      _backController3.text,
      _backController4.text
    ];

    final newFlashCard = {
      'question': _frontController.text,
      'options': options,
      'correctOption': options[_correctAnswerIndex],
    };

    setState(() {
      widget.flashCards.add(newFlashCard);
    });

    // Clear the text controllers and reset correct answer index
    _frontController.clear();
    _backController1.clear();
    _backController2.clear();
    _backController3.clear();
    _backController4.clear();
    _correctAnswerIndex = 0; // Reset correct answer index

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Flash Cards'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Front of the flash card input
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(bottom: 20.0),
                child: TextField(
                  controller: _frontController,
                  decoration: const InputDecoration(
                    hintText: 'Enter front of the flash card',
                    border: InputBorder.none,
                  ),
                ),
              ),
              // Back of the flash card input with four answer choices
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Back of the flash card (Answer choices)',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    for (int i = 0; i < 4; i++)
                      Row(
                        children: [
                          Radio<int>(
                            value: i,
                            groupValue: _correctAnswerIndex,
                            onChanged: (value) {
                              setState(() {
                                _correctAnswerIndex = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10.0),
                              child: TextField(
                                controller: i == 0
                                    ? _backController1
                                    : i == 1
                                        ? _backController2
                                        : i == 2
                                            ? _backController3
                                            : _backController4,
                                decoration: InputDecoration(
                                  hintText:
                                      'Enter answer choice ${String.fromCharCode(65 + i)}',
                                  border: const OutlineInputBorder(),
                                  fillColor: i == _correctAnswerIndex
                                      ? Colors.green
                                      : null,
                                  filled: true,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveFlashCard,
                child: const Text('Save Flash Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _frontController.dispose();
    _backController1.dispose();
    _backController2.dispose();
    _backController3.dispose();
    _backController4.dispose();
    super.dispose();
  }
}

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
      _hoveredOption =
          null; // Reset hovered option when moving to the next question
    });
    if (_currentIndex == 0) {
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
        child: Column(
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
                        backgroundColor:
                            _hoveredOption == option ? Colors.green : null,
                      ),
                      child: Text(option),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int score = arguments['score'];
    final int totalQuestions = arguments['totalQuestions'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Congratulations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Congratulations!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Your Score: $score/$totalQuestions',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/takeQuiz');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Try Again'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
