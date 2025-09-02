import 'package:flutter/material.dart';
import 'screens/leaderboard_screen.dart';

void main() {
  runApp(const SleepLeaderboardApp());
}

class SleepLeaderboardApp extends StatelessWidget {
  const SleepLeaderboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleep Leaderboard',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const LeaderboardScreen(),
    );
  }
}