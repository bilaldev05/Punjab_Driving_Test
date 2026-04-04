import 'package:flutter/material.dart';
import 'package:frontend/models/questions.dart';
import 'package:frontend/services/api_service.dart';

class TestScreen extends StatefulWidget {
  final int chapterNumber;

  const TestScreen({super.key, required this.chapterNumber});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<Question> questions = [];
  int currentIndex = 0;
  int score = 0;
  int? selectedIndex;
  bool showAnswer = false;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
  final data = await ApiService.getQuestions(widget.chapterNumber);

  setState(() {
    questions = data.map<Question>((q) => Question.fromJson(q, shuffle: true)).toList();
  });
}

  void checkAnswer(int index) {
    if (showAnswer) return; // prevent multiple taps

    setState(() {
      selectedIndex = index;
      showAnswer = true;

      if (index == questions[currentIndex].answer) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedIndex = null;
        showAnswer = false;
      });
    } else {
      showResult();
    }
  }

  void showResult() {
  final percentage = (score / questions.length) * 100;

  showDialog(
    context: context,
    barrierDismissible: false, // prevent closing by tapping outside
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Test Completed",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Score circle
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  "$score / ${questions.length}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Percentage bar
            LinearProgressIndicator(
              value: score / questions.length,
              minHeight: 10,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(
                percentage >= 80
                    ? Colors.greenAccent
                    : (percentage >= 50 ? Colors.orangeAccent : Colors.redAccent),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              "Your Score: ${percentage.toStringAsFixed(1)}%",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),

            // OK button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.pop(context); // back to previous screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "OK",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

  Color getOptionColor(int index) {
    if (!showAnswer) return Colors.white;

    if (index == questions[currentIndex].answer) {
      return Colors.green.withOpacity(0.3); // correct answer
    }

    if (selectedIndex == index && selectedIndex != questions[currentIndex].answer) {
      return Colors.red.withOpacity(0.3); // wrong answer
    }

    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final q = questions[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text("Chapter ${widget.chapterNumber} Test"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: (currentIndex + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
              minHeight: 6,
            ),
            const SizedBox(height: 20),

            // Question
            Text(
              "Q${currentIndex + 1}. ${q.question}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),

            // Options
            ...List.generate(q.options.length, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: getOptionColor(index),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: ListTile(
                  title: Text(
                    q.options[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                  onTap: () => checkAnswer(index),
                  leading: showAnswer
                      ? Icon(
                          index == q.answer
                              ? Icons.check_circle
                              : (index == selectedIndex ? Icons.cancel : Icons.circle_outlined),
                          color: index == q.answer
                              ? Colors.green
                              : (index == selectedIndex ? Colors.red : Colors.grey),
                        )
                      : null,
                ),
              );
            }),

            const Spacer(),

            // Next button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: showAnswer ? nextQuestion : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  currentIndex == questions.length - 1 ? "Finish Test" : "Next Question",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}