import 'dart:async';
import 'package:flutter/material.dart';
import '../models/questions.dart';
import '../services/api_service.dart';
import '../language.dart';

class MockExamScreen extends StatefulWidget {
  const MockExamScreen({super.key});

  @override
  State<MockExamScreen> createState() => _MockExamScreenState();
}

class _MockExamScreenState extends State<MockExamScreen> {
  List<Question> questions = [];
  int currentIndex = 0;
  int score = 0;
  bool isLoading = true;
  String? selectedOption;
  bool showExplanation = false;

  Timer? timer;
  int remainingTime = 15 * 60; // 15 minutes

  @override
  void initState() {
    super.initState();
    loadMockExam();
  }

  void loadMockExam() async {
    try {
      questions = await ApiService.getMockExam();
      startTimer();
    } catch (e) {
      debugPrint("Error loading mock exam: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remainingTime > 0) {
        setState(() => remainingTime--);
      } else {
        t.cancel();
        finishExam();
      }
    });
  }

  void selectOption(String option) {
    if (showExplanation) return;

    setState(() {
      selectedOption = option;
      showExplanation = true;
      if (option ==
          (questions[currentIndex].correctAnswer)) score++;
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
      finishExam();
    }
  }

  void finishExam() {
    timer?.cancel();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: ValueListenableBuilder<bool>(
          valueListenable: isUrdu,
          builder: (_, value, __) =>
              Text(value ? "امتحان مکمل ہوا" : "Exam Completed"),
        ),
        content: ValueListenableBuilder<bool>(
          valueListenable: isUrdu,
          builder: (_, value, __) =>
              Text(value
                  ? "آپ کا نمبر: $score / ${questions.length}"
                  : "Your Score: $score / ${questions.length}"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return "$m:$s";
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
          builder: (_, value, __) =>
              Text(value
                  ? "امتحان (${currentIndex + 1}/${questions.length})"
                  : "Mock Exam (${currentIndex + 1}/${questions.length})"),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
                child: Text(formatTime(remainingTime),
                    style: const TextStyle(fontSize: 18))),
          ),
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
                  builder: (_, value, __) => Text(
                    currentIndex == questions.length - 1
                        ? (value ? "ختم کریں" : "Finish")
                        : (value ? "اگلا" : "Next"),
                  ),
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

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}