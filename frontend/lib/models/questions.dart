import 'dart:math';

class Question {
  final String question;
  final List<String> options;
  final String topic; // ✅ ADD THIS
  int answer;

  Question({
    required this.question,
    required this.options,
    required this.answer,
    required this.topic, // ✅ ADD THIS
  });

  factory Question.fromJson(Map<String, dynamic> json, {bool shuffle = true}) {
    final opts = (json['options'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ??
        [];

    int ans = json['answer'] is int
        ? json['answer']
        : int.tryParse(json['answer']?.toString() ?? '') ?? 0;

    if (ans >= opts.length) ans = 0;

    final topic = json['topic']?.toString() ?? "general"; // ✅ ADD THIS

    if (shuffle) {
      return _shuffleOptions(
        json['question']?.toString() ?? '',
        opts,
        ans,
        topic,
      );
    } else {
      return Question(
        question: json['question'] ?? '',
        options: opts,
        answer: ans,
        topic: topic,
      );
    }
  }

  static Question _shuffleOptions(
    String question,
    List<String> options,
    int correctIndex,
    String topic,
  ) {
    final rand = Random();

    final paired = options
        .asMap()
        .entries
        .map((e) => MapEntry(e.value, e.key == correctIndex))
        .toList();

    paired.shuffle(rand);

    final shuffledOptions = paired.map((e) => e.key).toList();
    final newAnswer = paired.indexWhere((e) => e.value);

    return Question(
      question: question,
      options: shuffledOptions,
      answer: newAnswer,
      topic: topic, // ✅ KEEP IT
    );
  }
}