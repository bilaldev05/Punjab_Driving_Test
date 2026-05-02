import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import '../models/questions.dart';

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
  List<Map<String, dynamic>> wrongAnswers = [];

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    final data = await ApiService.getQuestions(widget.chapterNumber);

    setState(() {
      questions = data
          .map<Question>((q) => Question.fromJson(q, shuffle: true))
          .toList();
    });
  }

  void checkAnswer(int index) {
    if (showAnswer) return;

    final isCorrect = index == questions[currentIndex].answer;

    setState(() {
      selectedIndex = index;
      showAnswer = true;

      if (isCorrect) {
        score++;
      }
    });

    submitAnswer(isCorrect, index);
  }

  Future<void> submitAnswer(bool isCorrect, int index) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final question = questions[currentIndex];

    await ApiService.saveResult(
  userId: user.uid,
  chapter: widget.chapterNumber,
  score: isCorrect ? 1 : 0,
  total: 1,
  wrongAnswers: isCorrect
      ? []
      : [
          {
            "question": question.question,
            "correct": question.options[question.answer],
            "user_answer": question.options[index],
            "topic": question.topic
          }
        ],
);
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

    await ApiService.addXp(uid, score * 10);
    await ApiService.updateChapter(
      uid,
      "Chapter ${widget.chapterNumber}",
      score / questions.length,
    );
    await ApiService.updateStreak(uid);

    await ApiService.updateScore(
      uid: uid,
      chapter: widget.chapterNumber,
      score: score,
      total: questions.length,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: const Color(0xFF111827),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.emoji_events,
                size: 70,
                color: Colors.orangeAccent,
              ),
              const SizedBox(height: 12),
              const Text(
                "MISSION COMPLETE",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Score: $score / ${questions.length}",
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: score / questions.length,
                backgroundColor: Colors.white12,
                color: Colors.greenAccent,
              ),
              const SizedBox(height: 10),
              Text(
                "${percentage.toStringAsFixed(1)}% Accuracy",
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Continue",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color _optionColor(int index) {
    if (!showAnswer) return const Color(0xFF111827);

    final correct = questions[currentIndex].answer;

    if (index == correct) return Colors.green.withOpacity(0.15);
    if (index == selectedIndex) return Colors.red.withOpacity(0.15);

    return const Color(0xFF111827);
  }

  Color _borderColor(int index) {
    if (!showAnswer) return Colors.white12;

    final correct = questions[currentIndex].answer;

    if (index == correct) return Colors.greenAccent;
    if (index == selectedIndex) return Colors.redAccent;

    return Colors.white12;
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0B0F1A),
        body: Center(
          child: CircularProgressIndicator(color: Colors.orangeAccent),
        ),
      );
    }

    final q = questions[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "CHAPTER ${widget.chapterNumber}",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 14,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (currentIndex + 1) / questions.length,
                backgroundColor: Colors.white12,
                color: Colors.orangeAccent,
                minHeight: 8,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Text(
                "Q${currentIndex + 1}. ${q.question}",
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.4,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: q.options.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => checkAnswer(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _optionColor(index),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: _borderColor(index),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              q.options[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.5,
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
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: showAnswer ? nextQuestion : null,
                child: Text(
                  currentIndex == questions.length - 1
                      ? "FINISH MISSION"
                      : "NEXT QUESTION",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
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