import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zybo_tech_interviewtask/controller/wishlist_controller.dart';
import 'package:zybo_tech_interviewtask/view/login_page/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        
        ChangeNotifierProvider(create: (context) => WishlistController()),
      ],
      child: MaterialApp(
        home: LogIn(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
