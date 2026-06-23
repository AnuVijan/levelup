import 'package:flutter/material.dart';
import 'package:levelup/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: "LevelUp",
       theme: ThemeData(
        primarySwatch: Colors.green,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2E7D32),
      foregroundColor: Colors.white,
    ),
       ),
      home: HomeScreen(),
    );
  }
}
