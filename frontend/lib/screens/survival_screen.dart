import 'dart:async';
import 'package:flip_card/flip_card.dart';
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

  final GlobalKey<FlipCardState> flipCardKey =
      GlobalKey<FlipCardState>();

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

  void nextQuestion() async {
    await Future.delayed(const Duration(milliseconds: 1200));

    if (!mounted) return;

    if (flipCardKey.currentState?.isFront == false) {
      flipCardKey.currentState?.toggleCard();

      await Future.delayed(const Duration(milliseconds: 500));
    }

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
  }

  void selectAnswer(int index) {
    if (showAnswer || gameEnded) return;

    setState(() {
      selectedIndex = index;
      showAnswer = true;
    });

    flipCardKey.currentState?.toggleCard();

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
        backgroundColor: const Color(0xFF111827),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.emoji_events,
                size: 80,
                color: Colors.amber,
              ),

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
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
          Text(
            title,
            style: const TextStyle(color: Colors.white70),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0B0F1A),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final q = questions[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        title: const Text(
          "🔥 Survival Mode",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: List.generate(
                    3,
                    (i) => Icon(
                      Icons.favorite,
                      color: i < lives
                          ? Colors.redAccent
                          : Colors.white10,
                    ),
                  ),
                ),
                Text(
                  "Score: $score",
                  style:
                      const TextStyle(color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 12),

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

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF111827),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white10,
                ),
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

            Expanded(
              child: FlipCard(
                key: flipCardKey,
                flipOnTouch: false,
                speed: 500,

                /// FRONT
                front: ListView.builder(
                  itemCount: q.options.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => selectAnswer(index),
                      child: Container(
                        margin:
                            const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2937),
                          borderRadius:
                              BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white10,
                          ),
                        ),
                        child: Text(
                          q.options[index],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                /// BACK
                back: SingleChildScrollView(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          selectedIndex == q.answer
                              ? Colors.green.withOpacity(0.25)
                              : Colors.red.withOpacity(0.25),
                          Colors.black54,
                        ],
                      ),
                      borderRadius:
                          BorderRadius.circular(18),
                      border: Border.all(
                        color: selectedIndex == q.answer
                            ? Colors.greenAccent
                            : Colors.redAccent,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          selectedIndex == q.answer
                              ? Icons.check_circle
                              : Icons.cancel,
                          size: 80,
                          color: selectedIndex == q.answer
                              ? Colors.greenAccent
                              : Colors.redAccent,
                        ),

                        const SizedBox(height: 16),

                        Text(
                          selectedIndex == q.answer
                              ? "Correct Answer 🎉"
                              : "Wrong Answer ❌",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color:
                                selectedIndex == q.answer
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius:
                                BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Correct Answer",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                q.options[q.answer],
                                style: const TextStyle(
                                  color: Colors.greenAccent,
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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