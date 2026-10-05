import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const LuxeApp());
}

class LuxeApp extends StatelessWidget {
  const LuxeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luxe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC9B8D4)),
      ),
      home: const SplashScreen(),
    );
  }
}
