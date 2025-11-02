import 'package:commerce_sense/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:commerce_sense/pages/providers/cart_provider.dart';
import 'package:commerce_sense/pages/providers/wishlist_provider.dart'; 


void main() {
  runApp(
  
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => WishlistProvider()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
 
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}