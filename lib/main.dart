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
    const Color accentBlue = Color(0xFF25AFF4);
    const Color cardBg = Color(0xFF162032);
    const Color cardBgAlt = Color(0xFF1A282F);
    const Color appBarBg = Color(0xFF101C22);

    final colorScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: royalBlue,
      surface: cardBg,
    ).copyWith(
      secondary: accentBlue,
      surfaceContainerHighest: cardBgAlt,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: nightBlue,
        cardColor: cardBg,
        appBarTheme: const AppBarTheme(
          backgroundColor: appBarBg,
          elevation: 0,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: nightBlue,
          iconTheme: WidgetStateProperty.resolveWith(
            (states) => IconThemeData(
              color: states.contains(WidgetState.selected) ? accentBlue : Colors.grey,
            ),
          ),
        ),
      ),
      home: ShellScreen(),
    );
  }
}
