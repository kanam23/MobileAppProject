import 'package:flutter/material.dart';

void main() => runApp(const FlashCardApp());

class FlashCardApp extends StatelessWidget {
  const FlashCardApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Card App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      routes: {
        '/viewFlashCards': (context) => const ViewFlashCardsScreen(),
        '/createFlashCards': (context) => const CreateFlashCardsScreen(),
        '/takeQuiz': (context) => const TakeQuizScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
  const ViewFlashCardsScreen({super.key});

  @override
  _ViewFlashCardsScreenState createState() => _ViewFlashCardsScreenState();
}

class _ViewFlashCardsScreenState extends State<ViewFlashCardsScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> flashCards = [
    {
      'question': 'Which of the following animals can sleep with one eye open?',
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

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % flashCards.length;
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
                    flashCards[_currentIndex]['question'],
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
              color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  for (final option in flashCards[_currentIndex]['options'])
                    ElevatedButton(
                      onPressed: () {},
                      style:
                          option == flashCards[_currentIndex]['correctOption']
                              ? ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green)
                              : null,
                      child: Text(option),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nextCard,
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateFlashCardsScreen extends StatefulWidget {
  const CreateFlashCardsScreen({Key? key}) : super(key: key);

  @override
  _CreateFlashCardsScreenState createState() => _CreateFlashCardsScreenState();
}

class _CreateFlashCardsScreenState extends State<CreateFlashCardsScreen> {
  final TextEditingController _frontController = TextEditingController();
  final TextEditingController _backController1 = TextEditingController();
  final TextEditingController _backController2 = TextEditingController();
  final TextEditingController _backController3 = TextEditingController();
  final TextEditingController _backController4 = TextEditingController();

  int _correctAnswerIndex = -1;

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
                                  hintText: 'Enter answer choice ${i + 1}',
                                  border: const OutlineInputBorder(),
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
                onPressed: () {
                  // Logic for saving flash card will be implemented here
                },
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

class TakeQuizScreen extends StatelessWidget {
  const TakeQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Quiz'),
      ),
      body: const Center(
        child: Text('Sample Screen for Taking Quiz'),
      ),
    );
  }
}
