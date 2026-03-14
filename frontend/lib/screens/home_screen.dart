import 'package:flutter/material.dart';
import 'practice_test_screen.dart';
import 'traffic_signs_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final Color accentColor = Colors.blueAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 2, // subtle shadow
  centerTitle: true,
  title: Text(
    'Punjab Driving Test',
    style: TextStyle(
      color: Colors.blueAccent.shade700, // accent color
      fontSize: 20,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
    ),
  ),
  iconTheme: IconThemeData(color: Colors.blueAccent.shade700), // back button color
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        radius: 16,
        backgroundColor: Colors.blueAccent.shade100,
        child: const Icon(
          Icons.person,
          size: 18,
          color: Colors.white,
        ),
      ),
    ),
  ],
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(12), // subtle rounded bottom
    ),
  ),
),
      body: SingleChildScrollView(
        
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rules Section
            const SizedBox(height: 10),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PracticeTestScreen(testNumber: testNumber),
                    ),
                  );
                },
                accentColor: accentColor,
                badgeText: "$testNumber",
              );
            }),
            const SizedBox(height: 24),

            // Signs Section
            Row(
              children: [
                Icon(Icons.traffic, color: accentColor, size: 22),
                const SizedBox(width: 8),
                const Text(
                  "Signs Tests",
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
                title: "Signs Test $testNumber",
                icon: Icons.traffic,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TrafficSignsScreen(),
                    ),
                  );
                },
                accentColor: accentColor,
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

/// Clean, professional card without outline
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
        height: 60, // reduced height
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
              radius: 18, // smaller badge
              backgroundColor: widget.accentColor,
              child: widget.icon == Icons.traffic
                  ? const Icon(Icons.traffic, color: Colors.white, size: 20)
                  : Text(
                      widget.badgeText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16, // smaller text
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: widget.accentColor, size: 16),
            const SizedBox(width: 14),
          ],
        ),
      ),
    );
  }
}