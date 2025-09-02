// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import '../models/leaderboard_entry.dart';

class ProfileScreen extends StatelessWidget {
  final LeaderboardEntry user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Hero(
              tag: 'avatar_${user.id}',
              child: CircleAvatar(
                radius: 56,
                backgroundImage:
                    user.avatarUrl != null ? NetworkImage(user.avatarUrl!) : null,
                child: user.avatarUrl == null
                    ? Text(user.name.isNotEmpty ? user.name[0] : '?',
                        style: const TextStyle(fontSize: 28))
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              '${user.hours.toStringAsFixed(1)} h today',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 24),
          Text('Bio', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(user.bio ?? 'No bio yet.', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              leading: const Icon(Icons.emoji_events),
              title: const Text('Rank'),
              trailing: Text('#${user.rank}'),
            ),
          ),
        ],
      ),
    );
  }
}