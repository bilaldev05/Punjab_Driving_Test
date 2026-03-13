import 'package:flutter/material.dart';
import '../models/questions.dart';
import '../services/api_service.dart';
import '../language.dart';

class PracticeTestScreen extends StatefulWidget {
  const PracticeTestScreen({super.key});

  @override
  State<PracticeTestScreen> createState() => _PracticeTestScreenState();
}

class _PracticeTestScreenState extends State<PracticeTestScreen> {
  List<Question> questions = [];
  int currentIndex = 0;
  bool isLoading = true;
  String? selectedOption;
  bool showExplanation = false;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    try {
      questions = await ApiService.getQuestions();
    } catch (e) {
      debugPrint("Error loading questions: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  void selectOption(String option) {
    if (showExplanation) return;

    setState(() {
      selectedOption = option;
      showExplanation = true;
    });
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedOption = null;
        showExplanation = false;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: ValueListenableBuilder<bool>(
            valueListenable: isUrdu,
            builder: (_, value, __) => Text(value ? "ٹیسٹ مکمل" : "Test Completed"),
          ),
          content: ValueListenableBuilder<bool>(
            valueListenable: isUrdu,
            builder: (_, value, __) => Text(value
                ? "آپ نے پراکٹیس ٹیسٹ مکمل کر لیا ہے۔"
                : "You have completed the practice test."),
          ),
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

  Color optionColor(String option, String correctAnswer) {
    if (!showExplanation) return Colors.white;
    if (option == correctAnswer) return Colors.green.shade200;
    if (option == selectedOption && selectedOption != correctAnswer) return Colors.red.shade200;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (questions.isEmpty) return const Scaffold(body: Center(child: Text("No questions available")));

    final q = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: ValueListenableBuilder<bool>(
          valueListenable: isUrdu,
          builder: (_, value, __) => Text(value
              ? "پریکٹس ٹیسٹ (${currentIndex + 1}/${questions.length})"
              : "Practice Test (${currentIndex + 1}/${questions.length})"),
        ),
        actions: [
          IconButton(
            icon: ValueListenableBuilder<bool>(
              valueListenable: isUrdu,
              builder: (_, value, __) => Text(
                value ? "EN" : "اردو",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () => isUrdu.value = !isUrdu.value,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: isUrdu,
              builder: (_, value, __) => Text(
                value ? q.questionUr : q.question,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            optionWidget(isUrdu.value ? q.optionAUr : q.optionA, q.correctAnswer),
            optionWidget(isUrdu.value ? q.optionBUr : q.optionB, q.correctAnswer),
            optionWidget(isUrdu.value ? q.optionCUr : q.optionC, q.correctAnswer),
            optionWidget(isUrdu.value ? q.optionDUr : q.optionD, q.correctAnswer),
            if (showExplanation)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ValueListenableBuilder<bool>(
                  valueListenable: isUrdu,
                  builder: (_, value, __) => Text(
                    value ? q.explanationUr : q.explanation,
                    style: const TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ),
            const Spacer(),
            if (showExplanation)
              ElevatedButton(
                onPressed: nextQuestion,
                child: ValueListenableBuilder<bool>(
                  valueListenable: isUrdu,
                  builder: (_, value, __) => Text(value ? "اگلا" : "Next"),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget optionWidget(String option, String correctAnswer) {
    return Card(
      color: optionColor(option, correctAnswer),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(option),
        onTap: () => selectOption(option),
      ),
    );
  }
}