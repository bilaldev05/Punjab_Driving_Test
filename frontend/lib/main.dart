import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const DrivingTestApp());
}

class DrivingTestApp extends StatelessWidget {
  const DrivingTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Punjab Driving Test',
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}