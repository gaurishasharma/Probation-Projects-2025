import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int score;

  const ResultScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: $score / 10',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text('Play Again'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/dashboard');
              },
              child: const Text('View Performance'),
            ),
          ],
        ),
      ),
    );
  }
}
