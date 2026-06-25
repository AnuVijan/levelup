import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
        backgroundColor: const Color(0xFF66BB6A),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const Text(
              "LevelUp",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Version 1.0",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "LevelUp is a personal growth and productivity app that helps users manage tasks, track streaks, and monitor progress through growth scores.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Features",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text("• Task Management"),
            const Text("• Categories"),
            const Text("• Growth Tracking"),
            const Text("• Daily Streaks"),
            const Text("• Profile Management"),

            const Spacer(),

            const Center(
              child: Text(
                "Made with Flutter ❤️",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 10),

            const Center(
              child: Text(
                "© 2025 LevelUp",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}