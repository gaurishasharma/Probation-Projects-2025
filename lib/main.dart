import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/onboard.dart';
import 'package:food_delivery_app/pages/login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/onboard',
    routes: {
         '/onboard': (context) => const OnboardPage(),
        '/login': (context) => const LoginScreen(),
    }
    );
  }
}
