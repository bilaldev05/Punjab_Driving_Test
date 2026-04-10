import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../models/questions.dart';
import '../services/api_service.dart';

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
      questions =
          data.map<Question>((q) => Question.fromJson(q, shuffle: true)).toList();
    });
  }

  void checkAnswer(int index) {
    if (showAnswer) return;

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

  Future<void> showResult() async {
  final percentage = (score / questions.length) * 100;

  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final uid = user.uid;

  // 🔥 1. ADD XP (score based)
  await ApiService.addXp(uid, score * 10);

  // 📘 2. UPDATE CHAPTER PROGRESS
  await ApiService.updateChapter(
    uid,
    "Chapter ${widget.chapterNumber}",
    score / questions.length,
  );

  // 🔥 3. UPDATE STREAK
  await ApiService.updateStreak(uid);

  // 📊 4. SAVE TEST RESULT
  await ApiService.updateScore(
    uid: uid,
    chapter: widget.chapterNumber,
    score: score,
    total: questions.length,
  );

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Text("🎉 Test Completed"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Score: $score / ${questions.length}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          LinearProgressIndicator(
            value: score / questions.length,
            color: AppTheme.primary,
            backgroundColor: AppTheme.muted,
          ),

          const SizedBox(height: 12),

          Text(
            "${percentage.toStringAsFixed(1)}%",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
          ),
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: const Text("Continue"),
        )
      ],
    ),
  );
}

  Color _optionColor(int index) {
    if (!showAnswer) return AppTheme.surface;

    final correct = questions[currentIndex].answer;

    if (index == correct) {
      return Colors.green.withOpacity(0.12);
    }

    if (index == selectedIndex) {
      return Colors.red.withOpacity(0.12);
    }

    return AppTheme.surface;
  }

  Color _borderColor(int index) {
    if (!showAnswer) return AppTheme.muted;

    final correct = questions[currentIndex].answer;

    if (index == correct) return Colors.green;
    if (index == selectedIndex) return Colors.red;

    return AppTheme.muted;
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final q = questions[currentIndex];

    return Scaffold(
      backgroundColor: AppTheme.background,

      /// 🌟 APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.surface,
        iconTheme: const IconThemeData(color: AppTheme.textPrimary),
        title: Text(
          "Chapter ${widget.chapterNumber} Test",
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// 📊 PROGRESS BAR
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (currentIndex + 1) / questions.length,
                color: AppTheme.primary,
                backgroundColor: AppTheme.muted,
                minHeight: 8,
              ),
            ),

            const SizedBox(height: 16),

            /// 🧠 QUESTION CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              child: Text(
                "Q${currentIndex + 1}. ${q.question}",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// 📋 OPTIONS
            Expanded(
              child: ListView.builder(
                itemCount: q.options.length,
                itemBuilder: (context, index) {
                  final option = q.options[index];

                  return GestureDetector(
                    onTap: () => checkAnswer(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _optionColor(index),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _borderColor(index),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              option,
                              style: const TextStyle(
                                fontSize: 14.5,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),

                          if (showAnswer)
                            Icon(
                              index == q.answer
                                  ? Icons.check_circle
                                  : (index == selectedIndex
                                      ? Icons.cancel
                                      : null),
                              color: index == q.answer
                                  ? Colors.green
                                  : Colors.red,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /// 🔥 CTA BUTTON
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: showAnswer ? nextQuestion : null,
                child: Text(
                  currentIndex == questions.length - 1
                      ? "Finish Test"
                      : "Next Question",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}