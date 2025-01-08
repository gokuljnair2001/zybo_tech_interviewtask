import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:zybo_tech_interviewtask/utils/constants/build_constants.dart';
import 'package:zybo_tech_interviewtask/utils/constants/color_constnats.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentINdex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 3,
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: GNav(
            duration: Duration(milliseconds: 200),
            selectedIndex: currentINdex,
            backgroundColor: Colors.white,
            haptic: false,
            gap: 5,
            padding: const EdgeInsets.all(16),
            tabBackgroundColor: ColorConstnats.primaryColor,
            color: Colors.grey,
            activeColor: Colors.white,
            onTabChange: (value) {
              setState(() {
                currentINdex = value;
              });
            },
            tabs: const [
              GButton(
                icon: HugeIcons.strokeRoundedHome13,
                text: 'Home',
              ),
              GButton(
                icon: HugeIcons.strokeRoundedFavourite,
                text: 'Wish List',
              ),
              GButton(
                icon: Icons.person_2,
                iconActiveColor: Colors.white,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: screenList[currentINdex],
    );
  }
}
