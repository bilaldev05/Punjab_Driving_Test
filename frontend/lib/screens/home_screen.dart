import 'package:flutter/material.dart';
import 'practice_test_screen.dart';
import 'traffic_signs_screen.dart';
import 'mock_exam_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Punjab Driving Test')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              ElevatedButton(
                child: const Text("Practice Test"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PracticeTestScreen()),
                  );
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                child: const Text("Mock Exam"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MockExamScreen()),
                  );
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                child: const Text("Traffic Signs"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TrafficSignsScreen()),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}