import 'package:flutter/material.dart';
import 'package:marketplace/screens/shell_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color nightBlue = Color(0xFF111722);
    const Color royalBlue = Color(0xFF0096FF);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: royalBlue,
          surface: nightBlue,
        ),
        scaffoldBackgroundColor: nightBlue,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: nightBlue,
          iconTheme: WidgetStateProperty.fromMap({
            WidgetState.selected: const IconThemeData(color: royalBlue),
          }),
        )
      ),
      home: ShellScreen(),
    );
  }
}
