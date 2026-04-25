import 'dart:async';
import 'package:flutter/material.dart';
import '../models/questions.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';

class SurvivalScreen extends StatefulWidget {
  const SurvivalScreen({super.key});

  @override
  State<SurvivalScreen> createState() => _SurvivalScreenState();
}

class _SurvivalScreenState extends State<SurvivalScreen> {
  List<Question> questions = [];

  int currentIndex = 0;
  int lives = 3;
  int score = 0;
  int streak = 0;

  int earnedXp = 0;

  int? selectedIndex;
  bool showAnswer = false;

  int timeLeft = 10;
  Timer? timer;

  bool gameEnded = false;

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  void loadQuestions() async {
    final data = await ApiService.getSurvivalQuestions();

    questions = data
        .map<Question>((q) => Question.fromJson(q))
        .where((q) => q.options.isNotEmpty)
        .toList();

    if (!mounted) return;
    setState(() {});
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timeLeft = 10;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted || gameEnded) return;

      if (timeLeft <= 0) {
        handleWrong();
      } else {
        setState(() => timeLeft--);
      }
    });
  }

  void handleCorrect() {
    timer?.cancel();

    streak++;
    int bonus = streak >= 3 ? 5 : 0;

    score += 10 + bonus;
    earnedXp += 5 + bonus;

    nextQuestion();
  }

  void handleWrong() {
    timer?.cancel();

    lives--;
    streak = 0;

    if (lives <= 0) {
      endGame();
      return;
    }

    nextQuestion();
  }

  void nextQuestion() {
    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;

      if (currentIndex >= questions.length - 1) {
        endGame();
        return;
      }

      setState(() {
        currentIndex++;
        selectedIndex = null;
        showAnswer = false;
      });

      startTimer();
    });
  }

  void selectAnswer(int index) {
    if (showAnswer || gameEnded) return;

    setState(() {
      selectedIndex = index;
      showAnswer = true;
    });

    final correct = questions[currentIndex].answer;

    if (index == correct) {
      handleCorrect();
    } else {
      handleWrong();
    }
  }

  void endGame() async {
    if (gameEnded) return;
    gameEnded = true;

    timer?.cancel();

    final name = await LocalStorageService.getUserName();

    if (name != null) {
      await ApiService.saveSurvivalScore(name: name, score: score);
    }

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: const Color(0xFF111827),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.emoji_events,
                  size: 80, color: Colors.amber),

              const SizedBox(height: 12),

              const Text(
                "MISSION COMPLETE",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 16),

              _resultRow("Score", "$score"),
              _resultRow("XP Earned", "$earnedXp"),
              _resultRow("Best Streak", "$streak 🔥"),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orangeAccent,
                    padding: const EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context, earnedXp);
                  },
                  child: const Text("Continue",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white70)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Color getColor(int index) {
    if (!showAnswer) return const Color(0xFF1F2937);

    final correct = questions[currentIndex].answer;

    if (index == correct) {
      return const Color(0xFF14532D); // green glow
    }

    if (selectedIndex == index) {
      return const Color(0xFF7F1D1D); // red glow
    }

    return const Color(0xFF1F2937);
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0B0F1A),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final q = questions[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        title: const Text("🔥 Survival Mode", style: TextStyle(color: Colors.white),),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// HUD
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    3,
                    (i) => Icon(
                      Icons.favorite,
                      color: i < lives ? Colors.redAccent : Colors.white10,
                    ),
                  ),
                ),
                Text(
                  "Score: $score",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// TIMER BAR
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: timeLeft / 10,
                minHeight: 10,
                backgroundColor: Colors.white10,
                color: Colors.orangeAccent,
              ),
            ),

            const SizedBox(height: 20),

            /// QUESTION CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white10),
              ),
              child: Text(
                q.question,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 18),

            /// OPTIONS
            Expanded(
              child: ListView.builder(
                itemCount: q.options.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => selectAnswer(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: getColor(index),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: Text(
                        q.options[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}