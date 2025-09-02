class LeaderboardEntry {
  final int id;           // NEW
  final int rank;
  final String name;
  final double hours;
  final String? avatarUrl; // NEW
  final String? bio;       // NEW

  LeaderboardEntry({
    required this.id,
    required this.rank,
    required this.name,
    required this.hours,
    this.avatarUrl,
    this.bio,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      id: json['id'] as int,
      rank: json['rank'] as int,
      name: json['name'] as String,
      hours: (json['hours'] as num).toDouble(),
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
    );
  }
}