import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import '../models/rule.dart';
import '../screens/test_screen.dart';

class ChapterDetailScreen extends StatelessWidget {
  final Rule rule;
  final bool showMissionButton;

  const ChapterDetailScreen({
    super.key,
    required this.rule,
    this.showMissionButton = true,
  });

  
  Widget buildSubsections(dynamic subsection) {
    if (subsection == null) return const SizedBox.shrink();

    if (subsection is String) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "• ",
              style: TextStyle(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                subsection,
                style: const TextStyle(
                  fontSize: 14.5,
                  height: 1.6,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (subsection is List) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: subsection.map((e) => buildSubsections(e)).toList(),
      );
    } else if (subsection is Map) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: subsection.values.map((e) => buildSubsections(e)).toList(),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final sections = rule.sections ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),

      
      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          rule.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),

      body: Column(
        children: [
          
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1F1C2C), Color(0xFF928DAB)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: const [
                Icon(Icons.menu_book_rounded, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Study carefully before entering the test. Every rule matters in survival mode.",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: sections.length,
              itemBuilder: (_, index) {
                final section = sections[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF111827),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white10,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x33000000),
                        blurRadius: 10,
                        offset: Offset(0, 6),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Text(
                        "Chapter ${section['section']} • ${section['title']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.greenAccent,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// CONTENT
                      buildSubsections(section['subsections']),
                    ],
                  ),
                );
              },
            ),
          ),

          /// 🎮 START MISSION BUTTON (GAMING CTA)
         if (showMissionButton)
  Padding(
    padding: const EdgeInsets.all(16),
    child: SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        icon: const Icon(Icons.rocket_launch, color: Colors.white),
        label: const Text(
          "START MISSION TEST",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        onPressed: () async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => TestScreen(
        chapterNumber: rule.chapterNumber!,
      ),
    ),
  );

  // 🔥 THIS IS THE FIX (force refresh after test)
  await ApiService.getUnlockedChapters(user.uid);

  Navigator.pop(context, true);
}
      ),
    ),
  ),
        ],
      ),
    );
  }
}