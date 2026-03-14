import 'package:flutter/material.dart';
import '../models/traffic_sign.dart';
import '../services/api_service.dart';
import '../language.dart';

class TrafficSignsScreen extends StatefulWidget {
  final int testNumber;
  const TrafficSignsScreen({super.key, this.testNumber = 1});

  @override
  State<TrafficSignsScreen> createState() => _TrafficSignsScreenState();
}

class _TrafficSignsScreenState extends State<TrafficSignsScreen> {
  List<TrafficSign> signs = [];
  int currentIndex = 0;
  bool isLoading = true;
  String? selectedOption;
  bool showExplanation = false;

  @override
  void initState() {
    super.initState();
    loadSigns();
  }

  Future<void> loadSigns() async {
    try {
      // Fetch only 20 signs for the selected test
      signs = await ApiService.getTrafficSigns(
        testNumber: widget.testNumber,
        limit: 20,
      );
    } catch (e) {
      debugPrint("Error loading signs: $e");
    }
    setState(() => isLoading = false);
  }

  void selectOption(String option) {
    if (showExplanation) return;
    setState(() {
      selectedOption = option;
      showExplanation = true;
    });
  }

  void nextSign() {
    if (currentIndex < signs.length - 1) {
      setState(() {
        currentIndex++;
        selectedOption = null;
        showExplanation = false;
      });
    } else {
      // Test finished
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Test Completed!"),
          content: const Text("You have completed this signs test."),
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
    if (option == selectedOption && selectedOption != correct) return Colors.red.shade100;
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final sign = signs[currentIndex];
    double progress = (currentIndex + 1) / signs.length;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ValueListenableBuilder<bool>(
          valueListenable: isUrdu,
          builder: (_, value, __) => Text(
            value ? "ٹریفک کے اشارے" : "Traffic Signs",
          ),
        ),
        actions: [
          IconButton(
            icon: ValueListenableBuilder<bool>(
              valueListenable: isUrdu,
              builder: (_, value, __) => Text(
                value ? "EN" : "اردو",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            onPressed: () => isUrdu.value = !isUrdu.value,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Progress
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: AlwaysStoppedAnimation(Colors.blueAccent),
                  ),
                ),
                const SizedBox(width: 12),
                Text("${(progress * 100).toInt()}%", style: const TextStyle(fontWeight: FontWeight.bold))
              ],
            ),
            const SizedBox(height: 16),

            // Sign Card
            Expanded(
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Sign Image
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            sign.image.startsWith("http") ? sign.image : "${ApiService.baseUrl}/images/${sign.image}",
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) => const Icon(Icons.error, size: 60),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Sign Question
                      ValueListenableBuilder<bool>(
                        valueListenable: isUrdu,
                        builder: (_, value, __) => Text(
                          value ? sign.nameUr : sign.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Options
                      Expanded(
                        child: ListView(
                          children: [
                            optionButton("A", sign.optionA, sign.optionAUr, sign.correctAnswer),
                            optionButton("B", sign.optionB, sign.optionBUr, sign.correctAnswer),
                            optionButton("C", sign.optionC, sign.optionCUr, sign.correctAnswer),
                            optionButton("D", sign.optionD, sign.optionDUr, sign.correctAnswer),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      if (showExplanation)
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: nextSign,
                            child: const Text("Next", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget optionButton(String letter, String option, String optionUr, String correct) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: optionColor(option, correct),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text(letter, style: const TextStyle(color: Colors.white)),
          ),
          title: ValueListenableBuilder<bool>(
            valueListenable: isUrdu,
            builder: (_, value, __) => Text(value ? optionUr : option, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          onTap: () => selectOption(option),
        ),
      ),
    );
  }
}