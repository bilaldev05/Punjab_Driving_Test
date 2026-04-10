import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import '../app_theme.dart';
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
   // 🔥 MUST ADD THIS
}


 
 Future<void> loadDashboard() async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final data = await ApiService.getDashboard(user.uid);

    setState(() {
      xp = data["xp"];
      streak = data["streak"];
      progress = data["progress"];
      continueChapter = data["continueChapter"];
      loading = false;
    });
  } catch (e) {
    print("Error: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            /// 🧠 HEADER
            _Header(onProfileTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            }),

            const SizedBox(height: 16),

            /// 📊 PROGRESS
            _ProgressCard(progress: progress),

            const SizedBox(height: 16),

            /// 🔥 STATS
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    title: "XP",
                    value: "$xp",
                    icon: Icons.star,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    title: "Streak",
                    value: "$streak 🔥",
                    icon: Icons.local_fire_department,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// 🎯 CONTINUE LEARNING (NOW FUNCTIONAL)
            _ContinueCard(
  chapter: continueChapter,
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const RuleBookScreen()),
    ).then((_) => loadDashboard()); // 🔥 refresh after return
  },
),
            const SizedBox(height: 20),

            /// 🚗 FEATURE
            _FeatureCard(
              title: "Rule Book",
              subtitle: "Learn traffic rules in a simple way",
              icon: Icons.menu_book_rounded,
              color: AppTheme.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RuleBookScreen()),
                );
              },
            ),

            const SizedBox(height: 20),

            /// 📘 PRACTICE SECTION
            const _SectionTitle(
              title: "Practice Mode",
              icon: Icons.school,
            ),

            const SizedBox(height: 12),

            _ActionCard(
              title: "Rules Practice",
              subtitle: "Test your traffic rule knowledge",
              icon: Icons.rule_folder,
              color: AppTheme.primary,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RuleBookScreen()),
                );
              },
            ),

            const SizedBox(height: 12),

            _ActionCard(
              title: "Signs Practice",
              subtitle: "Learn road signs visually",
              icon: Icons.traffic,
              color: AppTheme.secondary,
              onTap: () {
                // TODO: Add Signs Screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Coming soon 🚧")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////
/// 🧠 HEADER
//////////////////////////////////////////////////////////////////

class _Header extends StatelessWidget {
  final VoidCallback onProfileTap;

  const _Header({required this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Punjab Driving Test",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Learn • Practice • Pass",
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),

        InkWell(
          onTap: onProfileTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(color: Color(0x0D000000), blurRadius: 10),
              ],
            ),
            child: const Icon(Icons.person, color: AppTheme.primary),
          ),
        ),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////////
/// 📊 PROGRESS CARD
//////////////////////////////////////////////////////////////////

class _ProgressCard extends StatelessWidget {
  final double progress;

  const _ProgressCard({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Driving Readiness",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              color: AppTheme.primary,
              backgroundColor: AppTheme.muted,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "${(progress * 100).toInt()}% ready for driving test",
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////
/// 🎯 CONTINUE CARD
//////////////////////////////////////////////////////////////////

class _ContinueCard extends StatelessWidget {
  final String chapter;
  final VoidCallback onTap;

  const _ContinueCard({
    required this.chapter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(Icons.play_circle_fill,
                color: AppTheme.primary, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Continue Learning",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    chapter,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////
/// 📊 STATS CARD
//////////////////////////////////////////////////////////////////

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primary),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////
/// 🚗 FEATURE CARD
//////////////////////////////////////////////////////////////////

class _FeatureCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(color: Color(0x0D000000), blurRadius: 12),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 13, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////
/// 🧭 SECTION TITLE
//////////////////////////////////////////////////////////////////

class _SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const _SectionTitle({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

//////////////////////////////////////////////////////////////////
/// 🎯 ACTION CARD
//////////////////////////////////////////////////////////////////

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x0D000000), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(subtitle,
                      style: const TextStyle(
                          fontSize: 12, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 14),
          ],
        ),
      ),
    );
  }
}