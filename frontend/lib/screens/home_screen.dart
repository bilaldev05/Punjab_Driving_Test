import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/ai_coach_screen.dart';
import 'package:frontend/screens/survival_screen.dart';
import 'package:frontend/services/api_service.dart';

import 'profile_screen.dart';
import 'rule_book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double progress = 0;
  int xp = 0;
  int streak = 0;
  String continueChapter = "";
  bool loading = true;
  

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }


  

  Future<void> loadDashboard() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final data = await ApiService.getDashboard(user.uid);

      setState(() {
        xp = data["xp"] ?? 0;
        streak = data["streak"] ?? 0;
        progress = (data["progress"] ?? 0).toDouble();
        continueChapter = data["continueChapter"] ?? "";
        loading = false;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  

  Future<void> addXp(int earnedXp) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final updatedXp = await ApiService.addXp(user.uid, earnedXp);

    if (updatedXp != null) {
      setState(() {
        xp = updatedXp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            /// 🧠 HEADER
            _GameHeader(onProfileTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            }),

            const SizedBox(height: 18),

            /// 🚗 DRIVING READINESS HUD (TOP)
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF141E30), Color(0xFF243B55)],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "DRIVING READINESS",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${(progress * 100).toInt()}% READY",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: Colors.white12,
                      color: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            /// 📘 RULE BOOK QUICK ACCESS
            _QuickNavCard(
              onTap: () {
                Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => const RuleBookScreen(
      showMissionButton: false,
    ),
  ),
);
              },
            ),

            

            

            const SizedBox(height: 18),

            /// 💰 XP HUD CARD
          

            /// 🔥 STATS
            Row(
              children: [
                Expanded(
                  child: _HudCard(
                    title: "STREAK",
                    value: "$streak 🔥",
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _HudCard(
                    title: "XP LEVEL",
                    value: "$xp",
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

           
            _MissionCard(
              chapter: continueChapter,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RuleBookScreen()),
                ).then((_) => loadDashboard());
              },
            ),

            const SizedBox(height: 20),

            const Text(
              "GAME MODES",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                letterSpacing: 2,
              ),
            ),

            const SizedBox(height: 12),

            
           _GameModeCard(
  title: "RULE BATTLE",
  subtitle: "Train your driving instincts",
  icon: Icons.menu_book_rounded,
  color: Colors.greenAccent,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const RuleBookScreen(
          showMissionButton: true, 
        ),
      ),
    );
  },
),

            const SizedBox(height: 12),

            
            _GameModeCard(
              title: "SURVIVAL MODE",
              subtitle: "3 lives • endless challenge",
              icon: Icons.flash_on,
              color: Colors.orangeAccent,
              glow: true,
              onTap: () async {
                final result = await Navigator.push<int>(
                  context,
                  MaterialPageRoute(builder: (_) => const SurvivalScreen()),
                );

                if (result != null && result > 0) {
                  await addXp(result);
                  await loadDashboard();
                }
              },
            ),

            const SizedBox(height: 12),

            
            _GameModeCard(
              title: "SIGN CHALLENGE",
              subtitle: "Learn road signs visually",
              icon: Icons.traffic,
              color: Colors.purpleAccent,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Coming soon 🚧")),
                );
              },
            ),
 const SizedBox(height: 12),

           _GameModeCard(
  title: "AI COACH",
  subtitle: "Personalized driving guidance",
  icon: Icons.psychology,
  color: Colors.deepPurpleAccent,
  glow: true,
  onTap: () {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AiCoachScreen(uid: user.uid),
      ),
    );
  },
),

          ],
        ),
      ),
    );
  }
}
class _GameHeader extends StatelessWidget {
  final VoidCallback onProfileTap;

  const _GameHeader({required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DRIVING QUEST",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            Text(
              "Level up your driving skills",
              style: TextStyle(color: Colors.white60, fontSize: 12),
            ),
          ],
        ),
        GestureDetector(
          onTap: onProfileTap,
          child: const CircleAvatar(
            backgroundColor: Colors.white10,
            child: Icon(Icons.person, color: Colors.white),
          ),
        )
      ],
    );
  }
}


class _XPCard extends StatelessWidget {
  final int xp;
  final double progress;

  const _XPCard({required this.xp, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1F1C2C), Color(0xFF928DAB)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("TOTAL XP",
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 6),
          Text(
            "$xp XP",
            style: const TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white12,
              color: Colors.orangeAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class _HudCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;

  const _HudCard({
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white60, fontSize: 12)),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  final String chapter;
  final VoidCallback onTap;

  const _MissionCard({
    required this.chapter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            const Icon(Icons.play_arrow, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                chapter,
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GameModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final bool glow;

  const _GameModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
    this.glow = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.25),
              Colors.black54,
            ],
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: glow
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  Text(subtitle,
                      style: const TextStyle(
                          color: Colors.white60, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                color: Colors.white30, size: 14),
          ],
        ),
      ),
    );
  }
}
class _QuickNavCard extends StatelessWidget {
  final VoidCallback onTap;

  const _QuickNavCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white10,
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: const [
            Icon(Icons.menu_book_rounded, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                "Open Rule Book",
                style: TextStyle(color: Colors.white70),
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: Colors.white30, size: 14),
          ],
        ),
      ),
    );
  }

  
}
