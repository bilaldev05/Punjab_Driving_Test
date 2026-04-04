import 'package:flutter/material.dart';
import 'package:frontend/models/rule.dart';
import 'package:frontend/screens/test_screen.dart';

class ChapterDetailScreen extends StatelessWidget {
  final Rule rule;

  const ChapterDetailScreen({super.key, required this.rule});

  /// Recursive builder for subsections (supports String, List, Map)
  Widget buildSubsections(dynamic subsection, {double indent = 16}) {
    if (subsection == null) return const SizedBox.shrink();

    if (subsection is String) {
      return Padding(
        padding: EdgeInsets.only(left: indent, top: 4, bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("• ", style: TextStyle(fontSize: 16)),
            Expanded(
              child: Text(
                subsection,
                style: const TextStyle(fontSize: 14.5, height: 1.5),
              ),
            ),
          ],
        ),
      );
    } else if (subsection is List) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            subsection.map((s) => buildSubsections(s, indent: indent + 10)).toList(),
      );
    } else if (subsection is Map) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: subsection.entries
            .map((e) => buildSubsections(e.value, indent: indent + 10))
            .toList(),
      );
    }

    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    final sections = rule.sections ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
            ),
          ),
        ),
        title: Text(rule.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: sections.length,
              itemBuilder: (context, index) {
                final section = sections[index];
                final sectionTitle = section['title'] ?? '';
                final sectionNumber = section['section']?.toString() ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 14, bottom: 6),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        "$sectionNumber: $sectionTitle",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.5,
                        ),
                      ),
                    ),
                    if (section['subsections'] != null)
                      buildSubsections(section['subsections'], indent: 20),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: rule.chapterNumber != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TestScreen(
                            chapterNumber: rule.chapterNumber!,
                          ),
                        ),
                      );
                    }
                  : () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Chapter number missing!"),
                        ),
                      );
                    },
              child: const Text(
                "Start Chapter Test",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}