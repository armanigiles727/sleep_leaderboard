import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/leaderboard_entry.dart';

class ApiClient {
  static const String baseUrl = 'http://127.0.0.1:8000';
  static const bool useMock = false;

  Future<List<LeaderboardEntry>> fetchLeaderboard({String period = 'day'}) async {
    if (useMock) {
      await Future.delayed(const Duration(milliseconds: 350));
      return [
        LeaderboardEntry(
          id: 1,
          rank: 1,
          name: 'Armani G.',
          hours: 8.2,
          avatarUrl: 'https://i.pravatar.cc/150?img=15',
          bio: 'Full-stack dev. Loves sleep tracking, kettlebells, and matcha.',
        ),
        LeaderboardEntry(
          id: 2,
          rank: 2,
          name: 'Maya L.',
          hours: 7.9,
          avatarUrl: 'https://i.pravatar.cc/150?img=32',
          bio: 'RN enthusiast. Night owl turned early bird.',
        ),
        LeaderboardEntry(
          id: 3,
          rank: 3,
          name: 'J. Chen',
          hours: 7.6,
          avatarUrl: 'https://i.pravatar.cc/150?img=5',
          bio: 'Data viz nerd. Dreams in charts.',
        ),
        LeaderboardEntry(
          id: 4,
          rank: 4,
          name: 'R. Patel',
          hours: 7.4,
          avatarUrl: 'https://i.pravatar.cc/150?img=8',
          bio: 'Backend whisperer. Loves long hikes and longer naps.',
        ),
      ];
    }

    final uri = Uri.parse('$baseUrl/leaderboard?period=$period');
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      final data = jsonDecode(resp.body) as List;
      return data.map((e) => LeaderboardEntry.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load leaderboard: ${resp.statusCode}');
    }
  }
}