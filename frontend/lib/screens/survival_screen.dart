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
  int xpEarned = 0;
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

  // 🔥 LOAD QUESTIONS
  void loadQuestions() async {
    final data = await ApiService.getSurvivalQuestions();

    questions = data
        .map<Question>((q) => Question.fromJson(q))
        .where((q) => q.options.isNotEmpty)
        .toList();

    if (mounted) {
      setState(() {});
      startTimer();
    }
  }

  // ⏱ TIMER
  void startTimer() {
    timer?.cancel();
    timeLeft = 10;

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;

      if (timeLeft <= 0) {
        handleWrong();
      } else {
        setState(() => timeLeft--);
      }
    });
  }

  // ✅ CORRECT ANSWER
  void handleCorrect() {
  timer?.cancel();

  streak++;
  int bonus = streak >= 3 ? 5 : 0;

  score += 10 + bonus;

  earnedXp += 5 + bonus; // ✅ NOW VALID

  nextQuestion();
}

  // ❌ WRONG ANSWER
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

  // 🔁 NEXT QUESTION
  void nextQuestion() {
    Future.delayed(const Duration(milliseconds: 500), () {
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

  // 👆 SELECT ANSWER
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

  // 🏁 END GAME (IMPORTANT FIX)
 void endGame() async {
  if (gameEnded) return;
  gameEnded = true;

  timer?.cancel();

  final name = await LocalStorageService.getUserName();

  if (name != null) {
    await ApiService.saveSurvivalScore(
      name: name,
      score: score,
    );
  }

  if (!mounted) return;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events,
                size: 70, color: Colors.orange),

            const SizedBox(height: 10),

            const Text(
              "Game Over",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text("Score: $score"),
            Text("XP Earned: $earnedXp"), // ✅ FIXED
            Text("Best Streak: $streak 🔥"),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context, earnedXp); // ✅ FIXED
              },
              child: const Text("Continue"),
            )
          ],
        ),
      ),
    ),
  );
}
  // 🎨 COLORS
  Color getColor(int index) {
    if (!showAnswer) return Colors.white;

    final correct = questions[currentIndex].answer;

    if (index == correct) {
      return Colors.green.withOpacity(0.3);
    }

    if (selectedIndex == index) {
      return Colors.red.withOpacity(0.3);
    }

    return Colors.white;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
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
        title: const Text("🔥 Survival Mode"),
        backgroundColor: Colors.blueAccent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// ❤️ LIVES + SCORE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    3,
                    (i) => Icon(
                      Icons.favorite,
                      color: i < lives ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
                Text("Score: $score"),
              ],
            ),

            const SizedBox(height: 10),

            /// ⏱ TIMER
            LinearProgressIndicator(
              value: timeLeft / 10,
              minHeight: 8,
              backgroundColor: Colors.grey.shade300,
              color: Colors.orange,
            ),

            const SizedBox(height: 10),

            /// 🔥 STREAK
            if (streak >= 2)
              Text(
                "🔥 Streak x$streak",
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 20),

            /// QUESTION
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                q.question,
                key: ValueKey(q.question),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// OPTIONS
            ...List.generate(q.options.length, (index) {
              return GestureDetector(
                onTap: () => selectAnswer(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: getColor(index),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Text(q.options[index]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}