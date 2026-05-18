import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';

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
        backgroundColor: Color(0xFF0B0F1A),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (user == null) {
      return const Scaffold(
        backgroundColor: Color(0xFF0B0F1A),
        body: Center(child: Text("User not found", style: TextStyle(color: Colors.white))),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0B0F1A),
      body: Column(
        children: [

          
          Container(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF141E30), Color(0xFF243B55)],
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white10,
                  child: Icon(Icons.person, color: Colors.white),
                ),

                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user!.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user!.email,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [

                
                Row(
                  children: [
                    Expanded(
                      child: _HudCard(
                        title: "TOTAL SCORE",
                        value: user!.totalScore.toString(),
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _HudCard(
                        title: "TESTS",
                        value: user!.testsTaken.toString(),
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                
                const Text(
                  "CHAPTER PROGRESS",
                  style: TextStyle(
                    color: Colors.white70,
                    letterSpacing: 2,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 12),

                ...user!.progress.map((p) {
                  double percent = p.total == 0 ? 0 : p.score / p.total;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "CHAPTER ${p.chapter}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: percent,
                            minHeight: 8,
                            backgroundColor: Colors.white12,
                            color: percent >= 0.8
                                ? Colors.greenAccent
                                : percent >= 0.5
                                    ? Colors.orangeAccent
                                    : Colors.redAccent,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "${p.score} / ${p.total}",
                          style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 20),

               
                const Text(
                  "RECENT ACTIVITY",
                  style: TextStyle(
                    color: Colors.white70,
                    letterSpacing: 2,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 12),

                ...user!.progress.reversed.take(5).map((p) {
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.check_circle, color: Colors.greenAccent),
                    title: Text(
                      "Chapter ${p.chapter} Completed",
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Score: ${p.score}/${p.total}",
                      style: const TextStyle(color: Colors.white60),
                    ),
                  );
                }),

                const SizedBox(height: 30),

                /// 🚪 LOGOUT BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: logout,
                    icon: const Icon(Icons.logout),
                    label: const Text("LOGOUT"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(vertical: 14),
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

/// 🎮 HUD CARD
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
          Text(
            title,
            style: const TextStyle(color: Colors.white60, fontSize: 11),
          ),
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