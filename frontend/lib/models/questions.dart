class Question {
  final String id;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correctAnswer;
  final String explanation;

  Question({
    required this.id,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctAnswer,
    required this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json["id"],
      question: json["question"],
      optionA: json["optionA"],
      optionB: json["optionB"],
      optionC: json["optionC"],
      optionD: json["optionD"],
      correctAnswer: json["correctAnswer"],
      explanation: json["explanation"],
    );
  }
}