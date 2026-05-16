import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
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

  final GlobalKey<FlipCardState> flipCardKey = GlobalKey<FlipCardState>();

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

    flipCardKey.currentState?.toggleCard();

    submitAnswer(isCorrect, index);
  }

  Future<void> submitAnswer(bool isCorrect, int index) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final question = questions[currentIndex];

  // 1. per question save
  await ApiService.saveQuestionResult(
  userId: user.uid,
  chapter: widget.chapterNumber,
  score: isCorrect ? 1 : 0,
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
void nextQuestion() async {
  if (currentIndex < questions.length - 1) {
    // 🔥 flip back first
    if (flipCardKey.currentState?.isFront == false) {
      flipCardKey.currentState?.toggleCard();

      // 🔥 wait for flip animation to finish
      await Future.delayed(const Duration(milliseconds: 500));
    }

    // 🔥 now safely load next question
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
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  final uid = user.uid;

  final percentage = score / questions.length;

  await ApiService.saveChapterResult(
    userId: uid,
    chapter: widget.chapterNumber,
    score: score,
    total: questions.length,
    wrongAnswers: wrongAnswers,
  );

  await ApiService.addXp(uid, score * 10);
  await ApiService.updateStreak(uid);

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      backgroundColor: const Color(0xFF111827),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events,
                size: 70, color: Colors.orangeAccent),

            Text(
              "Score: $score / ${questions.length}",
              style: const TextStyle(color: Colors.white70),
            ),

            Text(
              "${(percentage * 100).toStringAsFixed(1)}% Accuracy",
              style: const TextStyle(color: Colors.greenAccent),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("Continue"),
            )
          ],
        ),
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const Scaffold(
        backgroundColor: Color(0xFF0B0F1A),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.orangeAccent,
          ),
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

            const SizedBox(height: 20),

            Expanded(
              child: FlipCard(
                key: flipCardKey,
                flipOnTouch: false,
                speed: 500,

                front: ListView.builder(
                  itemCount: q.options.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => checkAnswer(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111827),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white12,
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
                          ],
                        ),
                      ),
                    );
                  },
                ),

                back: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              selectedIndex == q.answer
                                  ? Colors.green.withOpacity(0.25)
                                  : Colors.red.withOpacity(0.25),
                              Colors.black54,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(18),
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
                              color: selectedIndex == q.answer
                                  ? Colors.greenAccent
                                  : Colors.redAccent,
                              size: 70,
                            ),

                            const SizedBox(height: 14),

                            Text(
                              selectedIndex == q.answer
                                  ? "Correct Answer 🎉"
                                  : "Wrong Answer ❌",
                              style: TextStyle(
                                color: selectedIndex == q.answer
                                    ? Colors.greenAccent
                                    : Colors.redAccent,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 20),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Your Answer",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 12,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    selectedIndex != null
                                        ? q.options[selectedIndex!]
                                        : "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 14),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.greenAccent,
                                ),
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
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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

            const SizedBox(height: 16),

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