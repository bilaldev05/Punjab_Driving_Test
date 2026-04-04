import 'dart:convert';

import 'package:frontend/models/rule.dart';
import 'package:http/http.dart' as http;
import '../models/questions.dart';
import '../models/traffic_sign.dart';

class ApiService {
  static const baseUrl = "http://127.0.0.1:8000"; // Use your LAN IP for Web

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

        // ✅ Expecting: { "data": [...] }
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

}