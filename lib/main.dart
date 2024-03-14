import 'package:flutter/material.dart';
import 'view_flashcards.dart';
import 'create_flashcards.dart';
import 'take_quiz.dart';
import 'congratulations.dart';

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
