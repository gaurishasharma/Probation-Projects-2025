import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;

  const QuizScreen({super.key, required this.questions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int score = 0;
  bool answered = false;
  bool loading = false;
  String selected = '';

  List<Map<String, dynamic>> get questions => widget.questions;

  void onSelect(String opt) {
    if (answered) return;

    final q = questions[index];
    setState(() {
      answered = true;
      selected = opt;
      if (opt == q['correct']) score++;
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      if (index < questions.length - 1) {
        setState(() {
          index++;
          answered = false;
          selected = '';
        });
      } else {
        saveAndShowResult();
      }
    });
  }

  Future<void> saveAndShowResult() async {
    final user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection('results').add({
      'email': user?.email ?? 'unknown',
      'score': score,
      'timestamp': FieldValue.serverTimestamp(),
    });

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(score: score),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final q = questions[index];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${index + 1}/${questions.length}'),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (mounted) Navigator.pop(context);
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/dashboard'),
            icon: const Icon(Icons.show_chart),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              q['question'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            ...q['options'].map<Widget>((opt) {
              final isSelected = selected == opt;
              Color? bg;
              if (answered) {
                if (opt == q['correct']) {
                  bg = Colors.green[700];
                } else if (isSelected) {
                  bg = Colors.red[700];
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bg,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () => onSelect(opt),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(opt),
                  ),
                ),
              );
            }).toList(),
            const Spacer(),
            Text(
              'Score: $score',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
