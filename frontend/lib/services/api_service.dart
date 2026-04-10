import 'dart:convert';

import 'package:frontend/models/rule.dart';

import 'package:http/http.dart' as http;
import '../models/questions.dart';
import '../models/traffic_sign.dart';

class ApiService {
  static const baseUrl = "http://127.0.0.1:8000"; 
  // Fetch rules test questions
  static Future<List<Question>> getRulesTest(int testNumber) async {
    final response = await http.get(
      Uri.parse("$baseUrl/exam/rules/$testNumber"),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((q) => Question.fromJson(q)).toList();
    } else {
      throw Exception("Failed to load rules test");
    }
  }

  
  static Future<List<TrafficSign>> getTrafficSigns({
    int testNumber = 1,
    int limit = 20,
  }) async {
    final url = Uri.parse("$baseUrl/signs?test=$testNumber&limit=$limit");
    final res = await http.get(url);

    if (res.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(res.body);
      final List<dynamic> data = jsonResponse["data"];
      return data.map((e) => TrafficSign.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load traffic signs");
    }
  }

  
  static Future<List<Rule>> getRules() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/rules/"),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

       
        final List list = data['data'];

        return list.map((e) => Rule.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load rules: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }
static Future<List<dynamic>> getQuestions(int chapter) async {
    final response = await http.get(
      Uri.parse("$baseUrl/questions/$chapter"),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load questions");
    }
  }
/// 🔥 CREATE USER
  static Future<void> createUser(Map<String, dynamic> user) async {
    await http.post(
      Uri.parse("$baseUrl/users"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user),
    );
  }

  /// 🔥 GET USER BY UID
  static Future<dynamic> getUserByUid(String uid) async {
    final res = await http.get(Uri.parse("$baseUrl/users/$uid"));
    return jsonDecode(res.body);
  }

  /// 🔥 UPDATE SCORE USING UID
  static Future<void> updateScore({
    required String uid,
    required int chapter,
    required int score,
    required int total,
  }) async {
    await http.post(
      Uri.parse("$baseUrl/users/update-score"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "uid": uid,
        "chapter": chapter,
        "score": score,
        "total": total,
      }),
    );
  }
  static Future<Map<String, dynamic>> getDashboard(String uid) async {
    final res = await http.get(
      Uri.parse("$baseUrl/dashboard/$uid"),
    );

    if (res.statusCode != 200) {
      throw Exception("Failed to load dashboard");
    }

    return jsonDecode(res.body);
  }

  // 🔥 ADD XP
  static Future<void> addXp(String userId, int xp) async {
    await http.post(
      Uri.parse("$baseUrl/add-xp"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "xp": xp,
      }),
    );
  }

  // 📘 UPDATE CHAPTER
  static Future<void> updateChapter(
    String userId,
    String chapter,
    double progress,
  ) async {
    await http.post(
      Uri.parse("$baseUrl/update-chapter"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": userId,
        "chapter": chapter,
        "progress": progress,
      }),
    );
  }

  // 🔥 UPDATE STREAK
  static Future<void> updateStreak(String userId) async {
    await http.post(
      Uri.parse("$baseUrl/update-streak/$userId"),
    );
  }

}