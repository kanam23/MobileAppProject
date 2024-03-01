import 'package:flutter/material.dart';

void main() => runApp(const FlashCardApp());

class FlashCardApp extends StatelessWidget {
  const FlashCardApp({super.key});

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

class ViewFlashCardsScreen extends StatelessWidget {
  const ViewFlashCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Flash Cards'),
      ),
      body: const Center(
        child: Text('Sample Screen for Viewing Flash Cards'),
      ),
    );
  }
}

class CreateFlashCardsScreen extends StatelessWidget {
  const CreateFlashCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Flash Cards'),
      ),
      body: const Center(
        child: Text('Sample Screen for Creating Flash Cards'),
      ),
    );
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
