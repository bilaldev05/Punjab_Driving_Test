import 'package:flutter/material.dart';
import '../models/questions.dart';
import '../services/api_service.dart';

class MockExamScreen extends StatefulWidget {
  const MockExamScreen({super.key});

  @override
  State<MockExamScreen> createState() => _MockExamScreenState();
}

class _MockExamScreenState extends State<MockExamScreen> {
  List<Question> questions = [];
  int currentIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMockExam();
  }

  void loadMockExam() async {
    try {
      questions = await ApiService.getMockExam();
    } catch (e) {
      debugPrint("Error loading mock exam: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() => currentIndex++);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Exam Completed"),
          content: const Text("You have completed the mock exam."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("No questions available")),
      );
    }

    final q = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Mock Exam (${currentIndex + 1}/${questions.length})"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(q.question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            option(q.optionA),
            option(q.optionB),
            option(q.optionC),
            option(q.optionD),
          ],
        ),
      ),
    );
  }

  Widget option(String text) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(text),
        onTap: nextQuestion,
      ),
    );
  }
}