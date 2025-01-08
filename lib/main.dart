import 'package:flutter/material.dart';
import 'package:zybo_tech_interviewtask/view/bottom_nav_bar/bottom_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
