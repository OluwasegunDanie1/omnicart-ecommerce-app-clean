import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:omnicart/admin/add_product.dart';
import 'package:omnicart/admin/all_orders.dart';
import 'package:omnicart/constant/app_colors.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [AddProduct(), AllOrders()];
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
          Icon(Icons.home_filled, color: Colors.white),
          Icon(Icons.list, color: Colors.white),
        ],
      ),
    );
  }
}
