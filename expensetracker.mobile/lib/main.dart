import 'package:flutter/material.dart';
import 'app/app_screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0F19),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF10B981), // Emerald green
          secondary: Color(0xFF6366F1), // Indigo
          surface: Color(0xFF1E293B), // Slate/Grey
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
