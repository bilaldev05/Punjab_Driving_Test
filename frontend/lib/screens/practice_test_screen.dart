import 'package:flutter/material.dart';
import 'package:frontend/language.dart';
import 'package:frontend/models/questions.dart' show Question;
import 'package:frontend/services/api_service.dart';

class PracticeTestScreen extends StatefulWidget {
  final int testNumber;
  const PracticeTestScreen({super.key, this.testNumber = 1});

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
    questions = await ApiService.getRulesTest(widget.testNumber);
    setState(() => isLoading = false);
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
      // Reached end of test
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Test Completed!"),
          content: const Text("You have completed this test."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Color optionColor(String option, String correct) {
    if (!showExplanation) return Colors.white;
    if (option == correct) return Colors.green.shade100;
    if (option == selectedOption && selectedOption != correct)
      return Colors.red.shade100;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading)
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));

    final q = questions[currentIndex];
    double progress = (currentIndex + 1) / questions.length;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Rules Test ${widget.testNumber}", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.grey.shade100
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Progress bar with percentage
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade300,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 20),

           // Question Card - Professional Style
AnimatedContainer(
  duration: const Duration(milliseconds: 400),
  curve: Curves.easeInOut,
  margin: const EdgeInsets.symmetric(vertical: 12),
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blueAccent.shade100, Colors.blueAccent.shade200],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Optional Question Number Badge
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          "Q${currentIndex + 1}",
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      const SizedBox(height: 12),

      // Question Text
      ValueListenableBuilder<bool>(
        valueListenable: isUrdu,
        builder: (_, value, __) => Text(
          value ? q.questionUr : q.question,
          style: const TextStyle(
            fontSize: 16,
            
            color: Colors.white,
            height: 1.4,
          ),
        ),
      ),
    ],
  ),
),

            // Option buttons
            Expanded(
              child: ListView(
                children: [
                  optionButton("A", q.optionA, q.optionAUr, q.correctAnswer),
                  optionButton("B", q.optionB, q.optionBUr, q.correctAnswer),
                  optionButton("C", q.optionC, q.optionCUr, q.correctAnswer),
                  optionButton("D", q.optionD, q.optionDUr, q.correctAnswer),
                ],
              ),
            ),

           
            // Next button
            if (showExplanation)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: nextQuestion,
                  child: const Text(
                    "Next",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget optionButton(
      String letter, String option, String optionUr, String correct) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: optionColor(option, correct),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text(
              letter,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: ValueListenableBuilder<bool>(
            valueListenable: isUrdu,
            builder: (_, value, __) => Text(
              value ? optionUr : option,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          onTap: () => selectOption(option),
        ),
      ),
    );
  }
}