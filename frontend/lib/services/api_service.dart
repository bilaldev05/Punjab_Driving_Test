import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/questions.dart';
import '../models/traffic_sign.dart';

class ApiService {
  static const baseUrl = "http://127.0.0.1:8000"; 

  
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
 static Future<String> getRulebookPdfUrl() async {
    final String pdfUrl = "http://192.168.100.153:8000/rulebook/pdf";

    // Optional: check if the PDF is reachable
    final res = await http.head(url); // lightweight request

    if (res.statusCode == 200) {
      return url.toString(); // return PDF URL
    } else {
      throw Exception("Failed to load Rulebook PDF");
    }
  }
}