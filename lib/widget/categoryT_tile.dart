import 'package:flutter/material.dart';
import 'package:omnicart/constant/text_style.dart';
import 'package:omnicart/screens/home_screen.dart';
import 'package:omnicart/screens/product_category_screen.dart';

class CategorytTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const CategorytTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryProductsScreen(category: title),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: 15.0,
          left: 15,
          top: 10,
          bottom: 10,
        ),
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: BoxBorder.all(color: Colors.grey.shade300),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(icon, color: Colors.green, size: 30),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: AppTextStyle.avgmain),
                    SizedBox(height: 5),
                    Text(subtitle, style: AppTextStyle.submain),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
