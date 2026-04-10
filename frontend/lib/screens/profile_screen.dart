import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:frontend/app_theme.dart';
import '../models/user.dart';
import '../services/api_service.dart';

import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    try {
      final firebaseUser = fb.FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) {
        setState(() => isLoading = false);
        return;
      }

      final data = await ApiService.getUserByUid(firebaseUser.uid);

      setState(() {
        user = User.fromJson(Map<String, dynamic>.from(data));
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void logout() async {
    await fb.FirebaseAuth.instance.signOut();

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("User not found")),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          /// 🧠 PREMIUM HEADER (NO GRADIENT)
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
            decoration: const BoxDecoration(
              color: AppTheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                )
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppTheme.muted,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: AppTheme.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user!.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      user!.email,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                /// 📊 STATS ROW (MODERN CARDS)
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: "Total Score",
                        value: user!.totalScore.toString(),
                        icon: Icons.emoji_events,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        title: "Tests",
                        value: user!.testsTaken.toString(),
                        icon: Icons.assignment,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// 📈 PROGRESS SECTION
                const _SectionTitle(
                  title: "Chapter Progress",
                  icon: Icons.bar_chart,
                ),

                const SizedBox(height: 12),

                ...user!.progress.map((p) {
                  double percent = p.total == 0 ? 0 : p.score / p.total;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 12,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chapter ${p.chapter}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),

                        LinearProgressIndicator(
                          value: percent,
                          backgroundColor: AppTheme.muted,
                          color: percent >= 0.8
                              ? AppTheme.success
                              : percent >= 0.5
                                  ? AppTheme.warning
                                  : AppTheme.error,
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "${p.score} / ${p.total}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 20),

                /// 🕒 ACTIVITY SECTION
                const _SectionTitle(
                  title: "Recent Activity",
                  icon: Icons.history,
                ),

                const SizedBox(height: 12),

                ...user!.progress.reversed.take(5).map((p) {
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                    leading: const Icon(
                      Icons.check_circle_outline,
                      color: AppTheme.primary,
                    ),
                    title: Text(
                      "Chapter ${p.chapter} Test",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      "Score: ${p.score}/${p.total}",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  );
                }),

                const SizedBox(height: 30),

                /// 🚪 PREMIUM LOGOUT BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: logout,
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.error,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
          )
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
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}