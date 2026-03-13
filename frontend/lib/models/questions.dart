class Question {
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correctAnswer;
  final String explanation;

  // Urdu fields
  final String questionUr;
  final String optionAUr;
  final String optionBUr;
  final String optionCUr;
  final String optionDUr;
  final String explanationUr;

  Question({
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctAnswer,
    required this.explanation,
    required this.questionUr,
    required this.optionAUr,
    required this.optionBUr,
    required this.optionCUr,
    required this.optionDUr,
    required this.explanationUr,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json['question'],
        optionA: json['optionA'],
        optionB: json['optionB'],
        optionC: json['optionC'],
        optionD: json['optionD'],
        correctAnswer: json['correctAnswer'],
        explanation: json['explanation'],
        questionUr: json['questionUr'] ?? json['question'],
        optionAUr: json['optionAUr'] ?? json['optionA'],
        optionBUr: json['optionBUr'] ?? json['optionB'],
        optionCUr: json['optionCUr'] ?? json['optionC'],
        optionDUr: json['optionDUr'] ?? json['optionD'],
        explanationUr: json['explanationUr'] ?? json['explanation'],
      );
}