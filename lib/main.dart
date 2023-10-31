import 'package:flutter/material.dart';
import 'package:news/screens/categeries_screen.dart';

import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/homescreen': (context) => const HomeScreen(),
        'categeriesscreen': (context) => const CategeriesScreen(),
      },
    );
  }
}
