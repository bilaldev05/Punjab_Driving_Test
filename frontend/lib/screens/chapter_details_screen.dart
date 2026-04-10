import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import '../app_theme.dart';
import '../models/rule.dart';
import '../screens/test_screen.dart';

class ChapterDetailScreen extends StatelessWidget {
  final Rule rule;

  const ChapterDetailScreen({super.key, required this.rule});

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
                color: AppTheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                subsection,
                style: const TextStyle(
                  fontSize: 14.5,
                  height: 1.6,
                  color: AppTheme.textSecondary,
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
      backgroundColor: AppTheme.background,

      /// 🌟 PREMIUM APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.surface,
        iconTheme: const IconThemeData(color: AppTheme.textPrimary),
        title: Text(
          rule.title,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),

      body: Column(
        children: [
          /// 📘 HEADER CARD
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                )
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.menu_book_rounded,
                    color: AppTheme.primary),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    "Read carefully and understand each rule before attempting the test.",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppTheme.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 📄 CONTENT LIST
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: sections.length,
              itemBuilder: (_, index) {
                final section = sections[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
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

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// SECTION TITLE
                      Text(
                        "${section['section']} • ${section['title']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppTheme.primary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      /// SUBSECTIONS
                      buildSubsections(section['subsections']),
                    ],
                  ),
                );
              },
            ),
          ),

          /// 🔥 PREMIUM CTA BUTTON
         Padding(
  padding: const EdgeInsets.all(16),
  child: SizedBox(
    width: double.infinity,
    height: 52,
    child: ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),

      icon: const Icon(Icons.play_arrow, color: Colors.white),

      onPressed: () async {
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) return;

        if (rule.chapterNumber == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Chapter number missing!"),
            ),
          );
          return;
        }

        // 📘 Update chapter progress (user started chapter)
        await ApiService.updateChapter(
          user.uid,
          "Chapter ${rule.chapterNumber} • ${rule.title}",
          0.1,
        );

        // 🚀 Navigate to test
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TestScreen(
              chapterNumber: rule.chapterNumber!,
            ),
          ),
        );
      },

      label: const Text(
        "Start Chapter Test",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
)
        ],
      ),
    );
  }
}