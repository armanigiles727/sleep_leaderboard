import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../services/api_client.dart';
import '../models/leaderboard_entry.dart';
import 'profile_screen.dart'; // NEW

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  final api = ApiClient();
  String period = 'day';
  late Future<List<LeaderboardEntry>> _future;

  @override
  void initState() {
    super.initState();
    _future = api.fetchLeaderboard(period: period);
  }

  Future<void> _reload([String? newPeriod]) async {
    if (newPeriod != null) period = newPeriod;
    setState(() {
      _future = api.fetchLeaderboard(period: period);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sleep Leaderboard',
          style: TextStyle(
            fontSize: kIsWeb
                ? 28
                : Platform.isIOS
                    ? 22
                    : 20, // Android as default
            fontWeight: FontWeight.bold,
            color: kIsWeb
                ? Colors.blue
                : Platform.isIOS
                    ? Colors.purple
                    : Colors.green,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            initialValue: period,
            onSelected: (v) => _reload(v),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'day', child: Text('Today')),
              PopupMenuItem(value: 'week', child: Text('This Week')),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Center(child: Text(period == 'day' ? 'Today' : 'Week')),
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<LeaderboardEntry>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 8),
                  FilledButton(
                    onPressed: () => _reload(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('No data yet'));
          }
          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, i) {
                final e = items[i];
                return ListTile(
                  leading: Hero(
                    tag: 'avatar_${e.id}',
                    child: CircleAvatar(
                      backgroundImage: (e.avatarUrl != null)
                          ? NetworkImage(e.avatarUrl!)
                          : null,
                      child: e.avatarUrl == null
                          ? Text(e.name.isNotEmpty ? e.name[0] : '?')
                          : null,
                      onBackgroundImageError: (_, __) {},
                    ),
                  ),
                  title: Text(
                    e.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('Rank #${e.rank}'),
                  trailing: Text('${e.hours.toStringAsFixed(1)} h'),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProfileScreen(user: e),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}