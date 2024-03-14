import 'package:flutter/material.dart';

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
        child: widget.flashCards.isNotEmpty // Check if flashCards is not empty
            ? Column(
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
                                    widget.flashCards[_currentIndex]
                                        ['correctOption']
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
              )
            : // Display text when no flash cards are available
            const Text('No flash cards have been made'),
      ),
    );
  }
}
