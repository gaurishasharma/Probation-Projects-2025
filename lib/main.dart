import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'login_screen.dart';
import 'quiz_screen.dart';
import 'dashboard_screen.dart';


void main() async {
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
runApp(const QuizApp());
}


class QuizApp extends StatelessWidget {
const QuizApp({super.key});


@override
Widget build(BuildContext context) {
return MaterialApp(
debugShowCheckedModeBanner: false,
title: 'Quiz App',
theme: ThemeData(primarySwatch: Colors.deepPurple),
home: StreamBuilder<User?>(
stream: FirebaseAuth.instance.authStateChanges(),
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
return const Scaffold(body: Center(child: CircularProgressIndicator()));
}
if (snapshot.hasData) {
return const QuizScreen(questions: [],);
}
return const AuthScreen();
},
),
routes: {
'/dashboard': (_) => const DashboardScreen(),
},
);
}
}