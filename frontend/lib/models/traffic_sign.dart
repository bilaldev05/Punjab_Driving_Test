// models/traffic_sign.dart
class TrafficSign {
  final String name;        // question in English
  final String nameUr;      // question in Urdu
  final String image;
  final String optionA;
  final String optionAUr;
  final String optionB;
  final String optionBUr;
  final String optionC;
  final String optionCUr;
  final String optionD;
  final String optionDUr;
  final String correctAnswer;

  TrafficSign({
    required this.name,
    required this.nameUr,
    required this.image,
    required this.optionA,
    required this.optionAUr,
    required this.optionB,
    required this.optionBUr,
    required this.optionC,
    required this.optionCUr,
    required this.optionD,
    required this.optionDUr,
    required this.correctAnswer,
  });

  factory TrafficSign.fromJson(Map<String, dynamic> json) {
    return TrafficSign(
      name: json["question"] ?? "",
      nameUr: json["questionUr"] ?? "",
      image: json["image"] ?? "default.png",
      optionA: json["optionA"] ?? "",
      optionAUr: json["optionAUr"] ?? "",
      optionB: json["optionB"] ?? "",
      optionBUr: json["optionBUr"] ?? "",
      optionC: json["optionC"] ?? "",
      optionCUr: json["optionCUr"] ?? "",
      optionD: json["optionD"] ?? "",
      optionDUr: json["optionDUr"] ?? "",
      correctAnswer: json["correctAnswer"] ?? "",
    );
  }
}