import 'package:flutter/material.dart';
import 'package:zybo_tech_interviewtask/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:zybo_tech_interviewtask/view/login_page/login_page.dart';
import 'package:zybo_tech_interviewtask/view/otp_screen/otp_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LogIn(),
      debugShowCheckedModeBanner: false,
    );
  }
}
