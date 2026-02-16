import 'package:flutter/material.dart';
import 'package:marketplace/navigation/bottom_navigator.dart';
import 'package:marketplace/screens/home_screen.dart';
import 'package:marketplace/screens/explore_screen.dart';
import 'package:marketplace/screens/chats_screen.dart';
import 'package:marketplace/screens/profile_screen.dart';

class ShellScreen extends StatefulWidget {
  const ShellScreen({super.key});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int _currentIndex = 0;

  static const _pages = [
    HomeScreen(),
    ExploreScreen(),
    ChatsScreen(),
    ProfileScreen(),
  ];

  void _onDestinationSelected(int index) {
    if (index == _currentIndex) return;
    setState(() {
      _currentIndex = index.clamp(0, _pages.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigator(
        currentIndex: _currentIndex,
        onTap: _onDestinationSelected,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
    );
  }
}
