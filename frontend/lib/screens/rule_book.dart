import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/rule.dart';
import '../screens/chapter_details_screen.dart';
import '../services/api_service.dart';

class RuleBookScreen extends StatefulWidget {
  final bool showMissionButton;

  const RuleBookScreen({
    super.key,
    this.showMissionButton = true,
  });

  @override
  State<RuleBookScreen> createState() => _RuleBookScreenState();
}

class _RuleBookScreenState extends State<RuleBookScreen> {
  List<Rule> rules = [];
  bool isLoading = true;
  List<dynamic> chapterProgress = [];
  bool isUnlocked = false;
  List<int> unlockedChapters = [];

  @override
  void initState() {
    super.initState();
    loadRules();

    if (widget.showMissionButton) {
      loadUnlockStatus();
    }
  }

  void loadRules() async {
    try {
      rules = await ApiService.getRules();
    } catch (e) {
      debugPrint("Error: $e");
    }
    setState(() => isLoading = false);
  }

  void loadUnlockStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final result = await ApiService.getUnlockedChapters(user.uid);

    setState(() {
      unlockedChapters = List<int>.from(result);
    });
  }

  bool isChapterLocked(int index) {
    if (!widget.showMissionButton) return false;

    final chapterNumber = index + 1;
    return !unlockedChapters.contains(chapterNumber);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0B0F1A),
        body: Center(
          child: CircularProgressIndicator(color: Colors.orangeAccent),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),

      appBar: AppBar(
        backgroundColor: const Color(0xFF111827),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "RULE CHAPTERS",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            fontSize: 16,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// 📘 HEADER
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1F1C2C), Color(0xFF928DAB)],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              widget.showMissionButton
                  ? "Complete Chapter 2 test to unlock Rule Battle mode progression."
                  : "Read all rules freely. No restrictions in Study Mode.",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                height: 1.4,
              ),
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
              final locked = isChapterLocked(index);

              return _ChapterCard(
                index: index + 1,
                title: rule.title,
                locked: locked,
                onTap: locked
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("🔒 Chapter locked!"),
                          ),
                        );
                      }
                    : () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChapterDetailScreen(
                              rule: rule,
                              showMissionButton: widget.showMissionButton,
                            ),
                          ),
                        );

                        // ✅ REFRESH AFTER RETURN
                        loadUnlockStatus();
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
/// 🎮 CHAPTER CARD
//////////////////////////////////////////////////////////////////

class _ChapterCard extends StatelessWidget {
  final int index;
  final String title;
  final VoidCallback onTap;
  final bool locked;

  const _ChapterCard({
    required this.index,
    required this.title,
    required this.onTap,
    this.locked = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF111827),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                Container(
                  height: 46,
                  width: 46,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.greenAccent, Colors.teal],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      "$index",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.white30,
                ),
              ],
            ),
          ),

          if (locked)
            Positioned.fill(
              child: Container(
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}