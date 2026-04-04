import 'package:flutter/material.dart';
import 'package:frontend/models/rule.dart';
import 'package:frontend/screens/chapter_details_screen.dart';
import 'package:frontend/services/api_service.dart';

class RuleBookScreen extends StatefulWidget {
  const RuleBookScreen({super.key});

  @override
  State<RuleBookScreen> createState() => _RuleBookScreenState();
}

class _RuleBookScreenState extends State<RuleBookScreen> {
  List<Rule> rules = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRules();
  }

  void loadRules() async {
    try {
      rules = await ApiService.getRules();
    } catch (e) {
      debugPrint("Error: $e");
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chapters"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: rules.length,
        itemBuilder: (context, index) {
          final rule = rules[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChapterDetailScreen(rule: rule),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Text(
                    "${rule.chapterNumber ?? index + 1}",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(
                  rule.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}