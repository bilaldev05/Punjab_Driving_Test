import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../models/rule.dart';
import '../screens/chapter_details_screen.dart';
import '../services/api_service.dart';

class RuleBookScreen extends StatefulWidget {
  const RuleBookScreen({super.key});

  @override
  State<RuleBookScreen> createState() => _RuleBookScreenState();
}

class _RuleBookScreenState extends State<RuleBookScreen> {
  List<Rule> rules = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadRules();
  }

  void loadRules() async {
    try {
      rules = await ApiService.getRules();
    } catch (e) {
      debugPrint("Error: $e");
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.background,

      /// 🧠 PREMIUM APP BAR
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.surface,
        title: const Text(
          "Chapters",
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// 📘 HEADER INFO CARD
          Container(
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
            child: const Row(
              children: [
                Icon(Icons.menu_book_rounded, color: AppTheme.primary),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "Learn all driving rules step by step. Tap a chapter to start learning.",
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// 📚 CHAPTER LIST
          ListView.builder(
            itemCount: rules.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final rule = rules[index];

              return _ChapterCard(
                index: index + 1,
                title: rule.title,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ChapterDetailScreen(rule: rule),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////
/// 📘 CHAPTER CARD (PREMIUM DESIGN)
//////////////////////////////////////////////////////////////////

class _ChapterCard extends StatelessWidget {
  final int index;
  final String title;
  final VoidCallback onTap;

  const _ChapterCard({
    required this.index,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
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
            /// 🔢 CHAPTER BADGE
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: AppTheme.muted,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  "$index",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// TITLE
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppTheme.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}