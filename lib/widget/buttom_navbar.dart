import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:omnicart/constant/app_colors.dart';
import 'package:omnicart/screens/categories.dart';
import 'package:omnicart/screens/home_screen.dart';
import 'package:omnicart/screens/order_screen.dart';
import 'package:omnicart/screens/profile.dart';
import 'package:omnicart/screens/wishlist.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    final screens = const [
      HomeScreen(),
      Categories(),
      OrderScreen(),
      Profile(),
    ];
    return Scaffold(
      body: screens[selectedPage],
      bottomNavigationBar: CurvedNavigationBar(
        index: selectedPage,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        color: AppColors.mainColor,
        height: 55,
        onTap: (index) {
          setState(() {
            selectedPage = index;
          });
        },
        items: [
          Icon(Icons.home_filled, color: Colors.white, size: 30),
          Icon(Icons.list, color: Colors.white, size: 30),
          Icon(Icons.history, color: Colors.white, size: 30),
          Icon(Icons.person, color: Colors.white, size: 30),
        ],
      ),
    );
  }
}
