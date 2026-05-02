import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AiCoachScreen extends StatefulWidget {
  final String uid;

  const AiCoachScreen({super.key, required this.uid});

  @override
  State<AiCoachScreen> createState() => _AiCoachScreenState();
}

class _AiCoachScreenState extends State<AiCoachScreen> {
  String? advice;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAdvice();
  }

  Future<void> loadAdvice() async {
    setState(() => isLoading = true);

    try {
      final result = await ApiService.getAiAdvice(widget.uid);

      setState(() {
        advice = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        advice = "⚠️ AI Coach failed to generate advice. Try again.";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF141A2E),
        title: const Text("🤖 AI Driving Coach", style: TextStyle(color: Colors.white),),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// 🔮 HEADER CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurpleAccent.withOpacity(0.35),
                  Colors.black54,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(Icons.psychology, color: Colors.white),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "AI Coach analyzes your XP, mistakes & progress to guide you like a real instructor.",
                    style: TextStyle(
                      color: Colors.white70,
                      height: 1.4,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// 📊 STATUS CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: const [
                Icon(Icons.insights, color: Colors.orangeAccent),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Your performance is being analyzed in real time",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// 🧠 AI RESPONSE
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black54,
                  Colors.deepPurple.withOpacity(0.25),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white12),
            ),
            child: isLoading
                ? const Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 10),
                      Text(
                        "AI Coach is thinking...",
                        style: TextStyle(color: Colors.white70),
                      )
                    ],
                  )
                : Text(
                    advice ?? "",
                    style: const TextStyle(
                      color: Colors.white,
                      height: 1.6,
                      fontSize: 14.5,
                    ),
                  ),
          ),

          const SizedBox(height: 20),

          /// 🔁 REFRESH BUTTON
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: loadAdvice,
              icon: const Icon(Icons.refresh),
              label: const Text("Get New Advice"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// 💡 TIP CARD
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Text(
              "💡 Tip: The AI improves when you complete more tests and make mistakes — it learns your weak areas.",
              style: TextStyle(color: Colors.white60, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}