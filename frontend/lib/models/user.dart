class ChapterProgress {
  final int chapter;
  final int score;
  final int total;

  ChapterProgress({
    required this.chapter,
    required this.score,
    required this.total,
  });

  factory ChapterProgress.fromJson(Map<String, dynamic> json) {
    return ChapterProgress(
      chapter: json['chapter'] ?? 0,
      score: json['score'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}

class User {
  final String name;
  final String email; // ✅ ADD THIS
  final int totalScore;
  final int testsTaken;
  final List<ChapterProgress> progress;

  User({
    required this.name,
    required this.email, // ✅ ADD THIS
    required this.totalScore,
    required this.testsTaken,
    required this.progress,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '', // ✅ ADD THIS
      totalScore: json['totalScore'] ?? 0,
      testsTaken: json['testsTaken'] ?? 0,
      progress: (json['chapterProgress'] as List<dynamic>? ?? [])
          .map((e) => ChapterProgress.fromJson(e))
          .toList(),
    );
  }
}