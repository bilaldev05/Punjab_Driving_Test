import 'package:flutter/material.dart';

import 'traffic_signs_screen.dart';
import 'rule_book.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final Color accentColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Punjab Driving Test',
          style: TextStyle(
            color: Colors.blueAccent.shade700,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.blueAccent.shade700),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.blueAccent.shade100,
              child: const Icon(Icons.person, size: 18, color: Colors.white),
            ),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔥 FEATURE CARD (RULE BOOK)
            _FeatureCard(
              title: "Rule Book",
              subtitle: "Learn all Punjab traffic rules",
              icon: Icons.menu_book_rounded,
              color: Colors.deepPurple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RuleBookScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            /// 📘 RULE TESTS
            Row(
              children: [
                Icon(Icons.rule, color: accentColor, size: 22),
                const SizedBox(width: 8),
                const Text(
                  "Rules Tests",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ...List.generate(10, (index) {
              int testNumber = index + 1;
              return _ProfessionalCard(
                title: "Rules Test $testNumber",
                icon: Icons.rule,
                onTap: () {
                  
                },
                accentColor: accentColor,
                badgeText: "$testNumber",
              );
            }),

            const SizedBox(height: 24),

            /// 🚦 SIGN TESTS
            Row(
              children: [
                const Icon(Icons.traffic, color: Colors.orange, size: 22),
                const SizedBox(width: 8),
                const Text(
                  "Signs Tests",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ...List.generate(10, (index) {
              int testNumber = index + 1;
              return _ProfessionalCard(
                title: "Signs Test $testNumber",
                icon: Icons.traffic,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          TrafficSignsScreen(testNumber: testNumber),
                    ),
                  );
                },
                accentColor: Colors.orange,
                badgeText: "$testNumber",
              );
            }),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////
/// 🔥 FEATURE CARD (TOP BIG CARD)
//////////////////////////////////////////////////////////////////

class _FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
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
        height: 90,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white,
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////////////////////////////////////
/// 💎 PROFESSIONAL LIST CARD
//////////////////////////////////////////////////////////////////

class _ProfessionalCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color accentColor;
  final String badgeText;

  const _ProfessionalCard({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.accentColor,
    required this.badgeText,
  });

  @override
  State<_ProfessionalCard> createState() => _ProfessionalCardState();
}

class _ProfessionalCardState extends State<_ProfessionalCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        height: 60,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isPressed ? 0.05 : 0.1),
              blurRadius: _isPressed ? 3 : 6,
              offset: Offset(0, _isPressed ? 1.5 : 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            CircleAvatar(
              radius: 18,
              backgroundColor: widget.accentColor,
              child: widget.icon == Icons.traffic
                  ? const Icon(Icons.traffic, color: Colors.white, size: 20)
                  : Text(
                      widget.badgeText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: widget.accentColor, size: 16),
            const SizedBox(width: 14),
          ],
        ),
      ),
    );
  }
}