import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zybo_tech_interviewtask/controller/wishlist_controller.dart';
import 'package:zybo_tech_interviewtask/utils/constants/string_constants.dart';
import 'package:zybo_tech_interviewtask/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:zybo_tech_interviewtask/view/login_page/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final secureStorage = FlutterSecureStorage();
  String? token = await secureStorage.read(key: StringConstants.token);

  runApp(MyApp(token: token));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.token});
  final String? token;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WishlistController()),
      ],
      child: MaterialApp(
        home: token == null || token!.isEmpty ? LogIn() : BottomNavBar(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
