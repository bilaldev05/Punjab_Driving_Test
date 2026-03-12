import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/questions.dart';
import '../models/traffic_sign.dart';

class ApiService {

  // ⚠️ Change this when deploying
  static const String baseUrl = "http://127.0.0.1:8000";

  // -----------------------------
  // USER AUTH
  // -----------------------------

  static Future<Map<String, dynamic>> registerUser(
      String email,
      String password,
      ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/users/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> loginUser(
      String email,
      String password,
      ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/users/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  // -----------------------------
  // QUESTIONS
  // -----------------------------

  static Future<List<Question>> getQuestions() async {

    final response = await http.get(
      Uri.parse("$baseUrl/questions/"),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return List<Question>.from(
        data.map((q) => Question.fromJson(q)),
      );

    } else {
      throw Exception("Failed to load questions");
    }
  }

  // -----------------------------
  // MOCK EXAM
  // -----------------------------

  static Future<List<Question>> getMockExam() async {

    final response = await http.get(
      Uri.parse("$baseUrl/exam/mock"),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return List<Question>.from(
        data.map((q) => Question.fromJson(q)),
      );

    } else {
      throw Exception("Failed to load mock exam");
    }
  }

  // -----------------------------
  // SAVE RESULT
  // -----------------------------

  static Future<Map<String, dynamic>> saveResult(
      String userId,
      int score,
      int total,
      String examType,
      ) async {

    final response = await http.post(
      Uri.parse("$baseUrl/results/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "score": score,
        "total": total,
        "exam_type": examType
      }),
    );

    return jsonDecode(response.body);
  }

  // -----------------------------
  // USER ANALYTICS
  // -----------------------------

  static Future<Map<String, dynamic>> getUserAnalytics(
      String userId,
      ) async {

    final response = await http.get(
      Uri.parse("$baseUrl/analytics/$userId"),
    );

    if (response.statusCode == 200) {

      return jsonDecode(response.body);

    } else {
      throw Exception("Failed to load analytics");
    }
  }

  // -----------------------------
  // TRAFFIC SIGNS
  // -----------------------------

  static Future<List<TrafficSign>> getTrafficSigns() async {

    final response = await http.get(
      Uri.parse("$baseUrl/signs/"),
    );

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return List<TrafficSign>.from(
        data.map((sign) => TrafficSign.fromJson(sign)),
      );

    } else {
      throw Exception("Failed to load traffic signs");
    }
  }

  // -----------------------------
  // ADMIN ADD QUESTION
  // -----------------------------

  static Future<Map<String, dynamic>> addQuestion({
    required String question,
    required String optionA,
    required String optionB,
    required String optionC,
    required String optionD,
    required String correctAnswer,
    required String explanation,
    required String category,
    String? image,
  }) async {

    final response = await http.post(
      Uri.parse("$baseUrl/admin/add-question"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "question": question,
        "optionA": optionA,
        "optionB": optionB,
        "optionC": optionC,
        "optionD": optionD,
        "correctAnswer": correctAnswer,
        "explanation": explanation,
        "category": category,
        "image": image,
      }),
    );

    return jsonDecode(response.body);
  }
}