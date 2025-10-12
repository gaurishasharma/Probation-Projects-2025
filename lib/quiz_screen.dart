import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  final String userName; 

  const QuizScreen({super.key, required this.userName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Map<String, dynamic>> _questions = [];
  bool _loading = true;
  int index = 0;
  int score = 0;
  bool answered = false;
  String selected = '';

  int totalTime = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _fetchAndSetQuestions().then((_) {
      startTimer();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        totalTime++;
      });
    });
  }

  String get formattedTime {
    final minutes = (totalTime ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalTime % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _fetchAndSetQuestions() async {
    final response = await http.get(
      Uri.parse('https://opentdb.com/api.php?amount=10&type=multiple'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;
      final unescape = HtmlUnescape();

      final formattedQuestions = results.map((questionData) {
        List<String> options =
            List<String>.from(questionData['incorrect_answers']);
        options.add(questionData['correct_answer']);
        options.shuffle();

        return {
          'question': unescape.convert(questionData['question']),
          'options': options.map((opt) => unescape.convert(opt)).toList(),
          'correct': unescape.convert(questionData['correct_answer']),
        };
      }).toList();

      setState(() {
        _questions = formattedQuestions;
        _loading = false;
      });
    } else {
      setState(() {
        _loading = false;
      });
    }
  }

  void onSelect(String opt) {
    if (answered) return;

    final q = _questions[index];
    setState(() {
      answered = true;
      selected = opt;
      if (opt == q['correct']) score++;
    });
  }

  Future<void> saveAndShowResult() async {
    timer?.cancel(); 
    try {
      await FirebaseFirestore.instance.collection('results').add({
        'name': widget.userName,
        'score': score,
        'timestamp': FieldValue.serverTimestamp(),
        'email': FirebaseAuth.instance.currentUser?.email,
        'totalTime': totalTime, 
      });
    } catch (e) {
      debugPrint("Error saving result: $e");
    }

    if (!mounted) return;
    await Future.delayed(const Duration(milliseconds: 500));
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
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Failed to load questions. Try again!')),
      );
    }

    final q = _questions[index];
    final isLast = index == _questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${widget.userName}',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.logout,
            color: Colors.white,),
          ),
        ],
      ),
      body: Stack(
        children: [
          
          SizedBox.expand(
            child: Image.asset(
              'assets/images/quizbackground.jpg', 
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                Text(
                  q['question'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        blurRadius: 3,
                        color: Colors.black,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
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
                  } else {
                    bg = Colors.white;
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: bg,
                        minimumSize: const Size(double.infinity, 48),
                        foregroundColor: Colors.black,
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

               
                if (answered)
                  ElevatedButton(
                    onPressed: () {
                      if (!isLast) {
                        setState(() {
                          index++;
                          answered = false;
                          selected = '';
                        });
                      } else {
                        saveAndShowResult();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Text(
                      isLast ? 'Finish Quiz' : 'Next Question',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Score: $score',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                        shadows: [
                          Shadow(
                            blurRadius: 2,
                            color: Colors.black,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Time: $formattedTime',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                        shadows: [
                          Shadow(
                            blurRadius: 2,
                            color: Colors.black,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
